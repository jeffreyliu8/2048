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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: SafeArea(
                    top: true,
                    bottom: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "2048",
                                style: new TextStyle(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              "Join the numbers and get to the 2048 tile!",
                              style: new TextStyle(

                                color: Colors.black,
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
                      ],
                    ),
                  ),
                ),
              ),
              new AspectRatio(
                aspectRatio: 1,
                child: new Container(
                    decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.orange,
                )),
              ),
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: SafeArea(
                    top: false,
                    bottom: true,
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
