import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kaleidoku/core/utils/logger.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';
import 'package:kaleidoku/features/levels_screen/services/local_services/puzzle_hive_service.dart';
part 'puzzle_state.dart';
part 'puzzle_cubit.freezed.dart';

class PuzzleCubit extends Cubit<PuzzleState> {
  PuzzleCubit({required this.puzzleHiveService})
      : super(const PuzzleState.initial());
  final PuzzleHiveService puzzleHiveService;

  Future<void> getPuzzles() async {
    try {
      logger.d('Attempting to fetch puzzles from Hive');
      emit(const PuzzleState.loading());
      final result = await puzzleHiveService.getPuzzles();
      emit(PuzzleState.success(result));
      logger.d('Successfully fetched puzzles from Hive');
    } catch (e, st) {
      logger.d('Failed to fetch puzzles from Hive', error: e, stackTrace: st);
      emit(PuzzleState.error(e.toString()));
    }
  }
}
