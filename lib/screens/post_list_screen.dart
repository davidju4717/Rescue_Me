import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/post_list.dart';
import '../widgets/drawer.dart';
import 'new_post_screen.dart';

class PostListScreen extends StatefulWidget {
  late final analytics;

  PostListScreen({Key? key, required this.analytics}) : super(key: key);

  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.pets),
          Text(' Rescue Me!',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
          ),
        ]
      )),
      endDrawer: drawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('date', descending: true)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            return WasteList(snapshot: snapshot);
          } else {
            return Center(child: const Icon(Icons.pets));
          }
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Semantics(
        child: FloatingActionButton(
          child: const Icon(Icons.add_a_photo),
          onPressed: () {
            toFormScreen(context);
          }
        ),
        button: true,
        enabled: true,
        onTapHint: 'Select an image',
        label: 'Press to select an image'
      )
    );
  }

  void toFormScreen(BuildContext context) async {
    final img = await getImage();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => NewPostEntry(
          image: img,
        )
      )
    );
  }
}
