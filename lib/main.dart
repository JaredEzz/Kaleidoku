import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kaleidoku/features/levels_screen/cubits/puzzle_cubits/cubit/puzzle_cubit.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';
import 'package:kaleidoku/features/levels_screen/services/local_services/puzzle_hive_service.dart';
import 'package:kaleidoku/features/settings_screen/cubits/cubit/app_settings_cubit.dart';
import 'package:kaleidoku/features/settings_screen/services/local_services/settings_hive_service.dart';
import 'features/welcome_screen/widgets/animation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  runApp(const MyApp());
}

Future<void> setupHive() async {
  await Hive.initFlutter();
  await Hive.openBox('puzzles');
  await Hive.openBox('defaultPuzzlesAdded');
  await Hive.openBox('appSettings');
  Hive.registerAdapter(PuzzleModelAdapter());
  Hive.registerAdapter(NewboardAdapter());
  Hive.registerAdapter(GridAdapter());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void fetchAppTheme(BuildContext context) {
    context.read<AppSettingsCubit>().getAppSettings();
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
      ],
      child: Builder(
        builder: (innerContext) {
          fetchAppTheme(innerContext);
          return BlocBuilder<AppSettingsCubit, AppSettingsState>(
            buildWhen: (previous, current) => true,
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
