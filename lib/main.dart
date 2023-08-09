import 'package:flutter/material.dart';
import 'package:kaleidoku/welcome_screen.dart';

import 'animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Kaleidoku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KaleidokuAnimation(),
    );
  }
}
