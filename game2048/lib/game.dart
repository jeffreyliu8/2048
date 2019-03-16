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
    for (var i = 0; i < _board.length; i++) {
      List<int> row = _board[i];
      int right = 0;
      int left = 0;
      while (right < row.length) {
        if (row[right] == 0 || left == right) {
          //skip
        } else {
          row[left] = row[right];
          row[right] = 0;
          left++;
        }
        right++;
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
        if (row[left] == 0 || left == right) {
          //skip
        } else {
          row[right] = row[left];
          row[left] = 0;
          right--;
        }
        left--;
      }
    }
    notifyBoardChanged();
  }

  void goTop() {
    for (var col = 0; col < _board.length; col++) {
      int top = 0;
      int bottom = 0;
      while (bottom < _board.length) {
        if (_board[bottom][col] == 0 || top == bottom) {
          //skip
        } else {
          _board[top][col] = _board[bottom][col];
          _board[bottom][col] = 0;
          top++;
        }
        bottom++;
      }
    }
    notifyBoardChanged();
  }

  void goBottom() {
    for (var col = 0; col < _board.length; col++) {
      int top = _board.length - 1;
      int bottom = _board.length - 1;
      while (top >= 0) {
        if (_board[top][col] == 0 || top == bottom) {
          //skip
        } else {
          _board[bottom][col] = _board[top][col];
          _board[top][col] = 0;
          bottom--;
        }
        top--;
      }
    }
    notifyBoardChanged();
  }

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
