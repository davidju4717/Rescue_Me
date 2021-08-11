import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test('check if latitude getter returns appropiate value', () {
    final post = FoodWastePost();
    post.wastedItems = 3;
    post.latitude = 50.0;
    post.longitude = -50.0;
    post.submittedDate = DateTime.now();
    post.url = 'hello';

    final latitude = post.getLatitude;

    expect(latitude, 50.0);
  });

  test('check if getter getDateTimeStamp converts and returns the date in type Timestamp instead of DateTime', () {
    final post = FoodWastePost();
    post.wastedItems = 3;
    post.latitude = 50.0;
    post.longitude = -50.0;
    post.submittedDate = DateTime.now();
    post.url = 'hello';

    final dateTimeStamp = post.getDateTimeStamp;

    expect(dateTimeStamp.runtimeType, Timestamp);
  });
}
