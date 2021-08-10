import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'waste_detail_screen.dart';
import '../widgets/camera_fab.dart';
import '../widgets/waste_list.dart';
// import '../models/food_waste_post.dart';

class WasteListScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Wasteagram')),
        body: wasteList(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Semantics(
          child: FloatingActionButton(
              child: const Icon(Icons.add_a_photo), onPressed: () {}),
          button: true,
          enabled: true,
          onTapHint: 'Select an image',
        ));
  }
}

void addPhoto() {}
