import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test('Post created from Map should have appropriate property values', () {
    final date = Timestamp(1, 1);
    final imageURL = 'https://testURL.com';
    final quantity = 1;
    final latitude = 11.1;
    final longitude = 22.2;

    final foodWastePost = FoodWastePost.fromMap({
      'date' : date,
      'imageURL' : imageURL,
      'quantity' : quantity,
      'latitude' : latitude,
      'longitude' : longitude, 
    });

    expect(foodWastePost.date, date);
    expect(foodWastePost.imageURL, imageURL);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);

  });

  test('Post created from Map with null date will fail', () {
    final date = null;
    final imageURL = 'https://testURL.com';
    final quantity = 1;
    final latitude = 11.1;
    final longitude = 22.2;

    final foodWastePost = FoodWastePost.fromMap({
      'date' : date,
      'imageURL' : imageURL,
      'quantity' : quantity,
      'latitude' : latitude,
      'longitude' : longitude, 
    });

    expect(foodWastePost.date, throwsA(anything));

  });
}
