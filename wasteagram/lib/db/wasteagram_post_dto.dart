class WasteagramPostDTO{
  DateTime? date;
  String? imageURL;
  int? quantity;
  double? latitude;
  double? longitude;

  WasteagramPostDTO({
    this.date,
    this.imageURL,
    this.quantity,
    this.latitude,
    this.longitude,
  });

  String toString() {
    return 'Date: $date, ImageURL: $imageURL, Quality: $quantity, Latitude: $latitude, Longitude: $longitude';
  }
}