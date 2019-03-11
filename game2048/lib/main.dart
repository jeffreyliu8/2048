import 'package:flutter/material.dart';
import 'package:game2048/scoreview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: Scaffold(
          backgroundColor: Colors.orange[50],
          body: Column(
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
                              onPressed: () => {},
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
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: new Container(
                            decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.orange,
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
