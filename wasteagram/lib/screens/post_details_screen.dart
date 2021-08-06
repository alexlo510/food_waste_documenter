import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/screens/wasteagram_list_screen.dart';

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
          Text('${DateFormat('EEEE, MMMM d, yyyy').format(foodWastePost.date.toDate())}'),
          Image.network(foodWastePost.imageURL as String),
          Text('Items: ${foodWastePost.quantity}'),
          Text('Location: (${foodWastePost.latitude},${foodWastePost.longitude})'),
        ],
      ),
    );
  }
}

// Future<dynamic> getImage(FoodWastePost foodWastePost) async {
//   return await Image.network(foodWastePost.imageURL as String);
// }