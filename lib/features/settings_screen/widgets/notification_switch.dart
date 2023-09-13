import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaleidoku/features/settings_screen/cubits/cubit/app_settings_cubit.dart';
import 'package:kaleidoku/features/settings_screen/models/app_settings_model.dart';

class NotificationSwitch extends StatefulWidget {
  final AppSettingsModel appSettingsModel;

  const NotificationSwitch({super.key, required this.appSettingsModel});

  @override
  ThemeSwitchState createState() => ThemeSwitchState();
}

class ThemeSwitchState extends State<NotificationSwitch> {
  bool _isNotificationOn = false;
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    _isNotificationOn = widget.appSettingsModel.isNotificationsOn;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isNotificationOn,
      onChanged: (value) {
        setState(() {
          _isNotificationOn = value;
        });
        debounce?.cancel();
        debounce = Timer(const Duration(milliseconds: 250), () {
          context.read<AppSettingsCubit>().updateNotifications(value: value);
        });
      },
    );
  }
}
