import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

class GameView extends StatefulWidget {
  const GameView({
    Key key,
    this.title: "title",
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _GameViewState();
  }
}

class _GameViewState extends State<GameView> {
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
      child: SwipeDetector(
        child: new Container(
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.orange,
          ),
        ),
        onSwipeUp: () {
          print("Up");
        },
        onSwipeDown: () {
          print("down");
        },
        onSwipeLeft: () {
          print("left");
        },
        onSwipeRight: () {
          print("right");
        },
      ),
    );
  }
}
