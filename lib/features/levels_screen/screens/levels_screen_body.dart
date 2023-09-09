import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaleidoku/core/styles/sizes.dart';
import 'package:kaleidoku/core/styles/text_styles.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';
import 'package:kaleidoku/features/levels_screen/utils/get_level_color.dart';
import 'package:kaleidoku/features/sudoku_screen/screens/sudoku_screen.dart';

class LevelScreenBody extends StatefulWidget {
  const LevelScreenBody({super.key, required this.puzzles});
  final PuzzleModel puzzles;

  @override
  State<LevelScreenBody> createState() => _LevelScreenBodyState();
}

class _LevelScreenBodyState extends State<LevelScreenBody> {
  @override
  Widget build(BuildContext context) {
    List<Grid> orderedPuzzles = [];

    int easyNumber = 1;
    int mediumNumber = 1;
    int hardNumber = 1;

    for (int i = 1; i <= widget.puzzles.newboard.grids.length; i++) {
      String difficulty;
      int number;

      if (i % 4 == 1 || i % 4 == 4) {
        difficulty = 'Easy';
        number = easyNumber++;
      } else if (i % 4 == 2 || i % 4 == 3) {
        difficulty = 'Medium';
        number = mediumNumber++;
      } else {
        difficulty = 'Hard';
        number = hardNumber++;
      }

      orderedPuzzles.add(Grid(
          difficulty: difficulty,
          number: number,
          value: widget.puzzles.newboard.grids[i - 1].value,
          solution: widget.puzzles.newboard.grids[i - 1].solution));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PaddingSizes.mdl),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: orderedPuzzles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              crossAxisSpacing: PaddingSizes.sm,
              mainAxisSpacing: PaddingSizes.sm,
            ),
            itemBuilder: (context, index) {
              final puzzleGrid = orderedPuzzles[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              SudokuScreen(puzzleGrid: puzzleGrid)));
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getLevelColor(puzzleGrid),
                  ),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: AppTextStyles()
                          .mRegular
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
