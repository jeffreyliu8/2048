import 'dart:math';

typedef void ScoreChangedCallback(int score);
typedef void BoardChangedCallback(List<List<int>> board);
typedef void WinLoseStateChangedCallback(bool isWin);

class Game {
  int _score = 0;
  final int _squareLength;
  final ScoreChangedCallback _onScoreChanged;
  final BoardChangedCallback _onBoardChanged;
  final WinLoseStateChangedCallback _onWinLoseChanged;
  List<List<int>> _board;

  Game(this._squareLength, this._onScoreChanged, this._onBoardChanged,
      this._onWinLoseChanged) {
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
    for (var i = 0; i < _board.length; i++) {
      // row
      for (var j = 0; j < _board[i].length; j++) {
        // col
        if (_board[i][j] == 0) {
          print("adding  " + j.toString() + " " + i.toString());
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
    _score = 0;
    notifyScoreChanged();
  }

  void setTile(int x, int y, int value) {
    print("setting $x $y $value");
    _board[y][x] = value;

    printBoard();

    notifyBoardChanged();
  }

  void checkWin() {
    // check win
    for (var i = 0; i < _board.length; i++) {
      for (var j = 0; j < _board[i].length; j++) {
        if (_board[i][j] == 2048) {
          notifyWinLose(true);
          return;
        }
      }
    }
  }

  void checkLose() {
    //check lose, here we are assuming the board is already full
    for (var i = 0; i < _board.length; i++) {
      for (var j = 0; j < _board[i].length; j++) {
        if (hasSameNonZeroNeighbor(i, j)) {
          print(
              "hasSameNonZeroNeighbor at " + i.toString() + " " + j.toString());
          return;
        }
      }
    }
    notifyWinLose(false);
  }

  bool hasSameNonZeroNeighbor(int i, int j) {
    if (_board[i][j] == 0) {
      return true;
    }

    if (i - 1 >= 0 && _board[i - 1][j] == _board[i][j]) {
      return true;
    }

    if (i + 1 < _squareLength && _board[i + 1][j] == _board[i][j]) {
      return true;
    }

    if (j - 1 >= 0 && _board[i][j - 1] == _board[i][j]) {
      return true;
    }

    if (j + 1 < _squareLength && _board[i][j + 1] == _board[i][j]) {
      return true;
    }
    return false;
  }

  void notifyBoardChanged() {
    if (_onBoardChanged != null) {
      _onBoardChanged(_board);
    }
  }

  void notifyScoreChanged() {
    if (_onScoreChanged != null) {
      _onScoreChanged(_score);
    }
  }

  void notifyWinLose(bool isWin) {
    if (_onWinLoseChanged != null) {
      _onWinLoseChanged(isWin);
    }
  }

  List<List<int>> getBoard() {
    return _board;
  }

  void goLeft() {
    goLeftRemoveSpace();
    goLeftMerge();
    goLeftRemoveSpace();
    checkWin();

    _Position pos = selectRandomTile();
    if (pos != null) {
      var rng = new Random();
      int randomValue = rng.nextInt(2) + 1;
      setTile(pos.x, pos.y, randomValue);
    } else {
      print("no more empty space!");
      checkLose();
    }
  }

  void goLeftRemoveSpace() {
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
  }

  void goLeftMerge() {
    for (var i = 0; i < _board.length; i++) {
      List<int> row = _board[i];

      int start = 0;
      int end = start + 1;
      while (start < _squareLength && end < _squareLength) {
        if (row[start] == row[end]) {
          int score = row[start];
          row[start] = row[start] + row[end];
          row[end] = 0;
          start = start + 2;
          end = end + 2;
          _score = _score + score;
        } else {
          start++;
          end++;
        }
      }
    }
    notifyScoreChanged();
  }

  void goRight() {
    goRightRemoveSpace();
    goRightMerge();
    goRightRemoveSpace();
    checkWin();

    _Position pos = selectRandomTile();
    if (pos != null) {
      var rng = new Random();
      int randomValue = rng.nextInt(2) + 1;
      setTile(pos.x, pos.y, randomValue);
    } else {
      print("no more empty space!");
      checkLose();
    }
  }

  void goRightRemoveSpace() {
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
  }

  void goRightMerge() {
    for (var i = 0; i < _board.length; i++) {
      List<int> row = _board[i];

      int start = _squareLength - 1;
      int end = start - 1;
      while (start >= 0 && end >= 0) {
        if (row[start] == row[end]) {
          int score = row[start];
          row[start] = row[start] + row[end];
          row[end] = 0;
          start = start - 2;
          end = end - 2;
          _score = _score + score;
        } else {
          start--;
          end--;
        }
      }
    }
    notifyScoreChanged();
  }

  void goTop() {
    goTopRemoveSpace();
    goTopMerge();
    goTopRemoveSpace();
    checkWin();

    _Position pos = selectRandomTile();
    if (pos != null) {
      var rng = new Random();
      int randomValue = rng.nextInt(2) + 1;
      setTile(pos.x, pos.y, randomValue);
    } else {
      print("no more empty space!");
      checkLose();
    }
  }

  void goTopRemoveSpace() {
    for (var col = 0; col < _board.length; col++) {
      List<int> temp = List(_squareLength);

      for (var j = 0; j < _squareLength; j++) {
        temp[j] = 0;
      }

      int g = 0;
      for (var j = 0; j < _squareLength; j++) {
        if (_board[j][col] != 0) {
          temp[g] = _board[j][col];
          g++;
        }
      }

      for (var j = 0; j < _squareLength; j++) {
        _board[j][col] = temp[j];
      }
    }
  }

  void goTopMerge() {
    for (var col = 0; col < _board.length; col++) {
      int start = 0;
      int end = start + 1;
      while (start < _squareLength && end < _squareLength) {
        if (_board[start][col] == _board[end][col]) {
          int score = _board[start][col];
          _board[start][col] = _board[start][col] + _board[end][col];
          _board[end][col] = 0;
          start = start + 2;
          end = end + 2;
          _score = _score + score;
        } else {
          start++;
          end++;
        }
      }
    }
    notifyScoreChanged();
  }

  void goBottom() {
    goBottomRemoveSpace();
    goBottomMerge();
    goBottomRemoveSpace();
    checkWin();

    _Position pos = selectRandomTile();
    if (pos != null) {
      var rng = new Random();
      int randomValue = rng.nextInt(2) + 1;
      setTile(pos.x, pos.y, randomValue);
    } else {
      print("no more empty space!");
      checkLose();
    }
  }

  void goBottomRemoveSpace() {
    for (var col = 0; col < _board.length; col++) {
      List<int> temp = List(_squareLength);

      for (var j = 0; j < _squareLength; j++) {
        temp[j] = 0;
      }

      int g = _squareLength - 1;
      for (var j = _squareLength - 1; j >= 0; j--) {
        if (_board[j][col] != 0) {
          temp[g] = _board[j][col];
          g--;
        }
      }

      for (var j = _squareLength - 1; j >= 0; j--) {
        _board[j][col] = temp[j];
      }
    }
  }

  void goBottomMerge() {
    for (var col = 0; col < _board.length; col++) {
      int start = _squareLength - 1;
      int end = start - 1;
      while (start >= 0 && end >= 0) {
        if (_board[start][col] == _board[end][col]) {
          int score = _board[start][col];
          _board[start][col] = _board[start][col] + _board[end][col];
          _board[end][col] = 0;
          start = start - 2;
          end = end - 2;
          _score = _score + score;
        } else {
          start--;
          end--;
        }
      }
    }
    notifyScoreChanged();
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
