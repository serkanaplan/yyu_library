import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:slide_to_act/slide_to_act.dart';

// ignore: must_be_immutable
class CustomSliderButton extends StatelessWidget {
  Color color;
  IconData icon;
  Function action;
  String text;
  double width;
  Future<dynamic>? Function()? onsubmit;
  CustomSliderButton({required this.onsubmit,required this.width,required this.text,required this.color,required this.icon,required this.action});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: SlideAction(
        onSubmit: onsubmit,
        innerColor: color,
        sliderButtonIcon: Icon(icon,color: Colors.white,size: 20,),
        outerColor: Colors.white,
        height: 60,
        child:  Container(
          padding: EdgeInsets.only(right: 15),
          alignment: Alignment.centerRight,
          child: Shimmer.fromColors(
            baseColor: Colors.black,
            highlightColor: Colors.white,
            child: Text(
              text,
              style: const TextStyle(
                  color: Color(0xff4a4a4a),
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ),
    );
  }}