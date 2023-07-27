import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SudokuScreen extends StatelessWidget {
  final String getPuzzleQuery = """
    query GetPuzzle {
      getPuzzle {
        puzzle
        solution
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(getPuzzleQuery)),
      builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return CircularProgressIndicator();
        }

        var puzzle = result.data?['getPuzzle']['puzzle'];
        var solution = result.data?['getPuzzle']['solution'];

        return Column(
          children: <Widget>[
            SudokuPuzzle(puzzle),  // Display the puzzle
            ElevatedButton(
              child: Text("Show Solution"),
              onPressed: () => SudokuSolution(solution), // Show solution when button is pressed
            ),
          ],
        );
      },
    );
  }
}
