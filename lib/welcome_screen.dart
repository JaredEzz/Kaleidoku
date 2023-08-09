import 'package:flutter/material.dart';
import 'package:kaleidoku/sudoku_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Kaleidoku',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            // add placeholder for logo and particle effects
            ElevatedButton(
              onPressed: () {
                //navigate to sudoku screen
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => SudokuScreen()));
              },
              child: Text('Begin'),
            ),
          ],
        ),
      ),
    );
  }
}
