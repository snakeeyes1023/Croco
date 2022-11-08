import 'package:flutter/material.dart';

class CustomPlainButton extends StatelessWidget {
  const CustomPlainButton(this.text, this.fullWidth, {Key? key})
      : super(key: key);

  final String text;
  final bool fullWidth;
  //button text
  static const textStyleButton = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w900, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
                fullWidth ? Size(double.infinity, 50.0) : Size(50.0, 50.0)),
            textStyle: MaterialStateProperty.all<TextStyle>(textStyleButton),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: const BorderSide(color: Colors.black, width: 2.0)))),
        child: Padding(padding: const EdgeInsets.all(5.0), child: Text(text)));
  }
}
