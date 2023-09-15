import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'puzzle_model.freezed.dart';
part 'puzzle_model.g.dart';

@HiveType(typeId: 0)
@freezed
class PuzzleModel with _$PuzzleModel {
  const factory PuzzleModel({
    @HiveField(0) required Newboard newboard,
  }) = _PuzzleModel;

  factory PuzzleModel.fromJson(Map<String, dynamic> json) =>
      _$PuzzleModelFromJson(json);
}

@HiveType(typeId: 1)
@freezed
class Newboard with _$Newboard {
  const factory Newboard({
    @HiveField(0) required List<Grid> grids,
  }) = _Newboard;

  factory Newboard.fromJson(Map<String, dynamic> json) =>
      _$NewboardFromJson(json);
}

@HiveType(typeId: 2)
@freezed
class Grid with _$Grid {
  const factory Grid({
    @HiveField(0) required List<List<int>> value,
    @HiveField(1) required List<List<int>> solution,
    @HiveField(2) required String difficulty,
    // ignore: invalid_annotation_target
    @JsonKey(fromJson: _numberFromJson) @HiveField(3) required int number,
  }) = _Grid;

  factory Grid.fromJson(Map<String, dynamic> json) => _$GridFromJson(json);
}

int _numberFromJson(dynamic json) {
  if (json == null) {
    return 0;
  } else {
    return json as int;
  }
}
