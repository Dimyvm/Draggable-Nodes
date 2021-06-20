import 'package:flutter/material.dart';

import 'package:path_drawing/path_drawing.dart';
import 'package:dragnode/constants/Constants.dart';

class ConnectionDrawer extends CustomPainter {
  final List<Offset> offsets;
  bool curvedLine;
  bool dashLine;
  Color lineColor = Colors.cyan;
  double endBeginOfNode = nodeWidth /2;

  ConnectionDrawer({this.offsets, this.curvedLine = true, this.dashLine = true});

  @override
  bool shouldRepaint(ConnectionDrawer oldDelegate) => true;

  // Paint connection
  @override
  void paint(Canvas canvas, Size size) {
    if (offsets.length > 1) {
      offsets.asMap().forEach((index, offset) {
        if (index == 0) {
          return;
        } else {
          
          Paint paint = Paint()
              ..color = lineColor
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3.0;

          Path path = Path();

          //startpoint of the connection
            path.moveTo(offsets[index - 1].dx + endBeginOfNode, offsets[index - 1].dy);

          if (curvedLine) {//Curvedline

            // use this for a bezier curve s line
            // example: https://medium.com/flutter-community/paths-in-flutter-a-visual-guide-6c906464dcd0
            
            // endpoint + curved Bezier s line
              path.cubicTo(
                offsets[index - 1].dx +((offsets[index].dx - offsets[index - 1].dx) / 2) +endBeginOfNode, // x down
                offsets[index - 1].dy -((offsets[index].dy - offsets[index - 1].dy) / 3), // y down
                offsets[index - 1].dx +((offsets[index].dx - offsets[index - 1].dx) / 2) -endBeginOfNode, // x up
                offsets[index].dy + ((offsets[index].dy - offsets[index - 1].dy) / 3), // y up
                offsets[index].dx - endBeginOfNode,offsets[index].dy,
                ); //end
 
          } else { 
            //Straight Line 

            //Line to
            path.lineTo(offsets[index].dx, offsets[index].dy);
          }

          if (dashLine) {
              // Dash Line
              canvas.drawPath(
                  dashPath(path,dashArray:CircularIntervalList<double>(<double>[20.0, 5])),paint);
            } else {
              // Full line
              canvas.drawPath(path, paint);
            }
        }
      });
    }
  }
}
