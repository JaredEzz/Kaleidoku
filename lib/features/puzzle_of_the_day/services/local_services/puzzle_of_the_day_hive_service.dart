import 'package:hive_flutter/hive_flutter.dart';

class PuzzleOfTheDayHiveService {
  final _puzzleOfTheDay = Hive.box('puzzleOfTheDay');
}
