import 'package:flutter/material.dart';




// ignore: must_be_immutable
class AppBarOption extends StatelessWidget {
  String imageURL;
  String title;
  Function function;

  AppBarOption({this.imageURL, this.title, this.function});


  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          GestureDetector(
            onTap: function,
            child: Container(

              height: MediaQuery.of(context).size.width/6,
              width: MediaQuery.of(context).size.width/6,


              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),


              child: Image.asset(imageURL)

            ),
          ),
          SizedBox(height: 10,),
          Text(title, style: TextStyle(fontWeight: FontWeight.w600),),
          SizedBox(height: 10,)
        ],
      ),

      padding: EdgeInsets.all(20),
    );
  }
}
