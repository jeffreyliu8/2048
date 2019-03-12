import 'package:flutter/material.dart';

class GameBgPieceView extends StatefulWidget {
  GameBgPieceView({
    Key key,
    this.row,
    this.col,
    this.onRendered,
  }) : super(key: key);

  final int row;
  final int col;
  final Function(int, int, RenderBox) onRendered;

  @override
  State<StatefulWidget> createState() {
    return _GameBgPieceViewState();
  }
}

class _GameBgPieceViewState extends State<GameBgPieceView> {
  GlobalKey _keyRed = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Widget result = AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          key: _keyRed,
          color: Colors.yellow,
        ),
      ),
    );
    return result;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    widget.onRendered(
        widget.row, widget.col, _keyRed.currentContext.findRenderObject());
  }
}
