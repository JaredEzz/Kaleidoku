part of 'puzzle_cubit.dart';

@freezed
class PuzzleState with _$PuzzleState {
  const factory PuzzleState.initial() = _Initial;
  const factory PuzzleState.loading() = _Loading;
  const factory PuzzleState.error(String message) = _Error;
  const factory PuzzleState.success(PuzzleModel puzzles) = _Success;
}
