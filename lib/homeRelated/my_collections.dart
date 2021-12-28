import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customcharts/homeRelated/all_records_of_collection.dart';
import 'package:customcharts/homeRelated/file_collection_block.dart';
import 'package:customcharts/services/database_related.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mb_add_collection.dart';

class MyCollections extends StatefulWidget {
  @override
  State<MyCollections> createState() => _MyCollectionsState();
}

class _MyCollectionsState extends State<MyCollections> {
  bool isAddCollectionClicked = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Collections',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                        padding: EdgeInsets.fromLTRB(
                            0, 0, 0, MediaQuery.of(context).viewInsets.bottom),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: ModalBottomAddCollection());
                  });
            },
            label: Text('Add a collection'),
            icon: Icon(Icons.library_add_outlined),
          )
        ],
      ),
      body: StreamBuilder(
          stream: DatabaseService()
              .userData
              .doc(user.uid)
              .collection('My Collections')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return Center(child: Text('Still Loading'));

            return ListView(
              children: (snapshot.data as QuerySnapshot)
                  .docs
                  .map((e) => FileCollectionBlock(
                        title: e.id,
                        date: (() {
                          try {
                            var mid = e.get('timeStamp');
                            return getDateInFormat(mid);
                          } catch (e) {
                            return null;
                          }
                        }()),
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllRecordsOfCollection(
                                      collection: e.id,
                                    )),
                          );
                        },
                        isFile: false,
                      ))
                  .toList(),
            );
          }),
    );
  }
}

