import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SudokuScreen extends StatefulWidget {
  const SudokuScreen({Key? key}) : super(key: key);

  @override
  State<SudokuScreen> createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  List<List<int>>? sudokuGrid;
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
          final value = grid['value'];
          final difficulty = grid['difficulty'];

          if (difficulty == selectedDifficulty) {
            final convertedList =
                List<List<int>>.generate(value.length, (int rowIndex) {
              final row = value[rowIndex];
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

  final Map<int, Color> colorLookup = {
    0: Colors.transparent,
    1: const Color(0xFFA02123),
    2: const Color(0xFFC84929),
    3: const Color(0xFFD1B806),
    4: const Color(0xFF2E8423),
    5: const Color(0xFF005B26),
    6: const Color(0xFF73B5CF),
    7: const Color(0xFF0D4E8A),
    8: const Color(0xFF845585),
    9: const Color(0xFF3F214D),
  };


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
                // thumbColor: showNumbers ? Colors.green : Colors.grey[300],
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

              final rightBorderThick = (col == 2 || col == 5);
              final leftBorderThick = (col == 3 || col == 6);
              final bottomBorderThick = (row == 2 || row == 5);
              final topBorderThick = (row == 3 || row == 6);
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: topBorderThick ? Colors.black : Colors.grey,
                    width: topBorderThick ? 2.0 : 1.0,
                  ),
                  left: BorderSide(
                    color: leftBorderThick ? Colors.black : Colors.grey,
                    width: leftBorderThick ? 2.0 : 1.0,
                  ),
                  right: BorderSide(
                    color: rightBorderThick ? Colors.black : Colors.grey,
                    width: rightBorderThick ? 2.0 : 1.0,
                  ),
                  bottom: BorderSide(
                    color: bottomBorderThick ? Colors.black : Colors.grey,
                    width: bottomBorderThick ? 2.0 : 1.0,
                  ),
                )),
                child: Center(
                  child: Visibility(
                    visible: number != 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorLookup[number] ?? Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          number.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: showNumbers
                                  ? Colors.white
                                  : Colors.transparent),
                        ),
                      ),
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
