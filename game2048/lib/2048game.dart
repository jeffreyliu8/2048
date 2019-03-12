import 'package:flutter/material.dart';
import 'package:game2048/2048gamePiece.dart';
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: SwipeDetector(
          child: new Container(
            color: Colors.redAccent[150],
            child: Table(
              border: TableBorder.all(
                color: Colors.orange,
                width: 8,
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              defaultColumnWidth: IntrinsicColumnWidth(),
              children: [
                TableRow(children: [
                  GamePieceView(),
                  GamePieceView(),
                  GamePieceView(),
                  GamePieceView(),
                ]),
                TableRow(children: [
                  GamePieceView(),
                  GamePieceView(),
                  GamePieceView(),
                  GamePieceView(),
                ]),
                TableRow(children: [
                  GamePieceView(),
                  GamePieceView(),
                  GamePieceView(),
                  GamePieceView(),
                ]),
                TableRow(children: [
                  GamePieceView(),
                  GamePieceView(),
                  GamePieceView(),
                  GamePieceView(),
                ]),
              ],
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
      ),
    );
  }
}
