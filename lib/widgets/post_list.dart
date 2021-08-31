import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/post_detail_screen.dart';

class WasteList extends StatelessWidget {
  late final snapshot;

  WasteList({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        var post = snapshot.data!.docs[index];
        return Semantics(
          child: ListTile(
            title: Text(
                '${DateFormat('EEEE, d MMM, yyyy').format(post['date'].toDate())}',
                style: TextStyle(fontSize: 25)),
            trailing: Text(post['quantity'].toString(),
                style: TextStyle(fontSize: 25)),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => PostDetail(
                    post: snapshot.data!.docs[index],
                  )
                )
              );
            }
          ),
          button: true,
          enabled: true,
          onTapHint: 'Select the post to see its details',
          label: 'Select the post to see its details',
        );
      }
    );
  }
}
