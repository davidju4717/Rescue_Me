import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/food_waste_post.dart';

class NewWasteEntry extends StatefulWidget {
  static const routeName = '/waste_entry';
  late final image;
  NewWasteEntry({required this.image});

  @override
  _NewWasteEntryState createState() => _NewWasteEntryState();
}

class _NewWasteEntryState extends State<NewWasteEntry> {
  final formKey = GlobalKey<FormState>();
  final foodWastePost = FoodWastePost();
  LocationData? locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wasteagram'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Image.file(widget.image!),
                    ),
                    SizedBox(height: 10),
                    Flexible(
                      flex: 1,
                      child: wastedItemField(),
                    ),
                    SizedBox(height: 10),
                    Flexible(
                      flex: 1,
                      child: submitButton(context),
                    ),
                  ],
                ))));
  }

  Widget wastedItemField() {
    return TextFormField(
        keyboardType: TextInputType.numberWithOptions(),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        autofocus: true,
        decoration: InputDecoration(
            labelText: "Number of Wasted Items", border: OutlineInputBorder()),
        onSaved: (value) {
          foodWastePost.wastedItems = int.parse(value!);
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a number of wasted items';
          } else {
            return null;
          }
        });
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
        child: Text('Upload'),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            DateTime date = DateTime.now();
            foodWastePost.submittedDate = date;
            foodWastePost.latitude = locationData!.latitude;
            foodWastePost.longitude = locationData!.longitude;
            final url = await getImageUrl();
            foodWastePost.url = url;
            print(foodWastePost.toString());

            // upload data to firebasee
            FirebaseFirestore.instance
              .collection('posts')
              .add(
                {'submitted_date': Timestamp.fromDate(foodWastePost.submittedDate),
                 'latitude': foodWastePost.latitude,
                 'longitude': foodWastePost.longitude,
                 'wasted_items': foodWastePost.wastedItems,
                 'url': foodWastePost.url});
            Navigator.of(context).pop();
          }
        });
  }

  Future getImageUrl() async {
    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(widget.image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }
}
