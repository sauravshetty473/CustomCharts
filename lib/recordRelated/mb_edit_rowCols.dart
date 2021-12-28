import 'package:customcharts/shared/row_col_types.dart';
import 'package:flutter/material.dart';

class ModalBottom extends StatefulWidget {
  final Function addRowCol;
  final bool isRow;

  final String rowText;
  final ColumnInput columnInput;

  final int index;
  final bool isFirst;

  ModalBottom({
    this.addRowCol,
    this.isRow,
    this.rowText,
    this.columnInput,
    this.index,
    this.isFirst = false,
  });

  @override
  _ModalBottomState createState() => _ModalBottomState();
}

class _ModalBottomState extends State<ModalBottom> {
  String rowText = '';
  ColumnInput columnInput;

  Widget colExtras() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: widget.isFirst
                  ? Colors.transparent
                  : Colors.red.withAlpha(100),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Set input type to numbers only'),
                Switch(
                    value: this.columnInput.inputType == InputType.number,
                    onChanged: !widget.isFirst
                        ? null
                        : (boolVal) {
                            setState(() {
                              this.columnInput.inputType =
                                  boolVal ? InputType.number : InputType.string;
                            });
                          }),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    if (widget.rowText != null) {
      this.rowText = widget.rowText;
    }

    if (widget.columnInput != null) {
      this.columnInput = widget.columnInput;
    } else {
      columnInput = ColumnInput(
        title: '',
        inputType: InputType.number,
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
        ),
        (() {
          //something new
          if (widget.index != null) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      TextButton.icon(
                          onPressed: () {
                            widget.isRow
                                ? widget.addRowCol(rowText, widget.index,
                                    delete: true)
                                : widget.addRowCol(columnInput, widget.index,
                                    delete: true);
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.delete),
                          label: Text(''))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        }()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            onChanged: (val) {
              if (widget.isRow) {
                this.rowText = val;
              } else {
                this.columnInput.title = val;
              }
            },
            initialValue: widget.isRow ? this.rowText : this.columnInput.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
            )),
          ),
        ),
        widget.isRow ? SizedBox() : colExtras(),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Text(
                        'Abort',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  widget.isRow
                      ? widget.addRowCol(rowText, widget.index)
                      : widget.addRowCol(columnInput, widget.index);
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Text(
                        (() {
                          if (widget.isRow) {
                            if (widget.index == null) {
                              return 'Add Row';
                            } else {
                              return 'Edit Row';
                            }
                          } else {
                            if (widget.index == null) {
                              return 'Add Column';
                            } else {
                              return 'Edit Col';
                            }
                          }
                        }()),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
