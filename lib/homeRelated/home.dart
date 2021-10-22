import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customcharts/homeRelated/appBarOption.dart';
import 'package:customcharts/homeRelated/load_record.dart';
import 'package:customcharts/homeRelated/record.dart';
import 'package:customcharts/homeRelated/templateHolder.dart';
import 'package:customcharts/services/authRelated.dart';
import 'package:flutter/material.dart';

import 'my_collections.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int pageIndex = 0 ;
  PageController _pageController;


  void onPageChanged(int index){
    setState(() {
      pageIndex = index;
    });
    _pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }


  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onPageChanged,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.file_present), label: 'Home', ),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'My Collections'),
        ],
      ),

      backgroundColor: Colors.white,



      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          MyRecords(),
          MyCollections(),
        ],
      )
    );
  }
}



class MyRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Home', style: TextStyle(color: Colors.black),),
        elevation: 0,

        actions: [
          TextButton.icon(
            onPressed: (){

            },
            label: Text('Add a record'),
            icon: Icon(Icons.add),
          ),
          TextButton.icon(
            onPressed: (){

            },
            label: Text('Add a collection'),
            icon: Icon(Icons.library_add_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Row(
              children: [
                /*
                  AppBarOption(
                    imageURL: 'assets/images/amogus.png',
                    title: 'New File',
                    function: (){
                      print('hello');
                    },
                  ),

                  AppBarOption(
                    imageURL: 'assets/images/amogus.png',
                    title: 'New Template',
                    function: (){
                      print('hello');
                    },
                  ),

                   */
              ],
            ),
          ),


          Container(
            width: double.infinity,
            color: Colors.white,

            padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20
            ),

            child: Text('My Records', style: TextStyle(
                fontSize: 20,
                fontWeight:  FontWeight.w500,
                color: Colors.black.withAlpha(100)
            ),),
          ),


          Container(
              width: double.infinity,
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
                      fontWeight:  FontWeight.w400,
                      color: Colors.black.withAlpha(100)
                  ),),


                  Text('Date created', style: TextStyle(
                      fontSize: 15,
                      fontWeight:  FontWeight.w400,
                      color: Colors.black.withAlpha(100)
                  ),),
                ],
              )
          ),


          Container(

            child: Row(
              mainAxisSize: MainAxisSize.max,

              children: [
                Expanded(child: SizedBox()),
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Record()),
                    );
                  },

                  child: Icon(Icons.add_box),
                ),
              ],
            ),
          ),




          Expanded(

            child: StreamBuilder(
              stream: DatabaseService().userData.doc('1').collection('Records').snapshots(),

              builder: (context, snapshot){
                if(snapshot.data == null)
                  return Center( child:  Text('Still Loading'));

                return ListView(
                    children: (snapshot.data as QuerySnapshot).docs.map((e) => FileCollectionBlock(title: 'Template One', date: '4th Sep 21', function: (){},isFile: true,)).toList(),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}



