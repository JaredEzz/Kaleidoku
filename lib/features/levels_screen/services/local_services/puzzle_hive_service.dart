import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kaleidoku/core/consts/puzzles_list.dart';
import 'package:kaleidoku/core/utils/logger.dart';
import 'package:kaleidoku/core/utils/parser.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';

class PuzzleHiveService {
  final _puzzles = Hive.box('puzzles');
  final _defaultPuzzlesAdded = Hive.box('defaultPuzzlesAdded');

  FutureOr<PuzzleModel> getPuzzles() async {
    final bool defaultPuzzlesAdded =
        _defaultPuzzlesAdded.get('defaultPuzzlesAdded', defaultValue: false);

    if (!defaultPuzzlesAdded) {
      logger.d('Adding default puzzles to Hive');
      await _puzzles.add(PuzzlesList.puzzlesList);
      await _defaultPuzzlesAdded.put('defaultPuzzlesAdded', true);
    }
    final data = _puzzles.getAt(0);
    final result = PuzzleModel.fromJson(parser(data));
    return result;
  }
}
