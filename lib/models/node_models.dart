
import 'package:flutter/material.dart';

class NodeModel {
  final Offset offset;
  final String text;

  NodeModel({this.offset, this.text});

  NodeModel copyWithNewOffset(Offset offset) {
    return NodeModel(offset: offset, text: text);
  }
}