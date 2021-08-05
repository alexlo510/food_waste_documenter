import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/models/food_waste_post.dart';

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
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.docs != null && snapshot.data.docs.length > 0) {
            return FoodWastePostsList(context, snapshot);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }

  Widget FoodWastePostsList(BuildContext context, AsyncSnapshot snapshot){
    return ListView.builder(
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, index) {
        FoodWastePost post = FoodWastePost.fromJSON(snapshot.data.docs[index].data());
        return ListTile(
          title: Text('${post.date}'),
          trailing: Text(
            '${post.quantity}',
            style: Theme.of(context).textTheme.headline4,
          ),
        );
      }
    );
  }

}