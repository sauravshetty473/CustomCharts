
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customcharts/services/authRelated.dart';
import 'package:customcharts/shared/blocks.dart';
import 'modal_bottom.dart';
import 'package:customcharts/shared/row_col_types.dart';
import 'package:flutter/material.dart';




class Record extends StatefulWidget {

  final DocumentSnapshot documentSnapshot;
  final bool isFirstTime;
  Record({this.documentSnapshot, this.isFirstTime = false});

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {

  var columns = <ColumnInput>[];

  var rows = [];

  var grid = [];



  //bool autoRow = false;

  Widget getWidgets(int index){
    if(index == 0 ){ //for col row
      return Row(
        children: [
          Block(isAxis: true, borderBool: BorderBool(top: true), buildContext: context, isResponsive: false,),
          ...columns.asMap().entries.map((e) => Block(isAxis: true, isAxisCol: true,buildContext: context, borderBool: BorderBool(top: true),  rowCol: [rows, columns], rowColNumber: e.key, corrFunction: this.addModifyDeleteRowCol,)),
          Block(addCol: true, buildContext: context, borderBool: BorderBool(bottom: true, top: true), corrFunction: this.addModifyDeleteRowCol,)
        ],
      );
    }
    else if(index == rows.length + 1){         //for last
      return Row(
        children: [
          Block(buildContext: context,addRow: true, borderBool: BorderBool(bottom: true), corrFunction: this.addModifyDeleteRowCol,)
        ],
      );
    }
    else{             //for grid
      return Row(
        children: [
          Block(isAxis: true, isAxisRow: true,buildContext: context, rowCol: [rows, columns], rowColNumber: index-1, corrFunction: this.addModifyDeleteRowCol,),
          ...columns.asMap().entries.map((e) => Block(buildContext: context, row: index-1, col : e.key, grid: this.grid, corrFunction: modifyCell, ))              // All center blocks are rendered non responsive in template Creation
        ],
      );
    }
  }


/*
  void autoRowSwitch(bool value){
    setState(() {
      autoRow = value;
    });
  }
*/


  void modifyCell(input, int row, int col){
    setState(() {
      this.grid[row][col] = input;
    });
  }




  void addModifyDeleteRowCol(input,int index,{bool delete = false}){

    setState(() {
      if(index == null){                               // if not modify or delete, since they require index
        if(input.runtimeType == ColumnInput){
          this.columns.add(input);
          for(List i in grid){
            if(i!=null){
              i.insert(i.length, '');
            }
          }
        }
        else{
          this.rows.add(input);
          this.grid.add(List.generate(columns.length, (index) => ''));
        }
      }
      else{
        if(delete){
          print('\n\n\n$index\n\n\n');
          if(input.runtimeType == ColumnInput){
            columns.removeAt(index);
            for(List i in grid){
              i.removeAt(index);
            }
          }
          else{
            rows.removeAt(index);
            grid.removeAt(index);
          }
        }
        else{
          if(input.runtimeType == ColumnInput){
            columns[index] = input;
          }
          else{
            rows[index] = input;
          }
        }
      }
    });

    print(grid);
  }


  @override
  void initState() {

    if(widget.documentSnapshot !=null){                //data retrieving

      this.rows = widget.documentSnapshot.get('rows');

      (widget.documentSnapshot.get('grid') as Map).values.forEach((element) {
        var mid = [];
        (element as Map).values.forEach((secEl) {
          mid.add(secEl);
        });
        this.grid.add(mid);
      });

      (widget.documentSnapshot.get('columns') as List).forEach((element) {
        columns.add(ColumnInput(title: element['title'], inputType:   InputType.values.firstWhere((e) => e.toString() == element['input']),));
      });
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Create Record', style: TextStyle(color: Colors.black),),
        elevation: 0,



        actions: [
          TextButton(
            child: Text('Save'),
            onPressed: () async{

              await DatabaseService().defaultPerson.collection('Records').add({
                'rows' : this.rows,
                'columns': FieldValue.arrayUnion(
                  ((){
                    var colList =[];
                    for(var i in this.columns){
                      colList.add({
                        'title' : i.title,
                        'input' : i.inputType.toString()
                      });
                    }
                    return colList;
                  }())
                ),
                'grid': ((){
                  var output = {};

                  for(int i = 0 ; i < grid.length ; i++){
                    output[i.toString()] = ((){
                      var secOutput = {};

                      for(int b =0 ; b<grid[i].length ; b++){
                        secOutput[b.toString()] = grid[i][b].toString();
                      }
                      return secOutput;
                    }());
                  }

                  print(output);
                  return output;
                }())
              });
            },
          )
        ],
      ),






      body: SingleChildScrollView(
        child: Column(



          children: [
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 10),

              child: Row(
                children: [
                  Padding(
                    child: Text('Record One',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),

                    padding: EdgeInsets.only(left: 10, right : 10),
                  ),
                  Icon(Icons.edit),
                ],
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: ( MediaQuery.of(context).size.height/(5) ) * (columns.length+2)
                  ),
                  child: ListView.builder(

                    shrinkWrap: true,

                    itemCount: (rows).length + 2,
                    itemBuilder: (context, index){
                      return getWidgets(index);
                    },

                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}



