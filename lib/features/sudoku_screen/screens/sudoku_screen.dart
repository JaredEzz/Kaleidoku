import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaleidoku/features/levels_screen/cubits/puzzle_cubits/cubit/puzzle_cubit.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';
import 'package:kaleidoku/features/sudoku_screen/widgets/sudoku_grid_widget.dart';

class SudokuScreen extends StatefulWidget {
  const SudokuScreen({Key? key, required this.puzzleGrid}) : super(key: key);
  final Grid puzzleGrid;

  @override
  State<SudokuScreen> createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  bool showNumbers = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleCubit, PuzzleState>(builder: ((context, state) {
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
          ],
        ),
        body: ListView(
          children: [
            SudokuGridWidget(
              grid: widget.puzzleGrid.value,
              showNumbers: showNumbers,
            ),
            ExpansionTile(
              title: const Text('Solution'),
              initiallyExpanded: false,
              children: <Widget>[
                SudokuGridWidget(
                  grid: widget.puzzleGrid.solution,
                  showNumbers: showNumbers,
                )
              ],
            ),
          ],
        ),
      );
    }));
  }
}
