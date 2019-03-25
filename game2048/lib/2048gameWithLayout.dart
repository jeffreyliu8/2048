import 'package:flutter/material.dart';
import 'package:game2048/2048game.dart';
import 'package:game2048/scoreview.dart';

class GameLayoutView extends StatefulWidget {
  const GameLayoutView({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GameLayoutState();
  }
}

class _GameLayoutState extends State<GameLayoutView> {
  int _currentScore = 0;

  void _handleScoreChanged(int score) {
    setState(() {
      _currentScore = score;
    });
  }

  void _handleWinLoseChanged(bool win) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (win) {
          return AlertDialog(
            title: Text("You Win!"),
            content: Text("You got a 2048!"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }

        return AlertDialog(
          title: Text("You lose..."),
          content: Text("Sorry, no more moves to play."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("New Game"),
              onPressed: () {
                _key.currentState.newGame();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  GlobalKey<GameViewState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: SafeArea(
            top: true,
            bottom: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "2048",
                          style: TextStyle(
                            fontSize: 36.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ScoreView(
                        title: "Score",
                        score: _currentScore,
                      ),
                      ScoreView(
                        title: "Best",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 16.0, left: 16.0, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Join the numbers and get to the 2048 tile!",
                          style: new TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      MaterialButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: new Text(
                          "New Game",
                          style: new TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () => {_key.currentState.newGame()},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: SafeArea(
              top: false,
              bottom: true,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GameView(
                  key: _key,
                  onScoreChanged: _handleScoreChanged,
                  onWinLoseChanged: _handleWinLoseChanged,
                ),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
