// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'puzzle_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PuzzleModelAdapter extends TypeAdapter<PuzzleModel> {
  @override
  final int typeId = 0;

  @override
  PuzzleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PuzzleModel(
      newboard: fields[0] as Newboard,
    );
  }

  @override
  void write(BinaryWriter writer, PuzzleModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.newboard);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PuzzleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NewboardAdapter extends TypeAdapter<Newboard> {
  @override
  final int typeId = 1;

  @override
  Newboard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Newboard(
      grids: (fields[0] as List).cast<Grid>(),
    );
  }

  @override
  void write(BinaryWriter writer, Newboard obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.grids);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewboardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GridAdapter extends TypeAdapter<Grid> {
  @override
  final int typeId = 2;

  @override
  Grid read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Grid(
      value: (fields[0] as List)
          .map((dynamic e) => (e as List).cast<int>())
          .toList(),
      solution: (fields[1] as List)
          .map((dynamic e) => (e as List).cast<int>())
          .toList(),
      difficulty: fields[2] as String,
      number: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Grid obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.solution)
      ..writeByte(2)
      ..write(obj.difficulty)
      ..writeByte(3)
      ..write(obj.number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GridAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PuzzleModel _$$_PuzzleModelFromJson(Map<String, dynamic> json) =>
    _$_PuzzleModel(
      newboard: Newboard.fromJson(json['newboard'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PuzzleModelToJson(_$_PuzzleModel instance) =>
    <String, dynamic>{
      'newboard': instance.newboard,
    };

_$_Newboard _$$_NewboardFromJson(Map<String, dynamic> json) => _$_Newboard(
      grids: (json['grids'] as List<dynamic>)
          .map((e) => Grid.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_NewboardToJson(_$_Newboard instance) =>
    <String, dynamic>{
      'grids': instance.grids,
    };

_$_Grid _$$_GridFromJson(Map<String, dynamic> json) => _$_Grid(
      value: (json['value'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      solution: (json['solution'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      difficulty: json['difficulty'] as String,
      number: _numberFromJson(json['number']),
    );

Map<String, dynamic> _$$_GridToJson(_$_Grid instance) => <String, dynamic>{
      'value': instance.value,
      'solution': instance.solution,
      'difficulty': instance.difficulty,
      'number': instance.number,
    };
