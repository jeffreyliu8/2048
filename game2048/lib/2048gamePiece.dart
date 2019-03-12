import 'package:flutter/material.dart';

class GamePieceView extends StatefulWidget {
  const GamePieceView({
    Key key,
    this.title: "title",
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _GamePieceViewState();
  }
}

class _GamePieceViewState extends State<GamePieceView> {
  int _score = 0;

  void increaseScore() {
    setState(() {
      _score += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: new Container(
          color: Colors.lightGreen,
          child: Text("1")
        ),
      ),
    );
  }
}
