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