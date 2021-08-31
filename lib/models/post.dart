import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalPost {
  late String url;
  late double? latitude;
  late double? longitude;
  late DateTime submittedDate;
  late int count;

  String toString() {
    return 'url: $url, latitude: $latitude, longitude: $longitude, submittedDate: $submittedDate, count: $count';
  }

  // getters
  String get getUrl => url;
  double? get getLatitude => latitude;
  double? get getLongitude => longitude;
  DateTime get getDatetime => submittedDate;
  Timestamp get getDateTimeStamp => Timestamp.fromDate(submittedDate);
  int get getCount => count;
}
