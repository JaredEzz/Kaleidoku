import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kaleidoku/sudoku_grid_widget.dart';

class KaleidokuAnimation extends StatefulWidget {
  const KaleidokuAnimation({Key? key}) : super(key: key);

  @override
  _KaleidokuAnimationState createState() => _KaleidokuAnimationState();
}

class _KaleidokuAnimationState extends State<KaleidokuAnimation> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  final List<Animation<double>> _animations = [];
  final List<Color> _colors = List.filled(9, Colors.transparent);
  String? output;
  final int numSeconds = 5;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(9, (index) => AnimationController(
      duration: Duration(seconds: numSeconds),
      vsync: this,
    ));

    for (int i = 0; i < 9; i++) {
      _animations.add(Tween<double>(begin: -300, end: 0).animate(CurvedAnimation(
        parent: _controllers[i],
        curve: Interval(i / 9, (i + 1) / 9, curve: Curves.easeOut),
      )));
      _controllers[i].forward();

      Timer(Duration(microseconds: (numSeconds * 1000000 / 9 * (i + 1)).toInt()) , () {
        setState(() {
          _colors[i] = colorLookup.values.toList()[i];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
    ];

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: 'Kaleidoku'.split('').asMap().entries.map((e) {
                  return AnimatedBuilder(
                    animation: _animations[e.key],
                    builder: (BuildContext context, Widget? child) {
                      return Transform.translate(
                        offset: Offset(0, _animations[e.key].value),
                        child: Column(
                          children: [
                            Text(e.value, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                            Text('${e.key + 1}', style: TextStyle(color: _colors[e.key], fontSize: 20)),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    itemCount: 81,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Visibility(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      number.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black38
                                      ),
                                    ),
                                  ),
                                ),
                                visible: number != 0,
                              ),
                            )
                        ),
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
