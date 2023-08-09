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

              // Check if the current cell is in the specified rows and columns
              // if the column is 2 or 5, make the right border thick. If the column is 3 or 6, make the left border thick. If the row is 2 or 5, make the bottom border thick. If the row is 3 or 6, make the top border thick
              final rightBorderThick = (col == 2 || col == 5);
              final leftBorderThick = (col == 3 || col == 6);
              final bottomBorderThick = (row == 2 || row == 5);
              final topBorderThick = (row == 3 || row == 6);
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: topBorderThick ? Colors.black : Colors.grey,
                    width: topBorderThick ? 2.0 : 1.0, // Set the border width
                  ),
                  left: BorderSide(
                    color: leftBorderThick ? Colors.black : Colors.grey,
                    width: leftBorderThick ? 2.0 : 1.0, // Set the border width
                  ),
                  right: BorderSide(
                    color: rightBorderThick ? Colors.black : Colors.grey,
                    width: rightBorderThick ? 2.0 : 1.0, // Set the border width
                  ),
                  bottom: BorderSide(
                    color: bottomBorderThick ? Colors.black : Colors.grey,
                    width: bottomBorderThick ? 2.0 : 1.0, // Set the border width
                  ),
                )),
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
