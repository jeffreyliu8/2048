import 'package:flutter/material.dart';

class GameBgPieceView extends StatefulWidget {
  GameBgPieceView({
    Key key,
    this.row,
    this.col,
    this.onClickCallback,
  }) : super(key: key);

  final int row;
  final int col;
  final ValueSetter<RenderBox> onClickCallback;

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
              widget.onClickCallback(_keyRed.currentContext.findRenderObject());
            },
          ),
        ),
      ),
    );
  }
}
