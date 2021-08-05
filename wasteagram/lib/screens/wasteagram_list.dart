import 'package:flutter/material.dart';

class WasteagramList extends StatefulWidget {

  @override
  _WasteagramListState createState() => _WasteagramListState();
}

class _WasteagramListState extends State<WasteagramList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram')
      ),
      floatingActionButton: Align(
        alignment: Alignment(0.1,1.085),
        child: FloatingActionButton(
          child : Icon(Icons.camera_alt),
          onPressed: () {
            ;
          },
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}