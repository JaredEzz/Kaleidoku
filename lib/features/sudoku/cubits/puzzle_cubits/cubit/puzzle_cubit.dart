import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kaleidoku/features/sudoku/models/puzzle_model.dart';
part 'puzzle_state.dart';
part 'puzzle_cubit.freezed.dart';

class PuzzleCubit extends Cubit<PuzzleState> {
  PuzzleCubit() : super(const PuzzleState.initial());
}
