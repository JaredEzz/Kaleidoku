import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:kaleidoku/core/consts/consts.dart';
import 'package:kaleidoku/features/puzzle_of_the_day/services/local_services/puzzle_of_the_day_hive_service.dart';
import 'package:kaleidoku/features/puzzle_of_the_day/utils/global.dart';
import 'package:kaleidoku/features/sudoku_screen/screens/sudoku_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void backgroundNotificationHandler(NotificationResponse? details) async {}

Future<void> onNotificationTapped(NotificationResponse? payload) async {
  if (payload!.payload == 'puzzle') {
    final puzzleHiveService = PuzzleOfTheDayHiveService();
    final puzzle = await puzzleHiveService.getPuzzleFromHive();
    if (navigatorKey.currentState == null) {
      globalNotificationPayload = payload.payload;
      puzzleOfTheDay = puzzle;
    } else {
      navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) =>
            SudokuScreen(puzzleGrid: puzzle.newboard.grids.first),
      ));
    }
  }
}

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }

  Future<NotificationResponse?> getInitialNotification() async {
    final launchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      return NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification,
          payload: launchDetails!.notificationResponse!.payload);
    }
    return null;
  }

  NotificationService._internal();

  static const channelId = "1";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    channelId,
    "kaleidoku",
    channelDescription:
        "This channel is responsible for all the local notifications",
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  static const DarwinNotificationDetails _darwinNotificationDetails =
      DarwinNotificationDetails();

  final NotificationDetails notificationDetails = const NotificationDetails(
    android: _androidNotificationDetails,
    iOS: _darwinNotificationDetails,
  );

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
      context: dialogKey.currentContext!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ''),
        content: Text(body ?? ''),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    // *** Initialize timezone here ***
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: backgroundNotificationHandler,
      onDidReceiveNotificationResponse: onNotificationTapped,
    );
  }

  Future<void> requestAndroidPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotification(
      int id, String title, String body, String payload) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> scheduleNotification(
      int id,
      String title,
      String body,
      DateTime eventDate,
      TimeOfDay eventTime,
      String payload,
      String time,
      int? hours,
      [DateTimeComponents? dateTimeComponents]) async {
    eventDate = DateTime(eventDate.year, eventDate.month, eventDate.day);

    final scheduledTime = eventDate.add(Duration(
      hours: eventTime.hour,
      minutes: eventTime.minute,
    ));

    tz.TZDateTime nextInstanceOfTenAM() {
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduledTime, tz.local);

      if (time == 'daily') {
        if (scheduledDate.isBefore(now)) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
        }
      } else if (time == 'hourly') {
        if (scheduledDate.isBefore(now)) {
          scheduledDate = scheduledDate.add(Duration(hours: hours!));
        }
      }
      return scheduledDate;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      nextInstanceOfTenAM(),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
      matchDateTimeComponents: dateTimeComponents,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<List<PendingNotificationRequest>> getNotifications() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await FlutterLocalNotificationsPlugin().pendingNotificationRequests();
    return pendingNotificationRequests;
  }
}
