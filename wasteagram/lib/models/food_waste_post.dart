class FoodWastePost{
  int? id; // remove?
  String date;
  String? imageURL;
  int? quantity;
  double? latitude;
  double? longitude;

  FoodWastePost({
    this.id, // remove?
    required this.date,
    this.imageURL,
    this.quantity,
    this.latitude,
    this.longitude,
  });

  factory FoodWastePost.fromJSON(Map<String, dynamic> json){
    return FoodWastePost(
      id: json['id'], //remove? 
      date: json['date'],
      imageURL: json['imageURL'],
      quantity: json['quantity'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  String toString() { //remove id?
    return 'ID: $id, Date: $date, ImageURL: $imageURL, Quality: $quantity, Latitude: $latitude, Longitude: $longitude';
  }
}