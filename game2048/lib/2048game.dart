import 'package:flutter/material.dart';
import 'package:game2048/2048gamePiece.dart';
import 'package:swipedetector/swipedetector.dart';

typedef void ScoreChangedCallback(int score);

class GameView extends StatefulWidget {
  const GameView({
    Key key,
    this.onScoreChanged,
  }) : super(key: key);

  final ScoreChangedCallback onScoreChanged;

  @override
  State<StatefulWidget> createState() {
    return GameViewState();
  }
}

class GameViewState extends State<GameView> {
  int _score = 0;

  void newGame() {
    setState(() {
      _score = 0;
      if (widget.onScoreChanged != null) {
        widget.onScoreChanged(_score);
      }
    });
  }

  void increaseScore() {
    setState(() {
      _score += 1;
      if (widget.onScoreChanged != null) {
        widget.onScoreChanged(_score);
      }
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
            padding: EdgeInsets.all(4.0),
            color: Colors.orange,
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              defaultColumnWidth: IntrinsicColumnWidth(),
              children: [
                TableRow(children: [
                  GameBgPieceView(
                    row: 3,
                    col: 0,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 3,
                    col: 1,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 3,
                    col: 2,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 3,
                    col: 3,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                ]),
                TableRow(children: [
                  GameBgPieceView(
                    row: 2,
                    col: 0,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 2,
                    col: 1,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 2,
                    col: 2,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 2,
                    col: 3,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                ]),
                TableRow(children: [
                  GameBgPieceView(
                    row: 1,
                    col: 0,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 1,
                    col: 1,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 1,
                    col: 2,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 1,
                    col: 3,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                ]),
                TableRow(children: [
                  GameBgPieceView(
                    row: 0,
                    col: 0,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 0,
                    col: 1,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 0,
                    col: 2,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                  GameBgPieceView(
                    row: 0,
                    col: 3,
                    onRendered: (int row, int col, RenderBox r) {
                      printValue(row, col, r);
                    },
                  ),
                ]),
              ],
            ),
          ),
          onSwipeUp: () {
            print("Up");
            increaseScore();
          },
          onSwipeDown: () {
            print("down");
            newGame();
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

  void printValue(int row, int col, RenderBox r) {
    final sizeRed = r.size;
    final positionRed = r.localToGlobal(Offset.zero);
    print("$row $col -- $sizeRed -- $positionRed ");
  }
}
