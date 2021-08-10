import 'package:flutter/material.dart';

class NewWasteEntry extends StatelessWidget {
  static const routeName = '/waste_entry';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      body: CircularProgressIndicator(),
    );
  }
}