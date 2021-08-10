import 'package:flutter/material.dart';
import '../models/food_waste_post.dart';
import '../screens/waste_list_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wasteagram'),
          // leading: BackButton(onPressed: () {
          //   Navigator.of(context).pushNamed(WasteListScreen.routeName);
          //   // Navigator.of(context).pop();
          // }
          // )
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.file(widget.image!),
                    SizedBox(height: 10),
                    wastedItemField(),
                    SizedBox(height: 10),
                    submitButton(context),
                  ],
                ))));
  }

  Widget wastedItemField() {
    return TextFormField(
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
        child: Text('Save'),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            // DateTime date = DateTime.now();
            // journalEntryFields.dateTime = date;

            // Navigator.of(context).pushNamed(WasteListScreen.routeName);
            Navigator.of(context).pop();
          }
        });
  }
}
