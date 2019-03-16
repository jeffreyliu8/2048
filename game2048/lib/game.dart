import 'dart:math';

typedef void ScoreChangedCallback(int score);
typedef void BoardChangedCallback(List<List<int>> board);

class Game {
  int _score = 0;
  final int _squareLength;
  final ScoreChangedCallback _onScoreChanged;
  final BoardChangedCallback _onBoardChanged;
  List<List<int>> _board;

  Game(this._squareLength, this._onScoreChanged, this._onBoardChanged) {
    _board = [];

    for (var i = 0; i < _squareLength; i++) {
      List<int> _row = List(_squareLength);
      for (var i = 0; i < _squareLength; i++) {
        _row[i] = 0;
      }
      _board.add(_row);
    }
  }

  void startGame() {
    clear();
    var rng = new Random();
    int col = rng.nextInt(_squareLength);
    int row = rng.nextInt(_squareLength);
    int randomValue = rng.nextInt(2) + 1;
    setTile(col, row, randomValue);
  }

  void clear() {
    for (var i = 0; i < _board.length; i++) {
      for (var j = 0; j < _board[i].length; j++) {
        _board[i][j] = 0;
      }
    }
    notifyBoardChanged();
  }

  void setTile(int x, int y, int value) {
    print("setting $x $y $value");
    _board[y][x] = value;

    printBoard();

    notifyBoardChanged();
  }

  void notifyBoardChanged() {
    if (_onBoardChanged != null) {
      _onBoardChanged(_board);
    }
  }

  bool checkWin() {
    return false;
  }

  List<List<int>> getBoard() {
    return _board;
  }

  void goLeft() {
    printBoard();
    for (var i = 0; i < _board.length; i++) {
      List<int> row = _board[i];
      int right = 0;
      int left = 0;
      while (right < row.length) {
        print(right);
        if (row[right] == 0) {
          right++;
        } else {
          row[left] = row[right];
          row[right] = 0;
          right++;
          left++;
        }
      }
    }
    notifyBoardChanged();
  }

  void goRight() {
    for (var i = 0; i < _board.length; i++) {
      List<int> row = _board[i];
      int left = row.length - 1;
      int right = row.length - 1;
      while (left >= 0) {
        if (row[left] == 0) {
          left--;
        } else {
          row[right] = row[left];
          row[left] = 0;
          right--;
          left--;
        }
      }
    }
    notifyBoardChanged();
  }

  void goTop() {}

  void goBottom() {}

  printBoard() {
    print("===========");
    for (var i = 0; i < _board.length; i++) {
      String row = "";
      for (var j = 0; j < _board[i].length; j++) {
        int v = _board[i][j];
        row = row + " " + v.toString();
      }
      print(row);
    }
    print("===========");
  }
}
