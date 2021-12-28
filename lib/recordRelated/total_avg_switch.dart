import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TotalAvgSwitch extends StatelessWidget {
  Function function;
  bool totalAvg;

  TotalAvgSwitch({@required this.function, @required this.totalAvg});

  TextStyle getTextStyle(bool selected) {
    return TextStyle(
      fontSize: 18,
      color: selected ? Colors.blue : Colors.black.withAlpha(100),
      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
    );
  }

  TextButton getTextButton({bool forTotalNotAvg}) {
    return TextButton(

      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(50, 30),
          alignment: Alignment.centerLeft),
      onPressed: ((this.totalAvg && forTotalNotAvg) ||
              (!this.totalAvg && !forTotalNotAvg))
          ? null
          : this.function,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: forTotalNotAvg
              ? Border(
                  right: BorderSide(
                      style: BorderStyle.solid, color: Colors.black, width: 1),
                )
              : Border(),
        ),
        child: Center(
          child: Text(forTotalNotAvg ? 'Total' : 'Average',
              style: getTextStyle((this.totalAvg && forTotalNotAvg) ||
                  (!this.totalAvg && !forTotalNotAvg))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          getTextButton(forTotalNotAvg: true),
          getTextButton(forTotalNotAvg: false),
        ],
      ),
    );
  }
}
