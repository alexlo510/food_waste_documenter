import 'dart:io';
import 'package:flutter/material.dart';

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
            
          ],
        ),
      ),
    );
  }
}