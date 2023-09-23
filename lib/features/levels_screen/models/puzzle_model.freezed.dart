// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'puzzle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PuzzleModel _$PuzzleModelFromJson(Map<String, dynamic> json) {
  return _PuzzleModel.fromJson(json);
}

/// @nodoc
mixin _$PuzzleModel {
  @HiveField(0)
  Newboard get newboard => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PuzzleModelCopyWith<PuzzleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PuzzleModelCopyWith<$Res> {
  factory $PuzzleModelCopyWith(
          PuzzleModel value, $Res Function(PuzzleModel) then) =
      _$PuzzleModelCopyWithImpl<$Res, PuzzleModel>;
  @useResult
  $Res call({@HiveField(0) Newboard newboard});

  $NewboardCopyWith<$Res> get newboard;
}

/// @nodoc
class _$PuzzleModelCopyWithImpl<$Res, $Val extends PuzzleModel>
    implements $PuzzleModelCopyWith<$Res> {
  _$PuzzleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newboard = null,
  }) {
    return _then(_value.copyWith(
      newboard: null == newboard
          ? _value.newboard
          : newboard // ignore: cast_nullable_to_non_nullable
              as Newboard,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NewboardCopyWith<$Res> get newboard {
    return $NewboardCopyWith<$Res>(_value.newboard, (value) {
      return _then(_value.copyWith(newboard: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PuzzleModelCopyWith<$Res>
    implements $PuzzleModelCopyWith<$Res> {
  factory _$$_PuzzleModelCopyWith(
          _$_PuzzleModel value, $Res Function(_$_PuzzleModel) then) =
      __$$_PuzzleModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) Newboard newboard});

  @override
  $NewboardCopyWith<$Res> get newboard;
}

/// @nodoc
class __$$_PuzzleModelCopyWithImpl<$Res>
    extends _$PuzzleModelCopyWithImpl<$Res, _$_PuzzleModel>
    implements _$$_PuzzleModelCopyWith<$Res> {
  __$$_PuzzleModelCopyWithImpl(
      _$_PuzzleModel _value, $Res Function(_$_PuzzleModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newboard = null,
  }) {
    return _then(_$_PuzzleModel(
      newboard: null == newboard
          ? _value.newboard
          : newboard // ignore: cast_nullable_to_non_nullable
              as Newboard,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PuzzleModel implements _PuzzleModel {
  const _$_PuzzleModel({@HiveField(0) required this.newboard});

  factory _$_PuzzleModel.fromJson(Map<String, dynamic> json) =>
      _$$_PuzzleModelFromJson(json);

  @override
  @HiveField(0)
  final Newboard newboard;

  @override
  String toString() {
    return 'PuzzleModel(newboard: $newboard)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PuzzleModel &&
            (identical(other.newboard, newboard) ||
                other.newboard == newboard));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, newboard);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PuzzleModelCopyWith<_$_PuzzleModel> get copyWith =>
      __$$_PuzzleModelCopyWithImpl<_$_PuzzleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PuzzleModelToJson(
      this,
    );
  }
}

abstract class _PuzzleModel implements PuzzleModel {
  const factory _PuzzleModel({@HiveField(0) required final Newboard newboard}) =
      _$_PuzzleModel;

  factory _PuzzleModel.fromJson(Map<String, dynamic> json) =
      _$_PuzzleModel.fromJson;

  @override
  @HiveField(0)
  Newboard get newboard;
  @override
  @JsonKey(ignore: true)
  _$$_PuzzleModelCopyWith<_$_PuzzleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

Newboard _$NewboardFromJson(Map<String, dynamic> json) {
  return _Newboard.fromJson(json);
}

/// @nodoc
mixin _$Newboard {
  @HiveField(0)
  List<Grid> get grids => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewboardCopyWith<Newboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewboardCopyWith<$Res> {
  factory $NewboardCopyWith(Newboard value, $Res Function(Newboard) then) =
      _$NewboardCopyWithImpl<$Res, Newboard>;
  @useResult
  $Res call({@HiveField(0) List<Grid> grids});
}

/// @nodoc
class _$NewboardCopyWithImpl<$Res, $Val extends Newboard>
    implements $NewboardCopyWith<$Res> {
  _$NewboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grids = null,
  }) {
    return _then(_value.copyWith(
      grids: null == grids
          ? _value.grids
          : grids // ignore: cast_nullable_to_non_nullable
              as List<Grid>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewboardCopyWith<$Res> implements $NewboardCopyWith<$Res> {
  factory _$$_NewboardCopyWith(
          _$_Newboard value, $Res Function(_$_Newboard) then) =
      __$$_NewboardCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) List<Grid> grids});
}

/// @nodoc
class __$$_NewboardCopyWithImpl<$Res>
    extends _$NewboardCopyWithImpl<$Res, _$_Newboard>
    implements _$$_NewboardCopyWith<$Res> {
  __$$_NewboardCopyWithImpl(
      _$_Newboard _value, $Res Function(_$_Newboard) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grids = null,
  }) {
    return _then(_$_Newboard(
      grids: null == grids
          ? _value._grids
          : grids // ignore: cast_nullable_to_non_nullable
              as List<Grid>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Newboard implements _Newboard {
  const _$_Newboard({@HiveField(0) required final List<Grid> grids})
      : _grids = grids;

  factory _$_Newboard.fromJson(Map<String, dynamic> json) =>
      _$$_NewboardFromJson(json);

  final List<Grid> _grids;
  @override
  @HiveField(0)
  List<Grid> get grids {
    if (_grids is EqualUnmodifiableListView) return _grids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_grids);
  }

  @override
  String toString() {
    return 'Newboard(grids: $grids)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Newboard &&
            const DeepCollectionEquality().equals(other._grids, _grids));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_grids));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewboardCopyWith<_$_Newboard> get copyWith =>
      __$$_NewboardCopyWithImpl<_$_Newboard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NewboardToJson(
      this,
    );
  }
}

abstract class _Newboard implements Newboard {
  const factory _Newboard({@HiveField(0) required final List<Grid> grids}) =
      _$_Newboard;

  factory _Newboard.fromJson(Map<String, dynamic> json) = _$_Newboard.fromJson;

  @override
  @HiveField(0)
  List<Grid> get grids;
  @override
  @JsonKey(ignore: true)
  _$$_NewboardCopyWith<_$_Newboard> get copyWith =>
      throw _privateConstructorUsedError;
}

Grid _$GridFromJson(Map<String, dynamic> json) {
  return _Grid.fromJson(json);
}

/// @nodoc
mixin _$Grid {
  @HiveField(0)
  List<List<int>> get value => throw _privateConstructorUsedError;
  @HiveField(1)
  List<List<int>> get solution => throw _privateConstructorUsedError;
  @HiveField(2)
  String get difficulty => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numberFromJson)
  @HiveField(3)
  int get number => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GridCopyWith<Grid> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GridCopyWith<$Res> {
  factory $GridCopyWith(Grid value, $Res Function(Grid) then) =
      _$GridCopyWithImpl<$Res, Grid>;
  @useResult
  $Res call(
      {@HiveField(0) List<List<int>> value,
      @HiveField(1) List<List<int>> solution,
      @HiveField(2) String difficulty,
      @JsonKey(fromJson: _numberFromJson) @HiveField(3) int number});
}

/// @nodoc
class _$GridCopyWithImpl<$Res, $Val extends Grid>
    implements $GridCopyWith<$Res> {
  _$GridCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? solution = null,
    Object? difficulty = null,
    Object? number = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      solution: null == solution
          ? _value.solution
          : solution // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GridCopyWith<$Res> implements $GridCopyWith<$Res> {
  factory _$$_GridCopyWith(_$_Grid value, $Res Function(_$_Grid) then) =
      __$$_GridCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) List<List<int>> value,
      @HiveField(1) List<List<int>> solution,
      @HiveField(2) String difficulty,
      @JsonKey(fromJson: _numberFromJson) @HiveField(3) int number});
}

/// @nodoc
class __$$_GridCopyWithImpl<$Res> extends _$GridCopyWithImpl<$Res, _$_Grid>
    implements _$$_GridCopyWith<$Res> {
  __$$_GridCopyWithImpl(_$_Grid _value, $Res Function(_$_Grid) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? solution = null,
    Object? difficulty = null,
    Object? number = null,
  }) {
    return _then(_$_Grid(
      value: null == value
          ? _value._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      solution: null == solution
          ? _value._solution
          : solution // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Grid implements _Grid {
  const _$_Grid(
      {@HiveField(0) required final List<List<int>> value,
      @HiveField(1) required final List<List<int>> solution,
      @HiveField(2) required this.difficulty,
      @JsonKey(fromJson: _numberFromJson) @HiveField(3) required this.number})
      : _value = value,
        _solution = solution;

  factory _$_Grid.fromJson(Map<String, dynamic> json) => _$$_GridFromJson(json);

  final List<List<int>> _value;
  @override
  @HiveField(0)
  List<List<int>> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  final List<List<int>> _solution;
  @override
  @HiveField(1)
  List<List<int>> get solution {
    if (_solution is EqualUnmodifiableListView) return _solution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_solution);
  }

  @override
  @HiveField(2)
  final String difficulty;
  @override
  @JsonKey(fromJson: _numberFromJson)
  @HiveField(3)
  final int number;

  @override
  String toString() {
    return 'Grid(value: $value, solution: $solution, difficulty: $difficulty, number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Grid &&
            const DeepCollectionEquality().equals(other._value, _value) &&
            const DeepCollectionEquality().equals(other._solution, _solution) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.number, number) || other.number == number));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_value),
      const DeepCollectionEquality().hash(_solution),
      difficulty,
      number);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GridCopyWith<_$_Grid> get copyWith =>
      __$$_GridCopyWithImpl<_$_Grid>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GridToJson(
      this,
    );
  }
}

abstract class _Grid implements Grid {
  const factory _Grid(
      {@HiveField(0) required final List<List<int>> value,
      @HiveField(1) required final List<List<int>> solution,
      @HiveField(2) required final String difficulty,
      @JsonKey(fromJson: _numberFromJson)
      @HiveField(3)
      required final int number}) = _$_Grid;

  factory _Grid.fromJson(Map<String, dynamic> json) = _$_Grid.fromJson;

  @override
  @HiveField(0)
  List<List<int>> get value;
  @override
  @HiveField(1)
  List<List<int>> get solution;
  @override
  @HiveField(2)
  String get difficulty;
  @override
  @JsonKey(fromJson: _numberFromJson)
  @HiveField(3)
  int get number;
  @override
  @JsonKey(ignore: true)
  _$$_GridCopyWith<_$_Grid> get copyWith => throw _privateConstructorUsedError;
}
