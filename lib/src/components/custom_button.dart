import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(this.text, {Key? key}) : super(key: key);

  final String text;
  //button text
  static const textStyleButton = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w900, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(textStyleButton),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: const BorderSide(color: Colors.black, width: 2.0)))),
        child: Padding(padding: const EdgeInsets.all(5.0), child: Text(text)));
  }
}
