import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaleidoku/features/settings_screen/cubits/cubit/app_settings_cubit.dart';
import 'package:kaleidoku/features/settings_screen/models/app_settings_model.dart';

class ThemeSwitch extends StatefulWidget {
  final AppSettingsModel appSettingsModel;

  const ThemeSwitch({super.key, required this.appSettingsModel});

  @override
  ThemeSwitchState createState() => ThemeSwitchState();
}

class ThemeSwitchState extends State<ThemeSwitch> {
  bool _isDarkTheme = false;
  bool _isNotificationOn = false;

  @override
  void initState() {
    super.initState();
    _isDarkTheme = widget.appSettingsModel.isDarkTheme;
    _isNotificationOn = widget.appSettingsModel.isNotificationsOn;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isDarkTheme,
      onChanged: (value) {
        setState(() {
          _isDarkTheme = value;
        });

        context.read<AppSettingsCubit>().updateAppSettings(item: {
          "isNotificationsOn": _isNotificationOn,
          "isDarkTheme": value
        });
      },
    );
  }
}
