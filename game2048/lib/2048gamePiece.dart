import 'package:flutter/material.dart';

typedef void RenderedCallback(int row, int col, RenderBox box);

class GameBgPieceView extends StatefulWidget {
  GameBgPieceView({
    Key key,
    this.row,
    this.col,
    this.onRendered,
  }) : super(key: key);

  final int row;
  final int col;
  final RenderedCallback onRendered;

  @override
  State<StatefulWidget> createState() {
    return _GameBgPieceViewState(row, col, onRendered);
  }
}

class _GameBgPieceViewState extends State<GameBgPieceView> {
  GlobalKey _key = GlobalKey();

  int row;
  int col;
  RenderedCallback callback;

  _GameBgPieceViewState(this.row, this.col, this.callback);

  @override
  Widget build(BuildContext context) {
    Widget result = AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          key: _key,
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
    if (callback != null) {
      callback(row, col, _key.currentContext.findRenderObject());
    }
  }
}
