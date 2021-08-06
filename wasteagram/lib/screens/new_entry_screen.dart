import 'dart:io';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Wasteagram')
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            uploadButton(context: context, formKey: formKey, wasteagramPostDTO: wasteagramPostDTO)
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
              Flexible(
                child: FractionallySizedBox(
                  heightFactor: 0.5,
                  widthFactor: 1,
                  child: Image.file(widget.image)
                ),
              ),
              newEntryForm(),
            ],
          ),
        ),
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
    );
  }

  Widget uploadButton({required BuildContext context, required dynamic formKey, required WasteagramPostDTO wasteagramPostDTO}) {
    return IconButton(
      iconSize: 100.0,
      onPressed: () async {
        if (formKey.currentState.validate()){
          formKey.currentState.save();
          // do database work here
        }
      }, 
      icon: Icon(Icons.cloud_upload),
    );
  }

}
