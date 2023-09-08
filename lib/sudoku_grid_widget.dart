import 'package:flutter/material.dart';

class SudokuGridWidget extends StatelessWidget {
  final List<List<int>> grid;
  final bool showNumbers;

  const SudokuGridWidget({
    Key? key,
    required this.grid,
    required this.showNumbers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxWidth,
        child: GridView.builder(
          itemCount: 81,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 9,
          ),
          itemBuilder: (BuildContext context, int index) {
            final row = index ~/ 9;
            final col = index % 9;
            final number = grid[row][col];

            final rightBorderThick = (col == 2 || col == 5);
            final leftBorderThick = (col == 3 || col == 6);
            final bottomBorderThick = (row == 2 || row == 5);
            final topBorderThick = (row == 3 || row == 6);
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: topBorderThick ? Colors.black : Colors.grey,
                    width: topBorderThick ? 2.0 : 1.0,
                  ),
                  left: BorderSide(
                    color: leftBorderThick ? Colors.black : Colors.grey,
                    width: leftBorderThick ? 2.0 : 1.0,
                  ),
                  right: BorderSide(
                    color: rightBorderThick ? Colors.black : Colors.grey,
                    width: rightBorderThick ? 2.0 : 1.0,
                  ),
                  bottom: BorderSide(
                    color: bottomBorderThick ? Colors.black : Colors.grey,
                    width: bottomBorderThick ? 2.0 : 1.0,
                  ),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Visibility(
                      visible: number != 0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: colorLookup[number] ?? Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            number.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: showNumbers
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            );
          },
        ),
      );
    });
  }
}

const Map<int, Color> colorLookup = {
  1: Color(0xFFA02123),
  2: Color(0xFFC84929),
  3: Color(0xFFD1B806),
  4: Color(0xFF2E8423),
  5: Color(0xFF005B26),
  6: Color(0xFF73B5CF),
  7: Color(0xFF0D4E8A),
  8: Color(0xFF845585),
  9: Color(0xFF3F214D),
};
