import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';

class PuzzleApiService {
  Future<PuzzleModel> getPuzzle() async {
    final response = await http.get(Uri.parse(
        'https://sudoku-api.vercel.app/api/dosuku?query={newboard(limit:1){grids{value,solution,difficulty},results,message}}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final result = PuzzleModel.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Something went wrong');
    }
  }
}
