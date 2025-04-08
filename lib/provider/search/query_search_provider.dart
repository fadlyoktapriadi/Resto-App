import 'package:flutter/material.dart';

class SearchQueryProvider extends ChangeNotifier {
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void updateQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}