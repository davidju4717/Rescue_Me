import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test('check if all the getters return the appropiate values', () {

    // create a new post and insert values 
    final post = FoodWastePost();
    post.wastedItems = 3;
    post.latitude = 50.0;
    post.longitude = -50.0;
    post.submittedDate = DateTime.parse('2020-01-01');
    post.url = 'hello';

    // implement all the getters
    final wastedItems = post.getWastedItems;
    final latitude = post.getLatitude;
    final longitude = post.getLongitude;
    final url = post.getUrl;
    final date = post.submittedDate;

    // compare the values 
    expect(wastedItems, 3);
    expect(latitude, 50.0);
    expect(longitude, -50.0);
    expect(url, 'hello');
    expect(date, DateTime.parse('2020-01-01'));
  });

  test('check if getter getDateTimeStamp converts and returns the date in type Timestamp instead of DateTime',() {
    
    // a new post with a date
    final post = FoodWastePost();
    post.submittedDate = DateTime.parse('2020-01-01');

    // get the date of the post in timestamp format
    final dateTimeStamp = post.getDateTimeStamp;

    // check type of the return value and the value itself
    expect(dateTimeStamp.runtimeType, Timestamp);
    expect(dateTimeStamp, Timestamp.fromDate(DateTime.parse('2020-01-01')));
  });
}
