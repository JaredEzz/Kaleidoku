import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kaleidoku/core/utils/logger.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';
import 'package:kaleidoku/features/puzzle_of_the_day/services/local_services/puzzle_of_the_day_hive_service.dart';

part 'puzzle_of_the_day_state.dart';
part 'puzzle_of_the_day_cubit.freezed.dart';

class PuzzleOfTheDayCubit extends Cubit<PuzzleOfTheDayState> {
  final PuzzleOfTheDayHiveService puzzleHiveService;
  PuzzleOfTheDayCubit({required this.puzzleHiveService})
      : super(const PuzzleOfTheDayState.initial());

  FutureOr<void> getPuzzleFromHive() async {
    try {
      logger.d('Attempting to fetch puzzle from Hive');
      emit(const PuzzleOfTheDayState.loading());
      final puzzle = await puzzleHiveService.getPuzzleFromHive();
      logger.d('Successfully fetched puzzle from Hive');
      emit(PuzzleOfTheDayState.success(puzzle));
    } catch (e, st) {
      logger.d('Failed to fetch puzzle from Hive', error: e, stackTrace: st);
      emit(PuzzleOfTheDayState.error(e.toString()));
    }
  }
}
