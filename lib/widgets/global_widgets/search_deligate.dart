import 'package:customrig/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: super.appBarTheme(context).appBarTheme.copyWith(
                elevation: 0.0,
              ),
        );
  }

  @override
  String get searchFieldLabel => 'Search for parts, accessories etc';

  List<String> suggestions = [
    'Gaming pc',
    'Mouse',
    'School pc',
    'Keyboard',
    'Graphic card'
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(
        Ionicons.arrow_back,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ProductListPage(
      title: query,
      value: query,
      isSearch: true,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
