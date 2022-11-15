import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      this.text, this.borderColor, this.fullWidth, this.onPressed,
      {Key? key})
      : super(key: key);

  final String text;
  final bool fullWidth;
  final Color borderColor;
  final Function onPressed;
  //button text
  static const textStyleButton = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w900, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(fullWidth
                ? const Size(double.infinity, 50.0)
                : const Size(50.0, 50.0)),
            textStyle: MaterialStateProperty.all<TextStyle>(textStyleButton),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: borderColor, width: 2.0)))),
        child: Padding(padding: const EdgeInsets.all(5.0), child: Text(text)));
  }
}
