import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../screens/waste_detail_screen.dart';

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
                    style: TextStyle(fontSize: 20)),
                trailing: Text(post['quantity'].toString(),
                    style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => WasteDetail(
                            post: snapshot.data!.docs[index],
                          )));
                }),
            button: true,
            enabled: true,
            onTapHint: 'Select the post to see its details',
            label: 'Select the post to see its details',
          );
        });
  }
}

// Widget wasteList() {
//   return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//         .collection('posts')
//         .orderBy('submitted_date', descending: true)
//         .snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasData &&
//             snapshot.data!.docs != null &&
//             snapshot.data!.docs.length > 0) {
//           return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 var post = snapshot.data!.docs[index];
//                 return ListTile(
//                     title: Text(
//                         '${DateFormat('EEEE, d MMM, yyyy').format(post['submitted_date'].toDate())}',
//                         style: TextStyle(fontSize: 20)),
//                     trailing: Text(
//                       post['wasted_items'].toString(),
//                       style: TextStyle(fontSize: 20)),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (_) => WasteDetail(
//                                 post: snapshot.data!.docs[index],
//                               )));
//                     });
//               });
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       });
// }
