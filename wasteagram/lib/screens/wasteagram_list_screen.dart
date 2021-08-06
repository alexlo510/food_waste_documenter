import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/screens/new_entry_screen.dart';
import 'package:wasteagram/screens/post_details_screen.dart';

class WasteagramListScreen extends StatefulWidget {

  @override
  _WasteagramListScreenState createState() => _WasteagramListScreenState();
}

class _WasteagramListScreenState extends State<WasteagramListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram')
      ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.camera_alt),
        onPressed: () async {
          File? image = await getImage();
          if (image != null) {  
            displayNewEntryScreen(context: context, image: image);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.docs != null && snapshot.data.docs.length > 0) {
            return foodWastePostsList(context, snapshot);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }

  Widget foodWastePostsList(BuildContext context, AsyncSnapshot snapshot){
    return ListView.builder(
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, index) {
        FoodWastePost post = FoodWastePost.fromJSON(snapshot.data.docs[index].data());
        return ListTile(
          title: Text(
            '${DateFormat('EEEE, MMMM d, yyyy').format(post.date.toDate())}',
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: Text(
            '${post.quantity}',
            style: Theme.of(context).textTheme.headline4,
          ),
          onTap: () {displayPostDetails(context: context, post: post);},
        );
      }
    );
  }

  Future<dynamic> displayPostDetails({required BuildContext context, required FoodWastePost post}){
    return Navigator.push(context, 
      MaterialPageRoute(builder: (context) => PostDetailsScreen(foodWastePost: post)),
    );
  }

  displayNewEntryScreen({required BuildContext context, required File image}){
    return Navigator.push(context, 
      MaterialPageRoute(builder: (context) => NewEntryScreen(image: image,)),
    );
  }

}

Future<File?> getImage() async {
  try{
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    } else {
        return File(pickedFile.path);
    }
  } catch (exception) {
      return null;
  }
}