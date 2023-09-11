// To parse this JSON data, do
//
//     final puzzleModel = puzzleModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
part 'puzzle_model.freezed.dart';
part 'puzzle_model.g.dart';

PuzzleModel puzzleModelFromJson(String str) =>
    PuzzleModel.fromJson(json.decode(str));

String puzzleModelToJson(PuzzleModel data) => json.encode(data.toJson());

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
    @HiveField(1) required int results,
    @HiveField(2) required String message,
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
  }) = _Grid;

  factory Grid.fromJson(Map<String, dynamic> json) => _$GridFromJson(json);
}