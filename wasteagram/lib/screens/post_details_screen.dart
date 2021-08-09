import 'package:intl/intl.dart';
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
        leading: Semantics(
          button: true,
          onTapHint: 'Tap to go to previous page',
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text('Wasteagram')
      ),
      body: SafeArea(
        child: Column(
          children: [
            detailsScreenDate(context),
            Spacer(),
            detailsScreenImage(context),
            Spacer(),
            detailsScreenQuantity(context),
            Spacer(),
            detailsScreenLocation(context),
          ],
        ),
      ),
    );
  }

  Widget detailsScreenDate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${DateFormat('EEEE, MMM d, yyyy').format(foodWastePost.date.toDate())}',
          style: Theme.of(context).textTheme.headline5,
        )
      ],
    );
  }

  Widget detailsScreenImage(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
        heightFactor: 2.5,
        child: Semantics(
          image: true,
          label: 'A picture of food waste',
          child: Image.network(
            foodWastePost.imageURL as String,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child:CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget detailsScreenQuantity(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Items: ${foodWastePost.quantity}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }

  Widget detailsScreenLocation(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Location: (${foodWastePost.latitude},${foodWastePost.longitude})',
        ),
      ],
    );
  }

}