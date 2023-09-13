// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppSettingsModel _$$_AppSettingsModelFromJson(Map<String, dynamic> json) =>
    _$_AppSettingsModel(
      isDarkTheme: json['isDarkTheme'] as bool,
      isNotificationsOn: json['isNotificationsOn'] as bool,
      notificationsTime:
          _createdOnFromJson(json['notificationsTime'] as String),
    );

Map<String, dynamic> _$$_AppSettingsModelToJson(_$_AppSettingsModel instance) =>
    <String, dynamic>{
      'isDarkTheme': instance.isDarkTheme,
      'isNotificationsOn': instance.isNotificationsOn,
      'notificationsTime': instance.notificationsTime.toIso8601String(),
    };
