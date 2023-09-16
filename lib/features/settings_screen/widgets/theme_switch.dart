import 'dart:async';

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
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    _isDarkTheme = widget.appSettingsModel.isDarkTheme;
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isDarkTheme,
      onChanged: (value) {
        setState(() {
          _isDarkTheme = value;
        });
        debounce?.cancel();
        debounce = Timer(const Duration(milliseconds: 300), () {
          context.read<AppSettingsCubit>().updateTheme(value: value);
        });
      },
    );
  }
}
