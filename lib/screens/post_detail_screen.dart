import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDetail extends StatelessWidget {
  late final post;

  PostDetail({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${DateFormat('EEEE, d MMM, yyyy').format(post['date'].toDate())}',
          style: TextStyle(
            fontSize: 25, 
            fontWeight: FontWeight.bold
          )
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Flexible(
                  flex: 5,
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(post['imageURL']),
                  ),
                ),
                SizedBox(height: 25),
                Flexible(
                  flex: 1,
                  child: Text('Count : ${post['quantity'].toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25)),
                ), 
                SizedBox(height: 25),
                Flexible(
                  flex: 1,
                  child: Text(
                    'Location (${post['latitude'].toString()},${post['longitude'].toString()})',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
                )
              ]
            )
          )
        )
      )
    );
  }
}
