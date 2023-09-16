import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kaleidoku/core/utils/logger.dart';
import 'package:kaleidoku/core/utils/parser.dart';
import 'package:kaleidoku/features/settings_screen/models/app_settings_model.dart';
import 'package:kaleidoku/features/settings_screen/utils/consts.dart';

class SettingsHiveService {
  final _settings = Hive.box(APP_SETTINGS_BOX);

  Future<void> _updateSettings(Map<String, dynamic> updates) async {
    try {
      final currentSettings = getAppSettings().toJson();
      final updatedSettings = {...currentSettings, ...updates};
      await _settings.put(APP_SETTINGS_KEY, updatedSettings);
    } catch (e, st) {
      logger.d('Failed to update settings', error: e, stackTrace: st);
    }
  }

  Future<void> updateNotificationsTime(String time) async {
    await _updateSettings({"notificationsTime": time});
  }

  Future<void> updateNotifications(bool value) async {
    await _updateSettings({"isNotificationsOn": value});
  }

  Future<void> updateTheme(bool value) async {
    await _updateSettings({"isDarkTheme": value});
  }

  AppSettingsModel getAppSettings() {
    final defaultSettings = {
      "isDarkTheme": false,
      "isNotificationsOn": false,
      "notificationsTime": DateTime.now().toString(),
    };
    final settings =
        _settings.get(APP_SETTINGS_KEY, defaultValue: defaultSettings);
    return AppSettingsModel.fromJson(parser(settings));
  }
}
