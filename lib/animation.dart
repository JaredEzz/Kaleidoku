import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kaleidoku/sudoku_grid_widget.dart';

class KaleidokuAnimation extends StatefulWidget {
  const KaleidokuAnimation({Key? key}) : super(key: key);

  @override
  _KaleidokuAnimationState createState() => _KaleidokuAnimationState();
}

class _KaleidokuAnimationState extends State<KaleidokuAnimation> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  final List<Animation<double>> _animations = [];
  final List<Color> _colors = List.filled(9, Colors.transparent);
  String? output;
  final int numSeconds = 5;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(9, (index) => AnimationController(
      duration: Duration(seconds: numSeconds),
      vsync: this,
    ));

    for (int i = 0; i < 9; i++) {
      _animations.add(Tween<double>(begin: -300, end: 0).animate(CurvedAnimation(
        parent: _controllers[i],
        curve: Interval(i / 9, (i + 1) / 9, curve: Curves.easeOut),
      )));
      _controllers[i].forward();

      Timer(Duration(microseconds: (numSeconds * 1000000 / 9 * (i + 1)).toInt()) , () {
        setState(() {
          _colors[i] = colorLookup.values.toList()[i];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: 'Kaleidoku'.split('').asMap().entries.map((e) {
                return AnimatedBuilder(
                  animation: _animations[e.key],
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(0, _animations[e.key].value),
                      child: Column(
                        children: [
                          Text(e.value, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                          Text('${e.key + 1}', style: TextStyle(color: _colors[e.key], fontSize: 24)),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
