import 'package:cloud_firestore/cloud_firestore.dart';
import '../recordRelated/load_record.dart';
import '../recordRelated/record.dart';
import 'package:customcharts/homeRelated/file_collection_block.dart';
import 'package:customcharts/services/database_related.dart';
import 'package:customcharts/shared/shared_values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AllRecordsOfCollection extends StatefulWidget {
  final String collection;
  AllRecordsOfCollection({this.collection = 'My Records'});

  @override
  State<AllRecordsOfCollection> createState() => _AllRecordsOfCollectionState();
}

class _AllRecordsOfCollectionState extends State<AllRecordsOfCollection> {
  var list = [
    Colors.blue.withAlpha(255),
    Colors.purple.withAlpha(255),
    Colors.red.withAlpha(255),
    Colors.deepPurple.withAlpha(255)
  ];
  var length;

  @override
  void initState() {
    this.length = list.length;

    // var rng = new Random();
    //
    //
    // for(int i = 0 ; i < 4 ; i++){
    //   var mid = list.removeAt(rng.nextInt(length));
    //   this.list.insert(rng.nextInt(length -1), mid);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.collection,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black.withAlpha(100)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Record(
                            collectionReference: DatabaseService()
                                .userData
                                .doc(user.uid)
                                .collection('My Collections')
                                .doc(widget.collection)
                                .collection('Charts'),
                            isFirstTime: true,
                          )),
                );
              },
              label: Text('Add a record'),
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sort By',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withAlpha(100)),
                    ),
                    Text(
                      'Date created',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withAlpha(100)),
                    ),
                  ],
                )),
            Expanded(
              child: StreamBuilder(
                  stream: DatabaseService()
                      .userData
                      .doc(user.uid)
                      .collection('My Collections')
                      .doc(widget.collection)
                      .collection('Charts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null)
                      return Center(child: Text('Still Loading'));

                    return ListView(
                      children: (snapshot.data as QuerySnapshot)
                          .docs
                          .asMap()
                          .entries
                          .map((e) => FileCollectionBlock(
                                title: e.value.get('title'),
                                date: getDateInFormat(e.value.get('timeStamp')),
                                dateModified: getDateInFormat(
                                    e.value.get('lastModifiedStamp')),
                                function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoadRecord(
                                              recordDocReference:
                                                  e.value.reference,
                                            )),
                                  );
                                },
                                isFile: true,
                                color: this.list[e.key % this.length],
                              ))
                          .toList(),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

String getDateInFormat(Timestamp timestamp) {
  String formattedDate = DateFormat('yyyy-MM-dd | kk:mm')
      .format(DateTime.parse(timestamp.toDate().toString()));

  return formattedDate;
}
