import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kaleidoku/features/sudoku/widgets/sudoku_grid_widget.dart';

class SudokuScreen extends StatefulWidget {
  const SudokuScreen({Key? key}) : super(key: key);

  @override
  State<SudokuScreen> createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  List<List<int>>? sudokuGrid;
  List<List<int>>? solutionGrid;
  String selectedDifficulty = 'Medium';
  bool showNumbers = false;

  Future<void> getPuzzle() async {
    bool puzzleFound = false;

    while (!puzzleFound) {
      final response = await http.get(Uri.parse(
          'https://sudoku-api.vercel.app/api/dosuku?query={newboard(limit:20){grids{value,solution,difficulty},results,message}}'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final grids = jsonResponse['newboard']['grids'];

        for (final grid in grids) {
          final puzzle = grid['value'];
          final solution = grid['solution'];
          final difficulty = grid['difficulty'];

          if (difficulty == selectedDifficulty) {
            final convertedPuzzle =
                List<List<int>>.generate(puzzle.length, (int rowIndex) {
              final row = puzzle[rowIndex];
              return List<int>.generate(row.length, (int colIndex) {
                return row[colIndex] as int;
              });
            });

            final convertedSolution =
                List<List<int>>.generate(solution.length, (int rowIndex) {
              final row = solution[rowIndex];
              return List<int>.generate(row.length, (int colIndex) {
                return row[colIndex] as int;
              });
            });

            setState(() {
              sudokuGrid = convertedPuzzle;
              solutionGrid = convertedSolution;
            });
            puzzleFound = true;
            break;
          }
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.statusCode}'),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    getPuzzle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (sudokuGrid == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: selectedDifficulty,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDifficulty = newValue ?? "Medium";
                  });
                },
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: 'Easy',
                    child: Text('Easy'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Medium',
                    child: Text('Medium'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Hard',
                    child: Text('Hard'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: getPuzzle,
                child: const Text('Get Puzzle'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Kaleidoku'),
          actions: [
            Tooltip(
              message: showNumbers ? 'Hide Numbers' : 'Show Numbers',
              child: Switch(
                value: showNumbers,
                onChanged: (value) {
                  setState(() {
                    showNumbers = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                onPressed: getPuzzle,
                icon: const Icon(Icons.refresh),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            SudokuGridWidget(
              grid: sudokuGrid!,
              showNumbers: showNumbers,
            ),
            ExpansionTile(
              title: const Text('Solution'),
              initiallyExpanded: false,
              children: <Widget>[
                SudokuGridWidget(
                  grid: solutionGrid!,
                  showNumbers: showNumbers,
                )
              ],
            ),
          ],
        ),
      );
    }
  }
}
