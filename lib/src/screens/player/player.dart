import 'package:flutter/material.dart';

///import 'package:neeko/neeko.dart';

class MyPlayer extends StatefulWidget {
  final String url;
  //late VideoControllerWrapper videoControllerWrapper;

  MyPlayer(this.url, {super.key}) {}

  @override
  State<MyPlayer> createState() => _MyPlayer();
}

class _MyPlayer extends State<MyPlayer> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Player"),
      ),
    );
  }
}
