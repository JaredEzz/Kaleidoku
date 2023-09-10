import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaleidoku/core/styles/sizes.dart';
import 'package:kaleidoku/core/styles/text_styles.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';
import 'package:kaleidoku/features/levels_screen/utils/get_level_color.dart';
import 'package:kaleidoku/features/sudoku_screen/screens/sudoku_screen.dart';
import 'dart:math' as math;

class LevelScreenBody extends StatefulWidget {
  const LevelScreenBody({super.key, required this.puzzles});

  final PuzzleModel puzzles;

  @override
  State<LevelScreenBody> createState() => _LevelScreenBodyState();
}

class _LevelScreenBodyState extends State<LevelScreenBody> {
  late List<Grid> easyPuzzles;
  late List<Grid> mediumPuzzles;
  late List<Grid> hardPuzzles;

  @override
  void initState() {
    easyPuzzles = widget.puzzles.newboard.grids
        .where((puzzle) => puzzle.difficulty == "Easy")
        .toList();

    mediumPuzzles = widget.puzzles.newboard.grids
        .where((puzzle) => puzzle.difficulty == "Medium")
        .toList();

    hardPuzzles = widget.puzzles.newboard.grids
        .where((puzzle) => puzzle.difficulty == "Hard")
        .toList();
    super.initState();
  }

  Grid? getPuzzleByIndex(int index) {
    int column = index % 3;
    int row = index ~/ 3;

    switch (column) {
      case 0:
        if (row < easyPuzzles.length) {
          return easyPuzzles[row];
        }
        break;
      case 1:
        if (row < mediumPuzzles.length) {
          return mediumPuzzles[row];
        }
        break;
      case 2:
        if (row < hardPuzzles.length) {
          return hardPuzzles[row];
        }
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    int maxListSize = [
      easyPuzzles.length,
      mediumPuzzles.length,
      hardPuzzles.length
    ].reduce(math.max);

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: PaddingSizes.mdl),
        child: SingleChildScrollView(
          child: Column(children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: maxListSize * 3,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                mainAxisExtent: 100,
                crossAxisSpacing: PaddingSizes.sm,
                mainAxisSpacing: PaddingSizes.sm,
              ),
              itemBuilder: (context, index) {
                final puzzle = getPuzzleByIndex(index);
                if (puzzle == null) {
                  return Container();
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                SudokuScreen(puzzleGrid: puzzle)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getLevelColor(puzzle),
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
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    //TODO change to puzzle of the day, generate a new puzzle from api on demand
                    CupertinoPageRoute(
                        builder: (context) => SudokuScreen(
                                puzzleGrid: Grid(
                              difficulty: "unknown",
                              number: 0,
                              solution: const [],
                              value: const [],
                            ))));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(PaddingSizes.lg),
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                  child: Center(
                    child: Text(
                      "Puzzle of the Day",
                      style:
                          AppTextStyles().mRegular.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            )
          ]),
        ));
  }
}
