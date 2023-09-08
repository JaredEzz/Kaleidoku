import 'package:flutter/material.dart';
import 'package:kaleidoku/features/welcome_screen/widgets/animation.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: KaleidokuAnimation());
  }
}
