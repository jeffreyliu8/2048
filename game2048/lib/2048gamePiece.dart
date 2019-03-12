import 'package:flutter/material.dart';

class GameBgPieceView extends StatefulWidget {
  const GameBgPieceView({
    Key key,
    this.title: "title",
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _GameBgPieceViewState();
  }
}

class _GameBgPieceViewState extends State<GameBgPieceView> {
  GlobalKey _keyRed = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          key: _keyRed,
          color: Colors.yellow,
          child: InkWell(
            onTap: () {
              final RenderBox renderBoxRed =
                  _keyRed.currentContext.findRenderObject();
              final sizeRed = renderBoxRed.size;
              print("SIZE of Red: $sizeRed");
              final positionRed = renderBoxRed.localToGlobal(Offset.zero);
              print("POSITION of Red: $positionRed ");
            },
          ),
        ),
      ),
    );
  }
}
