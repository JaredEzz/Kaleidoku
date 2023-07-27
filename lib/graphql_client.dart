import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  final String _apiUrl = "your-graphql-endpoint";

  GraphQLClient myClient() {
    final HttpLink _httpLink = HttpLink(_apiUrl);
    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: _httpLink,
    );
  }
}
