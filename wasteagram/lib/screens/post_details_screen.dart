import 'package:flutter/material.dart';
import 'package:wasteagram/models/food_waste_post.dart';

class PostDetailsScreen extends StatelessWidget {

  final FoodWastePost foodWastePost;

  const PostDetailsScreen(
    { Key? key,
      required this.foodWastePost,
    }
  ) : super(key: key);

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
      body: Column(
        children: [
          Text('${foodWastePost.date}'),
        ],
      ),
    );
  }
}