import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  final Color primary;
  final String? hint;
  final TextEditingController? controller;
  final Function(String value)? onChanged;

  const SearchView({
    Key? key,
    this.primary = Colors.black,
    this.hint,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
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
              onChanged: widget.onChanged,
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
}
