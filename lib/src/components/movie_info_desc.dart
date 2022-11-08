import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'custom_button.dart';

class MovieInfoDesc extends StatelessWidget {
  const MovieInfoDesc(
    this.movie, {
    Key? key,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.grey);

    const textStyleTitle = TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.w900, color: Colors.black);

    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //NOTE - title
            Text(movie.splittedTitle, style: textStyleTitle),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            //NOTE - Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Description", style: textStyle),
                Text(movie.link, style: textStyle),
              ],
            ),

            const Padding(padding: EdgeInsets.only(top: 20.0)),
            //NOTE - Button to add to favorites ( outline button black )
            const CustomButton("+ Add to favorites")
          ],
        ));
  }
}
