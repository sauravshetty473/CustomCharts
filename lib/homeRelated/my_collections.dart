import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customcharts/homeRelated/templateHolder.dart';
import 'package:customcharts/services/authRelated.dart';
import 'package:flutter/material.dart';



class MyCollections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('My Collections', style: TextStyle(color: Colors.black),),

        actions: [
          TextButton.icon(
            onPressed: (){

            },
            label: Text('Add a collection'),
            icon: Icon(Icons.library_add_outlined),
          )
        ],
      ),



      body: StreamBuilder(
          stream: DatabaseService().userData.doc('1').collection('My Collections').snapshots(),

          builder: (context, snapshot){
            if(snapshot.data == null)
              return Center( child:  Text('Still Loading'));

            return ListView(
              children: (snapshot.data as QuerySnapshot).docs.map((e) => FileCollectionBlock(title: 'Template One', date: '4th Sep 21', function: (){},isFile: false,)).toList(),
            );
          }
      ),
    );
  }
}