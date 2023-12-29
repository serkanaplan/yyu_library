import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
   String text;
   Color? color;
   double? size;
   CustomText({required this.text,this.color,this.size,super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: size),);
  }
}
