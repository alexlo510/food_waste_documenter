import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import 'package:wasteagram/db/wasteagram_post_dto.dart';

class NewEntryScreen extends StatefulWidget {

  final File image;

  const NewEntryScreen(
    { Key? key,
      required this.image,
    }
  ) : super(key: key);

  @override
  _NewEntryScreenState createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {

  final formKey = GlobalKey<FormState>();
  final wasteagramPostDTO = WasteagramPostDTO();
  bool loading = false;

  void setLoadingState(){
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Uploading...',
                style: Theme.of(context).textTheme.headline6
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Semantics(
          button: true,
          onTapHint: 'Tap to go to previous page',
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text('Wasteagram')
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            uploadButton(context: context, formKey: formKey, wasteagramPostDTO: wasteagramPostDTO, setLoadingState: setLoadingState)
          ]
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            children: [
              newEntryImage(),
              newEntryForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget newEntryImage(){
    return Flexible(
      child: FractionallySizedBox(
        heightFactor: 0.5,
        widthFactor: 1,
        child: Semantics(
          image: true,
          label: 'A picture of food waste',
          child: Image.file(widget.image)
        )
      ),
    );
  }

  Widget newEntryForm(){
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            numberOfItemsFormField(wasteagramPostDTO: wasteagramPostDTO),
          ],
        ),
      ),
    );
  }

  Widget numberOfItemsFormField({required WasteagramPostDTO wasteagramPostDTO}){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Semantics(
        focused: true,
        textField: true,
        hint: 'Enter the number of wasted items as an integer',
        child: TextFormField(
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline5,
          autofocus: true,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: 'Number of Wasted Items',
          ),
          onSaved: (value) {
            wasteagramPostDTO.quantity = int.tryParse(value as String);
          },
          validator: (value) => (value!.isEmpty || int.tryParse(value) == null) ? 'Please enter an integer' :  null,
        ),
      ),
    );
  }

  Widget uploadButton({required BuildContext context, required dynamic formKey, required WasteagramPostDTO wasteagramPostDTO, required Function setLoadingState}) {
    return Semantics(
      button: true,
      enabled: true,
      onTapHint: 'upload the post to the database',
      child: IconButton(
        iconSize: 100.0,
        onPressed: () async {
          if (formKey.currentState.validate()){
            formKey.currentState.save();
            setLoadingState();
            addDateToWasteagramPostDTO(wasteagramPostDTO);
            await addLocationToWasteagramPostDTO(wasteagramPostDTO);
            await addImageURLToWasteagramPostDTO(wasteagramPostDTO, widget.image);
            addPostToDB(wasteagramPostDTO);
            Navigator.of(context).pop();
          }
        }, 
        icon: Icon(Icons.cloud_upload),
      ),
    );
  }

}

void addDateToWasteagramPostDTO(WasteagramPostDTO wasteagramPostDTO){
  wasteagramPostDTO.date = DateTime.now();
}

Future<void> addImageURLToWasteagramPostDTO(WasteagramPostDTO wasteagramPostDTO, File image) async {
  Reference storageReference =
    FirebaseStorage.instance.ref().child(DateTime.now().toString());
  UploadTask uploadTask = storageReference.putFile(image);
  await uploadTask;
  final url = await storageReference.getDownloadURL();
  wasteagramPostDTO.imageURL = url;
}

Future<void> addLocationToWasteagramPostDTO(WasteagramPostDTO wasteagramPostDTO) async {
  try{
    LocationData locationData;
    var locationService = Location();
    var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }
    var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
          return;
        }
      }
    locationData = await locationService.getLocation();
    wasteagramPostDTO.latitude = locationData.latitude;
    wasteagramPostDTO.longitude = locationData.longitude;
  } catch (exception) {
    print(exception);
    wasteagramPostDTO.latitude = null;
    wasteagramPostDTO.longitude = null;
  }
}

void addPostToDB(WasteagramPostDTO wasteagramPostDTO){
  FirebaseFirestore.instance.collection('posts').add({
    'date': wasteagramPostDTO.date,
    'imageURL': wasteagramPostDTO.imageURL,
    'quantity': wasteagramPostDTO.quantity,
    'latitude': wasteagramPostDTO.latitude,
    'longitude': wasteagramPostDTO.longitude,
  });
}

