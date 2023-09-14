// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'app_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppSettingsModel _$$_AppSettingsModelFromJson(Map<String, dynamic> json) =>
    _$_AppSettingsModel(
      isDarkTheme: json['isDarkTheme'] as bool,
      isNotificationsOn: json['isNotificationsOn'] as bool,
      notificationsTime: json['notificationsTime'] as String,
    );

Map<String, dynamic> _$$_AppSettingsModelToJson(_$_AppSettingsModel instance) =>
    <String, dynamic>{
      'isDarkTheme': instance.isDarkTheme,
      'isNotificationsOn': instance.isNotificationsOn,
      'notificationsTime': instance.notificationsTime,
    };
