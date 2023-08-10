import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaleidoku/sudoku_grid_widget.dart';

class KaleidokuAnimation extends StatefulWidget {
  const KaleidokuAnimation({Key? key}) : super(key: key);

  @override
  _KaleidokuAnimationState createState() => _KaleidokuAnimationState();
}

class _KaleidokuAnimationState extends State<KaleidokuAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  final List<Animation<double>> _animations = [];
  String? output;
  final int numSeconds = 3;
  late AnimationController _glowAnimationController;
  late Animation _glowAnimation;
  int test = 0;
  List<Color> puzzleNumberColors = List.filled(81, Colors.black38);
  List<FontWeight> puzzleNumberFontWeights = List.filled(81, FontWeight.normal);
  List<List<int>> solvedSudoku = [
    [5, 3, 4, 6, 7, 8, 9, 1, 2],
    [6, 7, 2, 1, 9, 5, 3, 4, 8],
    [1, 9, 8, 3, 4, 2, 5, 6, 7],
    [8, 5, 9, 7, 6, 1, 4, 2, 3],
    [4, 2, 6, 8, 5, 3, 7, 9, 1],
    [7, 1, 3, 9, 2, 4, 8, 5, 6],
    [9, 6, 1, 5, 3, 7, 2, 8, 4],
    [2, 8, 7, 4, 1, 9, 6, 3, 5],
    [3, 4, 5, 2, 8, 6, 1, 7, 9],
  ]; // TODO pick a random solved puzzle


  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
        9,
        (index) => AnimationController(
              duration: Duration(seconds: numSeconds),
              vsync: this,
            ));

    for (int i = 0; i < 9; i++) {
      _animations
          .add(Tween<double>(begin: -300, end: 0).animate(CurvedAnimation(
        parent: _controllers[i],
        curve: Interval(i / 9, (i + 1) / 9, curve: Curves.easeOut),
      )));
      _controllers[i].forward();
    }
    _glowAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _glowAnimationController.repeat(reverse: true);
    _glowAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.forward ||
          status == AnimationStatus.reverse) {
        changePuzzleColors();
      }
    });
    _glowAnimation =
        Tween(begin: 2.0, end: 15.0).animate(_glowAnimationController)
          ..addListener(() {
            setState(() {});
          });
  }

  void changePuzzleColors() {
    puzzleNumberColors = List.filled(81, Colors.black38);
    puzzleNumberFontWeights = List.filled(81, FontWeight.normal);
    final random = Random();
    List<Color> solvedSudokuNumberColors = solvedSudoku.expand((row) => row).map((int e) => colorLookup.values.toList()[e - 1]).toList();

    final choice = random.nextInt(3);

    switch (choice) {
      case (0):
        // change all colors for a random row
      test = 0;
        final row = random.nextInt(9);
        for (int i = row * 9; i < (row + 1) * 9; i++) {
          puzzleNumberColors[i] = solvedSudokuNumberColors[i];
          puzzleNumberFontWeights[i] = FontWeight.bold;
        }
        break;
      case (1):
        // change all colors for a random colum
      test = 1;
        final col = random.nextInt(9);
        for (int i = col; i < 81; i += 9) {
          puzzleNumberColors[i] = solvedSudokuNumberColors[i];
          puzzleNumberFontWeights[i] = FontWeight.bold;
        }
        break;
      case (2):
        test = 2;
        // change all colors for a random 3x3 square
        final row = random.nextInt(3);
        final col = random.nextInt(3);
        for (int i = row * 3; i < (row + 1) * 3; i++) {
          for (int j = col * 3; j < (col + 1) * 3; j++) {
            final index = i * 9 + j;
            puzzleNumberColors[index] = solvedSudokuNumberColors[index];
            puzzleNumberFontWeights[index] = FontWeight.bold;
          }
        }
        break;

      default:
        break;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: 'Kaleidoku'
                    .split('')
                    .asMap()
                    .entries
                    .map((MapEntry<int, String> e) {
                  Color color = colorLookup.values.toList()[e.key];
                  return AnimatedBuilder(
                    animation: _animations[e.key],
                    builder: (BuildContext context, Widget? child) {
                      return Transform.translate(
                        offset: Offset(0, _animations[e.key].value),
                        child: Column(
                          children: [
                            Text(
                              e.value,
                              style: GoogleFonts.poppins(
                                  fontSize: 54,
                                  color: Color.lerp(color, Colors.black45, 0.7),
                                  shadows: [
                                    BoxShadow(
                                        color: color,
                                        blurRadius: _glowAnimation.value,
                                        spreadRadius: _glowAnimation.value)
                                  ]),
                            ),
                            // Text('${e.key + 1}',
                            //     style: TextStyle(
                            //         color: _colors[e.key], fontSize: 20)),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Text(test.toString()),
            Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    itemCount: 81,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 9,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final row = index ~/ 9;
                      final col = index % 9;
                      final number = solvedSudoku[row][col];

                      final rightBorderThick = (col == 2 || col == 5);
                      final leftBorderThick = (col == 3 || col == 6);
                      final bottomBorderThick = (row == 2 || row == 5);
                      final topBorderThick = (row == 3 || row == 6);
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color:
                                  topBorderThick ? Colors.black : Colors.transparent,
                              width: topBorderThick ? 2.0 : 1.0,
                            ),
                            left: BorderSide(
                              color:
                                  leftBorderThick ? Colors.black : Colors.transparent,
                              width: leftBorderThick ? 2.0 : 1.0,
                            ),
                            right: BorderSide(
                              color:
                                  rightBorderThick ? Colors.black : Colors.transparent,
                              width: rightBorderThick ? 2.0 : 1.0,
                            ),
                            bottom: BorderSide(
                              color: bottomBorderThick
                                  ? Colors.black
                                  : Colors.transparent,
                              width: bottomBorderThick ? 2.0 : 1.0,
                            ),
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Visibility(
                                visible: number != 0,
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      number.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: puzzleNumberColors[index],
                                          fontWeight:
                                              puzzleNumberFontWeights[index]
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
