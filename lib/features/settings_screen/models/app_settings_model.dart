import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_settings_model.g.dart';
part 'app_settings_model.freezed.dart';

@freezed
class AppSettingsModel with _$AppSettingsModel {
  const factory AppSettingsModel({
    required bool isDarkTheme,
    required bool isNotificationsOn,
    // ignore: invalid_annotation_target
    @JsonKey(fromJson: _createdOnFromJson) required DateTime notificationsTime,
  }) = _AppSettingsModel;

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsModelFromJson(json);
}

DateTime _createdOnFromJson(DateTime time) =>
    DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
