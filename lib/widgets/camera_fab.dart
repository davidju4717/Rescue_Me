import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/new_waste_screen.dart';

class PhotoSelectButton extends StatelessWidget {
  late File? image;
  final picker = ImagePicker();

  Future getImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => NewWasteEntry(
              image: image,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.add_a_photo),
        onPressed: () {
          getImage(context);
        });
  }
}
