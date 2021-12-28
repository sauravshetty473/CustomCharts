import 'package:customcharts/shared/row_col_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModalBottomBlock extends StatefulWidget {
  final int row;
  final int col;
  final String value;
  final Function corrFunction;
  final bool isNum;
  ModalBottomBlock(
      {this.row, this.col, this.corrFunction, this.value, this.isNum = false});

  @override
  _ModalBottomBlockState createState() => _ModalBottomBlockState();
}

class _ModalBottomBlockState extends State<ModalBottomBlock> {
  String value = '';

  @override
  void initState() {
    if (widget.value != null) {
      this.value = widget.value;
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            inputFormatters: widget.isNum
                ? [
                    WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
                  ]
                : [],
            keyboardType: widget.isNum
                ? TextInputType.numberWithOptions(decimal: false, signed: false)
                : TextInputType.text,
            onChanged: (val) {
              this.value = val;
            },
            initialValue: value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
            )),
          ),
        ),
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
                  widget.corrFunction(this.value, widget.row, widget.col);
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
                        'Edit',
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
