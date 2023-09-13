import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kaleidoku/core/utils/logger.dart';
import 'package:kaleidoku/core/utils/parser.dart';
import 'package:kaleidoku/features/settings_screen/models/app_settings_model.dart';
import 'package:kaleidoku/features/settings_screen/utils/consts.dart';

class SettingsHiveService {
  final _settings = Hive.box(APP_SETTINGS_BOX);

  Future<void> updateSettings(Map<String, dynamic> item) async {
    try {
      logger.d('Updating settings');
      await _settings.put('appSettings', item);
      logger.d('Successfully updated settings');
    } catch (e, st) {
      logger.d('Failed to update settings', error: e, stackTrace: st);
    }
  }

  AppSettingsModel getAppSettings() {
    final defaultSettingsAdded = _settings.get('appSettings', defaultValue: {
      "isDarkTheme": false,
      "isNotificationsOn": false,
    });

    return AppSettingsModel.fromJson(parser(defaultSettingsAdded));
  }
}
