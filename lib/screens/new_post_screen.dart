import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/post.dart';

class NewPostEntry extends StatefulWidget {
  late final image;

  NewPostEntry({Key? key, required this.image}) : super(key: key);

  @override
  _NewPostEntryState createState() => _NewPostEntryState();
}

class _NewPostEntryState extends State<NewPostEntry> {
  final formKey = GlobalKey<FormState>();
  final animalPost = AnimalPost();
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
          title: Text(' New Post',
          style: TextStyle(
            fontSize: 25, 
            fontWeight: FontWeight.bold
            )
          ),
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
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.file(widget.image!))),
                    SizedBox(height: 20),
                    Flexible(
                      flex: 1,
                      child: wastedItemField(),
                    ),
                    SizedBox(height: 20),
                    Flexible(
                        flex: 1,
                        child: SizedBox(
                          width: double.infinity,
                          child: submitButton(context),
                        )),
                  ],
                ))));
  }

  Widget wastedItemField() {
    return Semantics(
        child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            // autofocus: true,
            decoration: InputDecoration(
                labelText: "Count",
                labelStyle: TextStyle(fontSize: 30),
                border: OutlineInputBorder()),
            onSaved: (value) {
              animalPost.count = int.parse(value!);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a number';
              } else {
                return null;
              }
            }),
        onTapHint: 'Introduce number of wasted items',
        label: 'Introduce number of wasted items');
  }

  Widget submitButton(BuildContext context) {
    return Semantics(
      child: ElevatedButton(
          child: const Icon(Icons.cloud_upload, size: 50),
          onLongPress: () {
            throw Exception('Presseed too long!!');
          },
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();

              // get date, latitude and longitude
              DateTime date = DateTime.now();
              animalPost.submittedDate = date;
              animalPost.latitude = locationData!.latitude;
              animalPost.longitude = locationData!.longitude;

              // get url of the image
              final url = await getImageUrl();
              animalPost.url = url;

              // upload data to firebasee
              FirebaseFirestore.instance.collection('posts').add({
                'date': animalPost.getDateTimeStamp,
                'latitude': animalPost.getLatitude,
                'longitude': animalPost.getLongitude,
                'quantity': animalPost.getCount,
                'imageURL': animalPost.getUrl
              });
              Navigator.of(context).pop();
            }
          }),
      button: true,
      enabled: true,
      onTapHint: 'Upload the post',
      label: 'Press to upload the post',
    );
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
