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
  num sum = 0;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            sum = 0;
            for (var index = 0; index < snapshot.data!.docs.length; index++) {
              var post = snapshot.data!.docs[index];
              sum += post['quantity'];
            }
            return listScaffold(
              context: context, 
              sum: sum, 
              // body: wasteList());
              body:WasteList(snapshot: snapshot));
          } else {
            return listScaffold(
              context: context, 
              sum: sum, 
              body: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget listScaffold({required BuildContext context, required num sum, required Widget body}) {
    return Scaffold(
        appBar: AppBar(title: Text('Wasteagram-$sum')),
        body: body,
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
          label: 'Press to select an image'
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
