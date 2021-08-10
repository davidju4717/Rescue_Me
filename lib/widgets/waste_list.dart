import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../screens/waste_detail_screen.dart';

Widget wasteList() {
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData &&
            snapshot.data!.docs != null &&
            snapshot.data!.docs.length > 0) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var post = snapshot.data!.docs[index];
                return ListTile(
                    title: Text(
                        '${DateFormat('EEEE, d MMM, yyyy').format(post['submitted_date'].toDate())}'),
                    trailing: Text(post['wasted_items'].toString()),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => WasteDetail(
                                post: snapshot.data!.docs[index],
                              )));
                    });
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
}
