class FoodWastePost {
  late String url;
  late double? latitude;
  late double? longitude;
  late DateTime submittedDate;
  late int wastedItems;

  String toString() {
    return 'url: $url, latitude: $latitude, longitude: $longitude, submittedDate: $submittedDate, wastedItems: $wastedItems';
  }
}
