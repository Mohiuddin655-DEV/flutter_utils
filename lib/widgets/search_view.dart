import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SearchView<T> extends StatefulWidget {
  final Color primary;
  final String? hint;
  final SearchViewController<T>? controller;
  final List<T> items;
  final Function(String value)? onChanged;
  final bool Function(String key, T item)? keyBuilder;
  final Function(List<T>)? onQueries;

  const SearchView({
    Key? key,
    this.primary = Colors.black,
    this.hint,
    this.controller,
    this.items = const [],
    this.onChanged,
    this.keyBuilder,
    this.onQueries,
  }) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState<T>();
}

class _SearchViewState<T> extends State<SearchView<T>> {
  late SearchViewController<T> controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? SearchViewController<T>(widget.items);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onQueries?.call(widget.items);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: widget.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: widget.primary.withOpacity(0.5),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              style: TextStyle(
                color: widget.primary.withOpacity(0.8),
              ),
              onChanged: (value) {
                controller.query = value;
                widget.onChanged?.call(value);
                widget.onQueries?.call(items);
              },
              decoration: InputDecoration(
                hintText: widget.hint ?? "Search",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: widget.primary.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<T> get items {
    final list = <T>[];
    controller.items.map((item) {
      final valid = widget.keyBuilder?.call(controller.query, item);
      if (valid ?? false || controller.items.contains(item)) {
        list.add(item);
      }
    }).toList();
    controller.queries = list;
    return list;
  }
}

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
