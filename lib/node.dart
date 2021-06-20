import 'package:flutter/material.dart';

import 'package:dragnode/constants/Constants.dart';


class Node extends StatelessWidget {
  // final double size = 100;
  final double height = nodeHeight;
  final double width = nodeWidth;
  final Offset offset;
  final Function onDragStart;
  final String text;

  Node({Key key, this.offset, this.onDragStart, this.text,});


  _handleDrag(details) {
    print(details);
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    onDragStart(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx - width / 2,
      top: offset.dy - height / 2,
      child: GestureDetector(
        onPanStart: _handleDrag,
        onPanUpdate: _handleDrag,
        child: Container(
          width:width,
          height: height,
          child: Center(child: Text(text)),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(width: 2.0,color: Colors.blue),
          ),
        ),
      ),
    );
  }
}