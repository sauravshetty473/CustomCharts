import 'package:customcharts/homeRelated/modal_bottom_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../homeRelated/modal_bottom.dart';





class Block extends StatefulWidget {


  final bool addRow;
  final bool addCol;
  final bool isAxis;
  final bool isAxisRow;
  final bool isAxisCol;
  final double aspectRatio;
  final double heightDivider;
  BorderBool borderBool;
  final bool isResponsive;


  final int row;
  final int col;
  final List grid;

  final List<List> rowCol;
  final int rowColNumber;

  final Function corrFunction;
  final BuildContext buildContext;



  Block({this.addRow = false,
    this.addCol = false,
    this.isAxis = false, this.isAxisCol = false, this.isAxisRow = false,
    this.aspectRatio = 4,
    this.heightDivider = 20,
    this.borderBool,
    this.isResponsive = true,

    this.row, this.col, this.grid,

    this.rowCol, this.rowColNumber,

    this.corrFunction,

    this.buildContext,

  } ){
    if(this.borderBool ==null){
      this.borderBool = BorderBool();
    }
  }

  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> {

  Widget getWidget(){
    if(widget.addRow) return Center(child: Icon(Icons.add_circle_outline, color: Colors.white,),);
    if(widget.addCol) return Center(child: Icon(Icons.add_circle_outline, color: Colors.white,),);
    if(widget.isAxisRow) return Center(child: Text(widget.rowCol[0][widget.rowColNumber]),);
    if(widget.isAxisCol) return Center(child: Text(widget.rowCol[1][widget.rowColNumber].title),);
    if(widget.grid!=null) return Center(child: Text(widget.grid[widget.row][widget.col]),);

    return null;
  }




  @override
  Widget build(BuildContext context) {


    return Container(
      height: MediaQuery.of(context).size.height/widget.heightDivider,                  //bounded height for aspect ratio
      child: AspectRatio(


        aspectRatio: widget.aspectRatio,

        child: GestureDetector(

          onTap: (){
            if(widget.addRow||widget.addCol){
              showModalBottomSheet(isScrollControlled: true,context: widget.buildContext??context, backgroundColor: Colors.transparent, builder: (BuildContext context){
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).viewInsets.bottom),

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(

                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)

                        )
                    ),

                    child: ModalBottom(isRow: widget.addRow, addRowCol: widget.corrFunction,)
                );
              });
            }
            else if(widget.isAxis&&widget.isResponsive){
              showModalBottomSheet(isScrollControlled: true,context: widget.buildContext??context, backgroundColor: Colors.transparent, builder: (BuildContext context){
                return Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).viewInsets.bottom),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(

                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)

                        )
                    ),

                    child: ModalBottom(isRow: widget.isAxisRow, addRowCol: widget.corrFunction, index: widget.rowColNumber, rowText: widget.isAxisRow?widget.rowCol[0][widget.rowColNumber]:null, columnInput: widget.isAxisCol?widget.rowCol[1][widget.rowColNumber] : null,)
                );
              });
            }
            else if(widget.isResponsive){
              showModalBottomSheet(isScrollControlled: true,context: widget.buildContext??context, backgroundColor: Colors.transparent, builder: (BuildContext context){
                return Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).viewInsets.bottom),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(

                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)

                        )
                    ),

                    child: ModalBottomBlock(corrFunction: widget.corrFunction, row: widget.row, col: widget.col, value: widget.grid[widget.row][widget.col],)
                );
              });
            }
          },

          child: Container(

            decoration: BoxDecoration(
              color: (widget.addCol||widget.addRow||widget.isAxis)?Colors.blue.withAlpha((widget.addCol||widget.addRow)?255:55): Colors.transparent,

              border: Border(

                top: BorderSide(style: BorderStyle.solid, color: widget.borderBool.top?Colors.blue: Colors.transparent, width: 1),
                bottom: BorderSide(style: BorderStyle.solid, color: widget.borderBool.bottom?Colors.blue: Colors.transparent, width: 1),
                left: BorderSide(style: BorderStyle.solid, color: widget.borderBool.left?Colors.blue: Colors.transparent, width: 1),
                right: BorderSide(style: BorderStyle.solid, color: widget.borderBool.right?Colors.blue: Colors.transparent, width: 1),
              )
            ),


            child: getWidget(),
          ),
        ),
      ),
    );
  }
}


class BorderBool{
  bool top;
  bool right;
  bool left;
  bool bottom;

  BorderBool({this.top = false, this.right = true, this.left = false, this.bottom  = true});
}


