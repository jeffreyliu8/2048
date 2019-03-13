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
  List<Widget> v = [];
  List<List<String>> gridState = [
    ["", "T", "", "", "", "", "", "P2"],
    ["", "", "", "T", "", "", "", ""],
    ["B", "T", "", "", "", "B", "", ""],
    ["", "", "", "B", "", "", "", "T"],
    ["", "", "T", "", "", "T", "", ""],
    ["", "", "", "", "", "", "", "B"],
    ["", "", "", "", "T", "", "", ""],
    ["P1", "", "", "", "", "", "T", ""],
  ];

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

  void addTile() {
    setState(() {
      v.add(
        Positioned(
          child: FlutterLogo(),
        ),
      );
    });
  }

  void clearTiles() {
    setState(() {
      v.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    int gridStateLength = gridState.length;
    return SwipeDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            color: Colors.orange,
            child: Stack(
              children: <Widget>[
                GridView.builder(
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridStateLength,
                  ),
                  itemBuilder: _buildGridItems,
                  itemCount: gridStateLength * gridStateLength,
                ),
                Stack(
                  children: v,
                ),
              ],
            ),
          ),
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
        addTile();
      },
      onSwipeRight: () {
        print("right");
        clearTiles();
      },
      swipeConfiguration: SwipeConfiguration(
          verticalSwipeMinVelocity: 15.0,
          verticalSwipeMinDisplacement: 15.0,
          verticalSwipeMaxWidthThreshold: 25.0,
          horizontalSwipeMaxHeightThreshold: 15.0,
          horizontalSwipeMinDisplacement: 15.0,
          horizontalSwipeMinVelocity: 25.0),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = gridState.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return _buildGridItem(x, y);
  }

  Widget _buildGridItem(int x, int y) {
    return GameBgPieceView(
      row: y,
      col: x,
      onRendered: (int row, int col, RenderBox r) {
        printValue(row, col, r);
      },
    );
  }

  void printValue(int row, int col, RenderBox r) {
    final sizeRed = r.size;
    final positionRed = r.localToGlobal(Offset.zero);
    print("$row $col -- $sizeRed -- $positionRed ");
  }
}
