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

  test('Test that imageURL, quantity, latitude, and longitude can be null', () {
    final date = Timestamp(1, 1);
    final imageURL = null;
    final quantity = null;
    final latitude = null;
    final longitude = null;

    final foodWastePost = FoodWastePost.fromMap({
      'date' : date,
      'imageURL' : imageURL,
      'quantity' : quantity,
      'latitude' : latitude,
      'longitude' : longitude, 
    });

    expect(foodWastePost.imageURL, isNull);
    expect(foodWastePost.quantity, isNull);
    expect(foodWastePost.latitude, isNull);
    expect(foodWastePost.longitude, isNull);

  });

  test('Test FoodWastePost.fromMap types are expected', () {
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

    expect(foodWastePost.date, isInstanceOf<Timestamp>());
    expect(foodWastePost.imageURL, isInstanceOf<String>());
    expect(foodWastePost.quantity, isInstanceOf<int>());
    expect(foodWastePost.latitude, isInstanceOf<double>());
    expect(foodWastePost.longitude, isInstanceOf<double>());

  });
}
