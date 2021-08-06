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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Wasteagram')
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Image.file(widget.image)
              ),
            ),
            newEntryForm(),
            saveButton(context: context, formKey: formKey, wasteagramPostDTO: wasteagramPostDTO),
          ],
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
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        autofocus: true,
        decoration: InputDecoration(
            labelText: 'Number Of Items',
            border: OutlineInputBorder(),
        ),
        onSaved: (value) {
          wasteagramPostDTO.quantity = int.tryParse(value as String);
        },
        validator: (value) => (value!.isEmpty || int.tryParse(value) == null) ? 'Please enter an integer' :  null,
      ),
    );
  }

  Widget saveButton({required BuildContext context, required dynamic formKey, required WasteagramPostDTO wasteagramPostDTO}) {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState.validate()){
          formKey.currentState.save();
          // do database work here
        }
      }, 
      child: Text('Save'),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[300],
        onPrimary: Colors.black,
      )
    );
  }
  
}
