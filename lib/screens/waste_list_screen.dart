import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'waste_detail_screen.dart';
import '../widgets/camera_fab.dart';
import '../widgets/waste_list.dart';
import '../screens/new_waste_screen.dart';

// import '../models/food_waste_post.dart';

class WasteListScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _WasteListScreenState createState() => _WasteListScreenState();
}

class _WasteListScreenState extends State<WasteListScreen> {
  File? image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Wasteagram')),
        body: wasteList(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Semantics(
          child: FloatingActionButton(
              child: const Icon(Icons.add_a_photo),
              onPressed: () {
                toFormScreen(context);
              }),
          button: true,
          enabled: true,
          onTapHint: 'Select an image',
        ));
  }

  void toFormScreen(BuildContext context) async {
    final img = await getImage();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => NewWasteEntry(
              image: img,
            )));
  }
}
