import 'package:flutter/material.dart';

import 'animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kaleidoku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const KaleidokuAnimation(),
    );
  }
}
