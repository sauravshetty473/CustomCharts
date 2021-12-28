import 'package:flutter/material.dart';

var supSub = RichText(
  text: TextSpan(
    style: TextStyle(color: Colors.red, fontSize: 16),
    children: [
      TextSpan(
        text: 'Some text ',
      ),
      WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, 4.0),
          child: Text(
            'subscripts',
            style: TextStyle(fontSize: 11),
          ),
        ),
      ),
      WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, -7.0),
          child: Text(
            'supScripts',
            style: TextStyle(fontSize: 11),
          ),
        ),
      ),
      TextSpan(
        text: 'Some text ',
      ),
    ],
  ),
);
