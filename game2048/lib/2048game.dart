import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game2048/2048gamePiece.dart';
import 'package:game2048/game.dart';
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
  List<double> _gridX = [];
  List<double> _gridY = [];
  Size _tileSize;
  Game game;

  void _boardChangedCallback(List<List<int>> board) {
    drawBoard(board);
  }

  ScoreChangedCallback _onScoreChanged;
  GlobalKey _key = GlobalKey();

  GameViewState(this._squareLength, this._onScoreChanged) {
    for (var i = 0; i < _squareLength; i++) {
      _gridX.add(null);
      _gridY.add(null);
    }
  }

  void newGame() {
    game = Game(_squareLength, _onScoreChanged, _boardChangedCallback);
    game.startGame();
  }

  void drawBoard(List<List<int>> board) {
    setState(() {
      _v.clear();
      for (var col = 0; col < board.length; col++) {
        for (var row = 0; row < board[col].length; row++) {
          _v.add(_buildTile(col, row, board[col][row]));
        }
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
                  key: _key,
                  children: _v,
                ),
              ],
            ),
          ),
        ),
      ),
      onSwipeUp: () {
        game.goTop();
      },
      onSwipeDown: () {
        game.goBottom();
      },
      onSwipeLeft: () {
        game.goLeft();
      },
      onSwipeRight: () {
        game.goRight();
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
    y = (index / _squareLength).floor();
    x = (index % _squareLength);
    return _buildGridItem(x, y);
  }

  Widget _buildGridItem(int col, int row) {
    return GameBgPieceView(
      col: col,
      row: row,
      onRendered: (int row, int col, RenderBox r) {
        if (_tileSize == null) {
          _tileSize = r.size;
        }

        final positionX = r.localToGlobal(Offset.zero).dx;
        final positionY = r.localToGlobal(Offset.zero).dy;
//        print("$col $row -- $positionX  -- $positionY ");

        if (_gridX[col] == null) {
          _gridX[col] = positionX;
        }
        if (_gridY[row] == null) {
          _gridY[row] = positionY;
        }

        if (row == _squareLength - 1 && col == _squareLength - 1) {
          newGame();
        }
      },
    );
  }

  Widget _buildTile(int col, int row, int value) {
    double x = _gridX[col];
    double y = _gridY[row];

    RenderBox selfBox = _key.currentContext.findRenderObject();
    double sx = selfBox.localToGlobal(Offset.zero).dx;
    double sy = selfBox.localToGlobal(Offset.zero).dy;

    if (value > 0) {
//      print("building tile $col $row $value");
      return Positioned(
          width: _tileSize.width,
          height: _tileSize.height,
          top: x - sx,
          left: y - sy,
          child: Container(
            color: Colors.black38,
            child: Center(
              child: Text(
                value.toString(),
              ),
            ),
          ));
    } else {
      return Container();
    }
  }
}
