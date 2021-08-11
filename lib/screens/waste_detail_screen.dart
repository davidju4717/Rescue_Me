import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class WasteDetail extends StatelessWidget {
  static const routeName = '/waste_detail';

  late final post;

  WasteDetail({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Wasteagram')),
        body: SafeArea(child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${DateFormat('EEEE, d MMM, yyyy').format(post['date'].toDate())}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Image.network(post['imageURL']),
              Text('Items: ${post['quantity'].toString()}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text('Location(${post['latitude'].toString()},${post['longitude'].toString()})',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), 
            ]
          )
        )
      )
    ));
  }
}