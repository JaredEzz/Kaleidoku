import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kaleidoku/core/utils/logger.dart';
import 'package:kaleidoku/features/settings_screen/models/app_settings_model.dart';
import 'package:kaleidoku/features/settings_screen/services/local_services/settings_hive_service.dart';

part 'app_settings_state.dart';
part 'app_settings_cubit.freezed.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  final SettingsHiveService service;
  AppSettingsCubit({required this.service})
      : super(const AppSettingsState.initial());

  void getAppSettings() {
    try {
      logger.d('Attempting to fetch app settings');
      emit(const AppSettingsState.loading());
      final result = service.getAppSettings();
      emit(AppSettingsState.success(result));
      logger.d('Successfully fetched app settings');
    } catch (e, st) {
      logger.d('Error: Failed to fetch app settings', error: e, stackTrace: st);
      emit(AppSettingsState.error(e.toString()));
    }
  }

  Future<void> updateNotifications({required bool value}) async {
    try {
      logger.d('Attempting to update notification value');
      emit(const AppSettingsState.loading());
      await service.updateNotifications(value);
      final result = service.getAppSettings();
      emit(AppSettingsState.success(result));
      logger.d('Successfully updated notification value');
    } catch (e, st) {
      logger.d('Error: Failed to update notification value',
          error: e, stackTrace: st);
      emit(AppSettingsState.error(e.toString()));
    }
  }

  Future<void> updateNotificaitonsTime({required String time}) async {
    try {
      logger.d('Attempting to update notifications time');
      emit(const AppSettingsState.loading());
      await service.updateNotificationsTime(time);
      final result = service.getAppSettings();
      emit(AppSettingsState.success(result));
      logger.d('Successfully updated notifications time');
    } catch (e, st) {
      logger.d('Error: Failed to update notifications time',
          error: e, stackTrace: st);
      emit(AppSettingsState.error(e.toString()));
    }
  }

  Future<void> updateTheme({required bool value}) async {
    try {
      logger.d('Attempting to update app settings');
      emit(const AppSettingsState.loading());
      await service.updateTheme(value);
      final result = service.getAppSettings();
      emit(AppSettingsState.success(result));
      logger.d('Successfully updated app settings');
    } catch (e, st) {
      logger.d('Error: Failed to update app settings',
          error: e, stackTrace: st);
      emit(AppSettingsState.error(e.toString()));
    }
  }
}
