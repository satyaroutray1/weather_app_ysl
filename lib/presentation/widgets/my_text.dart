import 'package:flutter/material.dart';

class MyText extends StatelessWidget {

  final String? text;
  final Color? textColor;
  final double? fontSize;
  final dynamic fontWeight;

  const MyText({super.key,
    this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Text(text!,
        style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize ,
            fontWeight: fontWeight ?? FontWeight.normal
        ),),
    );
  }
}
