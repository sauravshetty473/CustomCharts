import 'package:flutter/material.dart';


enum RowType{
  custom,
  number
}



// ignore: must_be_immutable
class ColumnInput extends StatelessWidget {
  String title;
  InputType inputType;

  ColumnInput({@required this.title, @required this.inputType = InputType.string});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


enum InputType{
  number,
  string,
}

