import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final String? fontFamily;
  final Color? color;
  final bool isBold;

  CustomText(
      {this.text, this.fontSize, this.fontFamily, this.color, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
          color: color,
          fontWeight: isBold ? FontWeight.w700 : null),
    );
  }
}
