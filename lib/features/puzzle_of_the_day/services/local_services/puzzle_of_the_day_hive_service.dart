import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kaleidoku/core/services/api_services/get_puzzle_api_service.dart';
import 'package:kaleidoku/core/utils/logger.dart';
import 'package:kaleidoku/core/utils/parser.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';
import 'package:kaleidoku/features/settings_screen/services/local_services/settings_hive_service.dart';

class PuzzleOfTheDayHiveService {
  final _puzzleApiService = PuzzleApiService();
  final _puzzleOfTheDay = Hive.box('puzzleOfTheDay');
  final SettingsHiveService service = SettingsHiveService();

  FutureOr<PuzzleModel> getPuzzleFromHive() async {
    try {
      final appSettings = service.getAppSettings();
      final notificationsTime = DateTime.parse(appSettings.notificationsTime)
          .add(const Duration(days: 1));
      if (notificationsTime
          .isBefore(DateTime.now().add(const Duration(seconds: 60)))) {
        _puzzleOfTheDay.delete('puzzle');
      }
      if (_puzzleOfTheDay.values.isEmpty) {
        await getPuzzleFromApiAndAddToHive();
      }
      final result = _puzzleOfTheDay.get('puzzle');
      final puzzle = PuzzleModel.fromJson(parser(result));
      return puzzle;
    } catch (e, st) {
      logger.d('Error', error: e, stackTrace: st);
      return Future.error('error');
    }
  }

  Future<void> getPuzzleFromApiAndAddToHive() async {
    logger.d('Attempting to fetch puzzle from API');
    final puzzle = await _puzzleApiService.getPuzzle();
    logger.d('successfully fetched puzzle from API');
    logger.d('Attempting to add puzzle to Hive service');
    _puzzleOfTheDay.put('puzzle', {
      "newboard": {
        "grids": [
          {
            "value": puzzle.newboard.grids.first.value,
            "solution": puzzle.newboard.grids.first.solution,
            "difficulty": puzzle.newboard.grids.first.difficulty,
            "number": 1
          }
        ]
      }
    });
    logger.d('successfully added puzzle to Hive');
  }
}
