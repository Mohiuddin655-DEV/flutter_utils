import 'package:flutter/material.dart';

class SearchViewController<T> extends TextEditingController {
  final List<T> items;
  String _query = '';
  List<T>? _queries;

  SearchViewController(this.items);

  String get query => _query;

  List<T> get queries => _queries ?? items;

  set query(String? value) {
    _query = (value ?? '').toLowerCase();
  }

  set queries(List<T>? value) => _queries = value;
}
