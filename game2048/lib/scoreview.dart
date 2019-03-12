import 'package:flutter/material.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({
    Key key,
    this.title: "title",
    this.score: 0,
  }) : super(key: key);

  final String title;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: 8.0, right: 0.0, bottom: 0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("$title"),
                  Text("$score"),
                ],
              ),
            )),
      ),
    );
  }
}
