import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kaleidoku/features/sudoku/models/puzzle_model.dart';

class GetPuzzleApiService {
  Future<PuzzleModel> getPuzzle({required String selectedDifficulty}) async {
    // bool puzzleFound = false;

    // while (!puzzleFound) {
    final response = await http.get(Uri.parse(
        'https://sudoku-api.vercel.app/api/dosuku?query={newboard(limit:20){grids{value,solution,difficulty},results,message}}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final result = PuzzleModel.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Something went wrong');
    }
    // for (final grid in grids) {
    //   final puzzle = grid['value'];
    //   final solution = grid['solution'];
    //   final difficulty = grid['difficulty'];

    //   if (difficulty == selectedDifficulty) {
    //     final convertedPuzzle =
    //         List<List<int>>.generate(puzzle.length, (int rowIndex) {
    //       final row = puzzle[rowIndex];
    //       return List<int>.generate(row.length, (int colIndex) {
    //         return row[colIndex] as int;
    //       });
    //     });

    //     final convertedSolution =
    //         List<List<int>>.generate(solution.length, (int rowIndex) {
    //       final row = solution[rowIndex];
    //       return List<int>.generate(row.length, (int colIndex) {
    //         return row[colIndex] as int;
    //       });
    //     });

    // setState(() {
    //   sudokuGrid = convertedPuzzle;
    //   solutionGrid = convertedSolution;
    // });
    // puzzleFound = true;
    // break;
  }
}
