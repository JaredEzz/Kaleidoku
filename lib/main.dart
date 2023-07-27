import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphQLConfiguration.myClient(),
      child: CacheProvider(
        child: MaterialApp(
          title: 'Sudoku App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SudokuScreen(), // your main screen
        ),
      ),
    );
  }
}
