import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SudokuScreen extends StatefulWidget {
  SudokuScreen({Key? key}) : super(key: key);

  @override
  State<SudokuScreen> createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  List<List<int>>? sudokuGrid;
  String selectedDifficulty = 'Medium';

  Future<void> getPuzzle() async {
    bool puzzleFound = false;

    while (!puzzleFound) {
      final response = await http.get(Uri.parse(
          'https://sudoku-api.vercel.app/api/dosuku?query={newboard(limit:20){grids{value,solution,difficulty},results,message}}'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final grids = jsonResponse['newboard']['grids'];

        for (var grid in grids) {
          final value = grid['value'];
          final difficulty = grid['difficulty'];

          if (difficulty == selectedDifficulty) {
            List<List<int>> convertedList =
                List<List<int>>.generate(value.length, (int rowIndex) {
              List<dynamic> row = value[rowIndex];
              return List<int>.generate(row.length, (int colIndex) {
                return row[colIndex] as int;
              });
            });

            setState(() {
              sudokuGrid = convertedList;
            });
            puzzleFound = true;
            break;
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.statusCode}'),
          ),
        );
      }
    }
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
                items: <String>['Easy', 'Medium', 'Hard']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
            IconButton(
              onPressed: getPuzzle,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Center(
          child: GridView.builder(
            itemCount: 81,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9,
            ),
            itemBuilder: (BuildContext context, int index) {
              final row = index ~/ 9;
              final col = index % 9;
              final number = sudokuGrid![row][col];

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Visibility(
                    visible: number != 0,
                    child: Text(
                      number.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
