import 'package:cloud_firestore/cloud_firestore.dart';
import 'total_avg_switch.dart';
import 'blocks.dart';
import '../shared/default_border_bool.dart';
import 'package:customcharts/shared/row_col_types.dart';
import 'package:flutter/material.dart';

class Record extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final bool isFirstTime;
  final CollectionReference collectionReference;
  Record(
      {this.documentSnapshot,
      this.isFirstTime = false,
      this.collectionReference,
      this.rows,
      this.columns});

  final List rows;
  final List columns;

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  var totalAvg = true;

  var columns = <ColumnInput>[];

  var rows = [];

  var grid = [];

  bool isSaveClicked = false;

  TextEditingController _textEditingController;


  void switchTotalAvg() {
    setState(() {
      totalAvg = !totalAvg;
    });
  }

  void saveData() async {
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    if (widget.isFirstTime) {
      await widget.collectionReference.add({
        'title': _textEditingController.text,
        'timeStamp': myTimeStamp,
        'lastModifiedStamp': myTimeStamp,
        'rows': this.rows,
        'columns': FieldValue.arrayUnion((() {
          var colList = [];
          for (var i in this.columns) {
            colList.add({'title': i.title, 'input': i.inputType.toString()});
          }
          return colList;
        }())),
        'grid': (() {
          var output = {};

          for (int i = 0; i < grid.length; i++) {
            output[i.toString()] = (() {
              var secOutput = {};

              for (int b = 0; b < grid[i].length; b++) {
                secOutput[b.toString()] = grid[i][b].toString();
              }
              return secOutput;
            }());
          }

          return output;
        }())
      });

      Navigator.pop(context);
    } else {
      await widget.documentSnapshot.reference.set({
        'title': _textEditingController.text,
        'timeStamp': widget.documentSnapshot.get('timeStamp'),
        'lastModifiedStamp': myTimeStamp,
        'rows': this.rows,
        'columns': FieldValue.arrayUnion((() {
          var colList = [];
          for (var i in this.columns) {
            colList.add({'title': i.title, 'input': i.inputType.toString()});
          }
          return colList;
        }())),
        'grid': (() {
          var output = {};

          for (int i = 0; i < grid.length; i++) {
            output[i.toString()] = (() {
              var secOutput = {};

              for (int b = 0; b < grid[i].length; b++) {
                secOutput[b.toString()] = grid[i][b].toString();
              }
              return secOutput;
            }());
          }

          return output;
        }())
      });
    }
  }

  String getTotalAvg(int index, bool total) {
    var sum = 0.0;
    var length = grid.length;
    for (int i = 0; i < length; i++) {
      var mid = grid[i][index];
      if (mid != '') {
        sum += double.parse(mid);
      }
    }

    if (total) return sum.toString();

    return (length != 0 ? (sum / length).toStringAsFixed(2) : 0.0).toString();
  }

  Widget getWidgets(int index) {
    if (index == 0) {
      //for column -> row
      return Row(
        children: [
          Block(
            isAxis: true,
            borderBool: BorderBool(top: true),
            buildContext: context,
            isResponsive: false,
            aspectRatio: 4,
          ),
          ...columns.asMap().entries.map((e) => Block(
                isAxis: true,
                isAxisCol: true,
                buildContext: context,
                borderBool: BorderBool(top: true),
                rowCol: [rows, columns],
                rowColNumber: e.key,
                corrFunction: this.addModifyDeleteRowCol,
                isNum: e.value.inputType == InputType.number,
              )),
          Block(
            addCol: true,
            buildContext: context,
            borderBool: BorderBool(bottom: true, top: true),
            corrFunction: this.addModifyDeleteRowCol,
          )
        ],
      );
    } else if (index == rows.length + 1) {           //for last plus in row and avg or sum
      return Row(
        children: [
          Block(
            buildContext: context,
            addRow: true,
            borderBool: BorderBool(bottom: true),
            corrFunction: this.addModifyDeleteRowCol,
            aspectRatio: 4,
          ),
          ...columns
              .asMap()
              .entries
              .map((e) => Block(
                    isResponsive: false,
                    value: e.value.inputType == InputType.number
                        ? getTotalAvg(e.key, this.totalAvg)
                        : 'invalid',
                  ))
              .toList(),
        ],
      );
    } else {                        //for grid
      return Row(
        children: [
          Block(
            isAxis: true,
            isAxisRow: true,
            buildContext: context,
            rowCol: [rows, columns],
            rowColNumber: index - 1,
            corrFunction: this.addModifyDeleteRowCol,
            aspectRatio: 4,
          ),
          ...columns.asMap().entries.map((e) => Block(
                buildContext: context,
                row: index - 1,
                col: e.key,
                grid: this.grid,
                corrFunction: modifyCell,
                isNum: e.value.inputType == InputType.number,
              ))
        ],
      );
    }
  }

  void modifyCell(input, int row, int col) {
    setState(() {
      this.grid[row][col] = input;
    });
  }

  void addModifyDeleteRowCol(input, int index, {bool delete = false}) {
    setState(() {
      if (index == null) {
        // if not modify or delete, since they require index
        if (input.runtimeType == ColumnInput) {
          this.columns.add(input);
          for (List i in grid) {
            if (i != null) {
              i.insert(i.length, '');
            }
          }
        } else {
          this.rows.add(input);
          this.grid.add(List.generate(columns.length, (index) => ''));
        }
      } else {
        if (delete) {
          print('\n\n\n$index\n\n\n');
          if (input.runtimeType == ColumnInput) {
            columns.removeAt(index);
            for (List i in grid) {
              i.removeAt(index);
            }
          } else {
            rows.removeAt(index);
            grid.removeAt(index);
          }
        } else {
          if (input.runtimeType == ColumnInput) {
            columns[index] = input;
          } else {
            rows[index] = input;
          }
        }
      }
    });

    print(grid);
  }

  @override
  void initState() {
    _textEditingController = new TextEditingController();
    _textEditingController.text = 'New Record';

    if (widget.documentSnapshot != null) {

      _textEditingController.text = widget.documentSnapshot.get('title');

      this.rows = widget.documentSnapshot.get('rows');

      (widget.documentSnapshot.get('grid') as Map).values.forEach((element) {
        var mid = [];
        (element as Map).values.forEach((secEl) {
          mid.add(secEl);
        });
        this.grid.add(mid);
      });

      (widget.documentSnapshot.get('columns') as List).forEach((element) {
        columns.add(ColumnInput(
          title: element['title'],
          inputType: InputType.values
              .firstWhere((e) => e.toString() == element['input']),
        ));
      });
    } else if (widget.rows != null) {
      this.rows = widget.rows;
      this.columns = widget.columns;
      this.grid = List.generate(
          rows.length, (index) => List.filled(columns.length, ''));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.isFirstTime ? 'Create a Record' : 'Edit Record',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        actions: [
          !widget.isFirstTime
              ? TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Record(
                                collectionReference: widget.collectionReference,
                                rows: this.rows,
                                columns: this.columns,
                                isFirstTime: true,
                              )),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.copy),
                      Text('Copy'),
                    ],
                  ),
                )
              : SizedBox(),
          TextButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.save),
                Text('Save'),
              ],
            ),
            onPressed: this.isSaveClicked
                ? null
                : () async {
                    setState(() {
                      this.isSaveClicked = true;
                    });

                    await saveData();

                    setState(() {
                      this.isSaveClicked = false;
                    });
                  },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isSaveClicked ? LinearProgressIndicator() : SizedBox(),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 10),
              child: Row(
                children: [
                  Padding(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextFormField(
                        controller: _textEditingController,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TotalAvgSwitch(
                  function: this.switchTotalAvg,
                  totalAvg: this.totalAvg,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: (MediaQuery.of(context).size.height / (10)) * (columns.length+1) + (MediaQuery.of(context).size.height / (5))),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (rows).length + 2,
                    itemBuilder: (context, index) {
                      return getWidgets(index);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
