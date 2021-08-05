import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';

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
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.camera_alt),
        onPressed: () {
          ;
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (content, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.docs != null && snapshot.data.docs.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var post = snapshot.data.docs[index];
                return ListTile(
                  title: Text(post['date']),
                );
              }
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}