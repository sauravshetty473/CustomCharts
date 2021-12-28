import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customcharts/services/database_related.dart';
import 'record.dart';
import 'package:flutter/material.dart';

class LoadRecord extends StatelessWidget {
  final DocumentReference recordDocReference;

  LoadRecord({this.recordDocReference});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: recordDocReference.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null)
          return Scaffold(
            body: Center(
              child: Text("Still Loading"),
            ),
          );

        return Record(
            documentSnapshot: snapshot.data as DocumentSnapshot,
            isFirstTime: false);
      },
    );
  }
}
