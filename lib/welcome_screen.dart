import 'package:flutter/material.dart';
import 'package:kaleidoku/sudoku_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Kaleidoku',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // add placeholder for logo and particle effects
            ElevatedButton(
              onPressed: () {
                //navigate to sudoku screen
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const SudokuScreen()));
              },
              child: const Text('Begin'),
            ),
          ],
        ),
      ),
    );
  }
}
