import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kaleidoku/core/utils/logger.dart';
import 'package:kaleidoku/features/levels_screen/cubits/puzzle_cubits/cubit/puzzle_cubit.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';
import 'package:kaleidoku/features/levels_screen/services/local_services/puzzle_hive_service.dart';
import 'package:kaleidoku/features/puzzle_of_the_day/services/notification_services/flutter_local_notifications_service.dart';
import 'package:kaleidoku/features/settings_screen/cubits/cubit/app_settings_cubit.dart';
import 'package:kaleidoku/features/settings_screen/services/local_services/settings_hive_service.dart';
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
  await notificationService.requestIOSPermissions();
}

Future<void> setupHive() async {
  try {
    await Hive.initFlutter();
    await Hive.openBox('puzzles');
    await Hive.openBox('defaultPuzzlesAdded');
    await Hive.openBox('appSettings');
    // await Hive.deleteBoxFromDisk('appSettings');
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
