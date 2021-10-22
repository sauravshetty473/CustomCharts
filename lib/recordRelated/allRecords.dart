import 'package:customcharts/homeRelated/templateHolder.dart';
import 'package:flutter/material.dart';


class AllRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Template', style: TextStyle(color: Colors.black),),
        elevation: 0,
      ),


      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,

              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sort By', style: TextStyle(
                      fontSize: 15,
                      fontWeight:  FontWeight.w500,
                      color: Colors.black.withAlpha(100)
                  ),),


                  Text('Date created', style: TextStyle(
                      fontSize: 15,
                      fontWeight:  FontWeight.w500,
                      color: Colors.black.withAlpha(100)
                  ),),
                ],
              )
          ),



          ListView(
            children: [
              FileCollectionBlock(title: 'Record One', date: '4th Sep 21', function: (){})
            ],
          ),
        ],
      )
    );
  }
}
