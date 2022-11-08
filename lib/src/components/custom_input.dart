import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(this.text, this.controller, {Key? key}) : super(key: key);

  final String text;
  final TextEditingController controller;
  //button text
  static const textStyleButton = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w900, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: textStyleButton,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        hintText: text,
      ),
    );
  }
}
