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

    _Position pos = selectRandomTile();

    if (pos != null) {
      var rng = new Random();
      int randomValue = rng.nextInt(2) + 1;
      setTile(pos.x, pos.y, randomValue);
    }
  }

  _Position selectRandomTile() {
    List<_Position> pos = [];
    for (var i = 0; i < _board.length; i++) { // row
      for (var j = 0; j < _board[i].length; j++) { // col
        if (_board[i][j] == 0) {
          print("adding  " + j.toString() +" " + i.toString());
          pos.add(_Position(j, i));
        }
      }
    }

    if (pos.length == 0) {
      return null;
    }
    print("size is " + pos.length.toString());

    var rng = new Random();
    int index = rng.nextInt(pos.length);
    return pos[index];
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
      List<int> temp = List(row.length);

      for (var j = 0; j < row.length; j++) {
        temp[j] = 0;
      }

      int j = 0;
      for (int value in row) {
        if (value != 0) {
          temp[j] = value;
          j++;
        }
      }

      for (var j = 0; j < row.length; j++) {
        row[j] = temp[j];
      }
    }

    _Position pos = selectRandomTile();
    if (pos != null) {
      var rng = new Random();
      int randomValue = rng.nextInt(2) + 1;
      setTile(pos.x, pos.y, randomValue);
    } else {
      print("no more empty space!");
    }
  }

  void goRight() {
    for (var i = 0; i < _board.length; i++) {
      List<int> row = _board[i];
      List<int> temp = List(row.length);
      for (var j = 0; j < row.length; j++) {
        temp[j] = 0;
      }

      int g = row.length - 1;
      for (var j = row.length - 1; j >= 0; j--) {
        if (row[j] != 0) {
          temp[g] = row[j];
          g--;
        }
      }

      for (var j = 0; j < row.length; j++) {
        row[j] = temp[j];
      }
    }

    _Position pos = selectRandomTile();
    if (pos != null) {
      var rng = new Random();
      int randomValue = rng.nextInt(2) + 1;
      setTile(pos.x, pos.y, randomValue);
    } else {
      print("no more empty space!");
    }
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

    _Position pos = selectRandomTile();
    if (pos != null) {
      var rng = new Random();
      int randomValue = rng.nextInt(2) + 1;
      setTile(pos.x, pos.y, randomValue);
    } else {
      print("no more empty space!");
    }
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

    _Position pos = selectRandomTile();
    if (pos != null) {
      var rng = new Random();
      int randomValue = rng.nextInt(2) + 1;
      setTile(pos.x, pos.y, randomValue);
    } else {
      print("no more empty space!");
    }
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

class _Position {
  int x;
  int y;

  _Position(this.x, this.y);
}
