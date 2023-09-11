import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaleidoku/core/widgets/appbar.dart';
import 'package:kaleidoku/features/levels_screen/cubits/puzzle_cubits/cubit/puzzle_cubit.dart';
import 'package:kaleidoku/features/levels_screen/screens/levels_screen_body.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({Key? key}) : super(key: key);
  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PuzzleCubit>().getPuzzles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Levels',
        showMenuButton: false,
      ),
      body: BlocBuilder<PuzzleCubit, PuzzleState>(
        builder: (context, state) {
          return state.maybeWhen(
              error: (message) => Center(child: Text(message.toString())),
              success: ((puzzles) => LevelScreenBody(puzzles: puzzles)),
              orElse: () => const Center(child: Text('Something went wrong')));
        },
      ),
    );
  }
}
