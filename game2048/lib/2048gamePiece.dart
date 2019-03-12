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
    return _GameBgPieceViewState();
  }
}

class _GameBgPieceViewState extends State<GameBgPieceView> {
  GlobalKey _key = GlobalKey();

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
    if (widget.onRendered != null) {
      widget.onRendered(
          widget.row, widget.col, _key.currentContext.findRenderObject());
    }
  }
}
