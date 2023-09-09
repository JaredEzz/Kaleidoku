import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kaleidoku/features/levels_screen/cubits/puzzle_cubits/cubit/puzzle_cubit.dart';
import 'package:kaleidoku/features/levels_screen/models/puzzle_model.dart';
import 'package:kaleidoku/features/levels_screen/services/local_services/puzzle_hive_service.dart';
import 'features/welcome_screen/widgets/animation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('puzzles');
  await Hive.openBox('defaultPuzzlesAdded');
  // await Hive.deleteBoxFromDisk('puzzles');
  // await Hive.deleteBoxFromDisk('defaultPuzzlesAdded');
  Hive.registerAdapter(PuzzleModelAdapter());
  Hive.registerAdapter(NewboardAdapter());
  Hive.registerAdapter(GridAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PuzzleCubit(puzzleHiveService: PuzzleHiveService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kaleidoku',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const KaleidokuAnimation(),
      ),
    );
  }
}
