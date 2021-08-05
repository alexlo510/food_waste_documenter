import 'package:flutter/material.dart';
import 'package:wasteagram/screens/wasteagram_list.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      home: WasteagramList(),
    );
  }
}
