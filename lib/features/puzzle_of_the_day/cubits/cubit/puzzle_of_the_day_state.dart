part of 'puzzle_of_the_day_cubit.dart';

@freezed
class PuzzleOfTheDayState with _$PuzzleOfTheDayState {
  const factory PuzzleOfTheDayState.initial() = _Initial;
  const factory PuzzleOfTheDayState.loading() = _Loading;
  const factory PuzzleOfTheDayState.error(String message) = _Error;
  const factory PuzzleOfTheDayState.success(PuzzleModel puzzle) = _Success;
}
