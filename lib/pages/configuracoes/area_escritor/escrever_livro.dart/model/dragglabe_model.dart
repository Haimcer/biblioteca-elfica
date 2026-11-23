import 'dart:typed_data';

import 'package:flutter/material.dart';

class DraggableImageData {
  final Uint8List imageBytes;
  Offset position;
  double width;
  double height;
  final Key key;

  DraggableImageData({
    required this.imageBytes,
    required this.position,
    this.width = 150,
    this.height = 150,
  }) : key = UniqueKey(); // 🔥 força identificação única
}
