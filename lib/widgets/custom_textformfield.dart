import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final controller;
  final icon;
  final labeltext;
  const CustomTextFormField({required this.controller,required this.icon,required this.labeltext,super.key});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              controller: controller,
              decoration: InputDecoration(
                fillColor: Colors.white12,
                labelText: labeltext,
                prefixIcon: Icon(icon),
                prefixIconColor: Colors.white,
                labelStyle: TextStyle(color: Colors.white),
                focusColor: Colors.white,
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(30)),
                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(30)),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(30)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30)),
              ),

              validator: (value) {
                if (value!.isEmpty) {
                  return 'bu alan boş bırakılamaz';
                }
                return null;
              },
            );
  }
}