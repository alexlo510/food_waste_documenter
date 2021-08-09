import 'package:cloud_firestore/cloud_firestore.dart';

class FoodWastePost{
  Timestamp date;
  String? imageURL;
  int? quantity;
  double? latitude;
  double? longitude;

  FoodWastePost({
    required this.date,
    this.imageURL,
    this.quantity,
    this.latitude,
    this.longitude,
  });

  factory FoodWastePost.fromMap(Map<String, dynamic> map){
    return FoodWastePost(
      date: map['date'],
      imageURL: map['imageURL'],
      quantity: map['quantity'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toString() {
    return 'Date: $date, ImageURL: $imageURL, Quality: $quantity, Latitude: $latitude, Longitude: $longitude';
  }
}