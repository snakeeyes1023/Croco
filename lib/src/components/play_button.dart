import 'package:croco/src/services/favorite_service.dart';
import 'package:croco/src/services/movie_service.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'custom_button.dart';

class PlayButton extends StatefulWidget {
  PlayButton(
    this.onPressed,
    this.isDisabled, {
    Key? key,
  }) : super(key: key);

  final Function onPressed;
  final bool isDisabled;

  @override
  State<PlayButton> createState() => _PlayButton();
}

class _PlayButton extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    sizeAnimation = Tween<double>(begin: 30.0, end: 35.0).animate(controller);

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.grey);

    const textStyleTitle = TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.w900, color: Colors.black);

    return ClipOval(
      child: Material(
        color: Colors.white,
        child: InkWell(
          customBorder: const CircleBorder(
              side: BorderSide(color: Colors.black, width: 2)),
          splashColor: Colors.black, // Splash color
          onTap: () {
            // open movie preview
            widget.isDisabled ? null : widget.onPressed();
          },
          child: SizedBox(
              width: 60,
              height: 60,
              child: Icon(
                Icons.play_arrow,
                color: widget.isDisabled ? Colors.grey : Colors.red,
                size: widget.isDisabled ? 45 : sizeAnimation.value,
              )),
        ),
      ),
    );
  }
}
