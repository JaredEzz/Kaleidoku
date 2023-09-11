import 'package:flutter/material.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';

Color getLevelColor(Grid grid) {
  if (grid.difficulty == 'Easy') {
    return Colors.greenAccent;
  } else if (grid.difficulty == 'Medium') {
    return Colors.yellow;
  } else {
    return Colors.redAccent;
  }
}
