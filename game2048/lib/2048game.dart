import 'package:flutter/material.dart';
import 'package:game2048/2048gamePiece.dart';
import 'package:swipedetector/swipedetector.dart';

typedef void ScoreChangedCallback(int score);

class GameView extends StatefulWidget {
  const GameView({
    Key key,
    this.squareLength = 4,
    this.onScoreChanged,
  }) : super(key: key);

  final int squareLength;
  final ScoreChangedCallback onScoreChanged;

  @override
  State<StatefulWidget> createState() {
    return GameViewState(squareLength, onScoreChanged);
  }
}

class GameViewState extends State<GameView> {
  int _squareLength = 0;
  int _score = 0;
  List<Widget> _v = [];
  List<List<RenderBox>> _gridSizes = [];
  ScoreChangedCallback _onScoreChanged;

  GameViewState(this._squareLength, this._onScoreChanged) {
    List<RenderBox> temp = [];
    for (var i = 0; i < _squareLength; i++) {
      temp.add(null);
    }
    for (var i = 0; i < _squareLength; i++) {
      _gridSizes.add(temp);
    }
  }

  void newGame() {
    setState(() {
      _score = 0;
      if (_onScoreChanged != null) {
        _onScoreChanged(_score);
      }
    });
  }

  void increaseScore() {
    setState(() {
      _score += 1;
      if (_onScoreChanged != null) {
        _onScoreChanged(_score);
      }
    });
  }

  void addTile() {
    setState(() {
      _v.add(
        Positioned(
          child: FlutterLogo(),
        ),
      );
    });
  }

  void clearTiles() {
    setState(() {
      _v.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    crossAxisCount: _squareLength,
                  ),
                  itemBuilder: _buildGridItems,
                  itemCount: _squareLength * _squareLength,
                ),
                Stack(
                  children: _v,
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
    int x, y = 0;
    x = (index / _squareLength).floor();
    y = (index % _squareLength);
    return _buildGridItem(x, y);
  }

  Widget _buildGridItem(int x, int y) {
    return GameBgPieceView(
      row: y,
      col: x,
      onRendered: (int row, int col, RenderBox r) {
        final sizeRed = r.size;
        final positionRed = r.localToGlobal(Offset.zero);
        print("$row $col -- $sizeRed -- $positionRed ");
        _gridSizes[row][col] = r;
      },
    );
  }
}
