// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:kaleidoku/features/sudoku/widgets/sudoku_grid_widget.dart';

// class SudokuScreen extends StatefulWidget {
//   const SudokuScreen({Key? key}) : super(key: key);

//   @override
//   State<SudokuScreen> createState() => _SudokuScreenState();
// }

// class _SudokuScreenState extends State<SudokuScreen> {
//   List<List<int>>? sudokuGrid;
//   List<List<int>>? solutionGrid;
//   // String selectedDifficulty = 'Medium';
//   bool showNumbers = false;

//   @override
//   Widget build(BuildContext context) {
//     if (sudokuGrid == null) {
//       return Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DropdownButton<String>(
//                 value: selectedDifficulty,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedDifficulty = newValue ?? "Medium";
//                   });
//                 },
//                 items: const <DropdownMenuItem<String>>[
//                   DropdownMenuItem<String>(
//                     value: 'Easy',
//                     child: Text('Easy'),
//                   ),
//                   DropdownMenuItem<String>(
//                     value: 'Medium',
//                     child: Text('Medium'),
//                   ),
//                   DropdownMenuItem<String>(
//                     value: 'Hard',
//                     child: Text('Hard'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: getPuzzle,
//                 child: const Text('Get Puzzle'),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Kaleidoku'),
//           actions: [
//             Tooltip(
//               message: showNumbers ? 'Hide Numbers' : 'Show Numbers',
//               child: Switch(
//                 value: showNumbers,
//                 onChanged: (value) {
//                   setState(() {
//                     showNumbers = value;
//                   });
//                 },
//                 activeTrackColor: Colors.lightGreenAccent,
//                 activeColor: Colors.green,
//                 inactiveTrackColor: Colors.grey,
//                 inactiveThumbColor: Colors.grey[300],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: IconButton(
//                 onPressed: getPuzzle,
//                 icon: const Icon(Icons.refresh),
//               ),
//             ),
//           ],
//         ),
//         body: ListView(
//           children: [
//             SudokuGridWidget(
//               grid: sudokuGrid!,
//               showNumbers: showNumbers,
//             ),
//             ExpansionTile(
//               title: const Text('Solution'),
//               initiallyExpanded: false,
//               children: <Widget>[
//                 SudokuGridWidget(
//                   grid: solutionGrid!,
//                   showNumbers: showNumbers,
//                 )
//               ],
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }
