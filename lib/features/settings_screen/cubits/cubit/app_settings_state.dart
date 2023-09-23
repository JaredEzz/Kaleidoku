part of 'app_settings_cubit.dart';

@freezed
class AppSettingsState with _$AppSettingsState {
  const factory AppSettingsState.initial() = _Initial;
  const factory AppSettingsState.loading() = _Loading;
  const factory AppSettingsState.error(String message) = _Error;
  const factory AppSettingsState.success(AppSettingsModel appSettings) =
      _Success;
}
