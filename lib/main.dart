import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kaleidoku/core/consts/consts.dart';
import 'package:kaleidoku/core/utils/logger.dart';
import 'package:kaleidoku/features/levels_screen/cubits/puzzle_cubits/cubit/puzzle_cubit.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';
import 'package:kaleidoku/features/levels_screen/services/local_services/puzzle_hive_service.dart';
import 'package:kaleidoku/features/puzzle_of_the_day/cubits/cubit/puzzle_of_the_day_cubit.dart';
import 'package:kaleidoku/features/puzzle_of_the_day/services/local_services/puzzle_of_the_day_hive_service.dart';
import 'package:kaleidoku/features/puzzle_of_the_day/services/notification_services/flutter_local_notifications_service.dart';
import 'package:kaleidoku/features/puzzle_of_the_day/utils/global.dart';
import 'package:kaleidoku/features/settings_screen/cubits/cubit/app_settings_cubit.dart';
import 'package:kaleidoku/features/settings_screen/services/local_services/settings_hive_service.dart';
import 'package:kaleidoku/features/sudoku_screen/screens/sudoku_screen.dart';
import 'features/welcome_screen/widgets/animation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  await initNotifications();
  runApp(const MyApp());
}

Future<void> initNotifications() async {
  NotificationService notificationService = NotificationService();
  await notificationService.init();
  if (Platform.isIOS) {
    await notificationService.requestIOSPermissions();
  } else {
    await notificationService.requestAndroidPermission();
  }

  final initialNotification =
      await notificationService.getInitialNotification();

  if (initialNotification?.payload == 'puzzle') {
    final puzzleHiveService = PuzzleOfTheDayHiveService();
    final puzzle = await puzzleHiveService.getPuzzleFromHive();
    globalNotificationPayload = initialNotification!.payload;
    puzzleOfTheDay = puzzle;
  }
}

Future<void> setupHive() async {
  try {
    await Hive.initFlutter();
    await Hive.openBox('puzzles');
    await Hive.openBox('defaultPuzzlesAdded');
    await Hive.openBox('appSettings');
    await Hive.openBox('puzzleOfTheDay');
    Hive.registerAdapter(PuzzleModelAdapter());
    Hive.registerAdapter(NewboardAdapter());
    Hive.registerAdapter(GridAdapter());
  } catch (e) {
    logger.d("Error initializing Hive: $e");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    if (globalNotificationPayload == 'puzzle') {
      await Future.delayed(const Duration(milliseconds: 2000), () async {
        navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) =>
              SudokuScreen(puzzleGrid: puzzleOfTheDay!.newboard.grids.first),
        ));
      });
      globalNotificationPayload = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PuzzleCubit>(
          create: (context) =>
              PuzzleCubit(puzzleHiveService: PuzzleHiveService()),
        ),
        BlocProvider<AppSettingsCubit>(
            create: (context) =>
                AppSettingsCubit(service: SettingsHiveService())),
        BlocProvider<PuzzleOfTheDayCubit>(
            create: (context) => PuzzleOfTheDayCubit(
                puzzleHiveService: PuzzleOfTheDayHiveService())),
      ],
      child: Builder(
        builder: (innerContext) {
          innerContext.read<AppSettingsCubit>().getAppSettings();
          return BlocBuilder<AppSettingsCubit, AppSettingsState>(
            buildWhen: (previous, current) => previous != current,
            builder: (innerContext, state) {
              ThemeData themeData = ThemeData(
                  primarySwatch: Colors.green, brightness: Brightness.light);
              state.whenOrNull(
                success: (appSettings) {
                  if (appSettings.isDarkTheme) {
                    themeData = ThemeData(
                      primarySwatch: Colors.green,
                      brightness: Brightness.dark,
                    );
                  }
                },
              );
              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Kaleidoku',
                theme: themeData,
                home: const KaleidokuAnimation(),
              );
            },
          );
        },
      ),
    );
  }
}
