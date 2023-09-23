import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaleidoku/features/puzzle_of_the_day/services/notification_services/flutter_local_notifications_service.dart';
import 'package:kaleidoku/features/settings_screen/cubits/cubit/app_settings_cubit.dart';
import 'package:kaleidoku/features/settings_screen/models/app_settings_model.dart';

class NotificationSwitch extends StatefulWidget {
  final AppSettingsModel appSettingsModel;

  const NotificationSwitch({super.key, required this.appSettingsModel});

  @override
  NotificationSwitchState createState() => NotificationSwitchState();
}

class NotificationSwitchState extends State<NotificationSwitch> {
  bool _isNotificationOn = false;
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    _isNotificationOn = widget.appSettingsModel.isNotificationsOn;
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isNotificationOn,
      onChanged: (value) {
        setState(() {
          _isNotificationOn = value;
        });
        if (value == false) {
          NotificationService().cancelAllNotifications();
        }
        debounce?.cancel();
        debounce = Timer(const Duration(milliseconds: 250), () {
          context.read<AppSettingsCubit>().updateNotifications(value: value);
        });
      },
    );
  }
}
