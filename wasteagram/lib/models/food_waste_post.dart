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

  factory FoodWastePost.fromJSON(Map<String, dynamic> json){
    return FoodWastePost(
      date: json['date'],
      imageURL: json['imageURL'],
      quantity: json['quantity'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  String toString() {
    return 'Date: $date, ImageURL: $imageURL, Quality: $quantity, Latitude: $latitude, Longitude: $longitude';
  }
}