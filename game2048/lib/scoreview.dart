import 'package:flutter/material.dart';

class ScoreView extends StatefulWidget {
  const ScoreView({
    Key key,
    this.title: "title",
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ScoreViewState();
  }
}

class _ScoreViewState extends State<ScoreView> {
  int _score = 0;

  void increaseScore() {
    setState(() {
      _score += 1;
    });
  }

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
                  Text(widget.title),
                  Text(_score.toString()),
                ],
              ),
            )),
      ),
    );
  }
}
