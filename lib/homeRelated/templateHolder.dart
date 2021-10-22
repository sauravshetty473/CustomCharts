import 'dart:math';

import 'package:flutter/material.dart';



class FileCollectionBlock extends StatelessWidget {
  String title;
  String date;
  Function function;
  bool isFile;




  FileCollectionBlock({@required this.title,@required this.date,@required this.function, @required this.isFile});



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20,),
          GestureDetector(
            onTap: function,
            child: Container(
              width: double.infinity,


              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),

              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),


              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height/12,
                  maxHeight: MediaQuery.of(context).size.height/10
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                        aspectRatio: 1,
                      child: Container(
                        color: [Colors.blue.withAlpha(255), Colors.purple.withAlpha(255),Colors.red.withAlpha(255),Colors.deepPurple.withAlpha(255)][Random().nextInt(4)],
                        child: Icon(this.isFile?Icons.upload_file: Icons.folder_open, color: Colors.white,),
                      ),
                    ),


                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(title, style: TextStyle(
                              fontSize: 17,
                              color: Colors.black.withAlpha(255)
                          ),),

                          SizedBox(height: 5,),

                          Text(date, style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withAlpha(150)
                          ),),



                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.keyboard_arrow_down)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
