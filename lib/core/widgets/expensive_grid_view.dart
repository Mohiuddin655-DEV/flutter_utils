import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/view_builder.dart';

class ExpensiveGridView extends StatefulWidget {
  final List<dynamic> items;
  final Axis direction;
  final int? itemCount;
  final int snapCount;

  final Widget Function(int index, dynamic item) builder;

  const ExpensiveGridView({
    Key? key,
    required this.items,
    required this.builder,
    this.direction = Axis.vertical,
    this.itemCount,
    this.snapCount = 1,
  }) : super(key: key);

  @override
  State<ExpensiveGridView> createState() => _ExpensiveGridViewState();
}

class _ExpensiveGridViewState extends State<ExpensiveGridView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    index = 0;
    return ViewBuilder(
      component: widget.direction == Axis.horizontal,
      builder: (value) {
        return value ? horizontalGrid : verticalGrid;
      },
    );
  }

  @override
  void didUpdateWidget(covariant ExpensiveGridView oldWidget) {
    index = 0;
    super.didUpdateWidget(oldWidget);
  }

  List<_Item> get items {
    List<_Item> list = [];
    if (widget.items.isNotEmpty) {
      list = widget.items
          .getRange(0, itemCount)
          .map((e) => _Item(data: e))
          .toList();
      if (missingCount > 0) {
        for (int i = 0; i < missingCount; i++) {
          list.add(const _Item(temporary: true));
        }
      }
    }
    return list;
  }

  int get itemCount {
    return min(
      widget.itemCount ?? (widget.items.length + 1),
      widget.items.length,
    );
  }

  int get snapCount => widget.snapCount;

  int get missingCount {
    final line = (itemCount / snapCount).ceil();
    final require = line * snapCount;
    final missing = require - itemCount;
    return missing.abs();
  }

  Widget get horizontalGrid {
    final end = (itemCount / snapCount).ceil();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: items.getRange(0, end).map((item) {
          final end = index + (snapCount);
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.getRange(index, end).map((item) {
              index++;
              return ViewBuilder(
                  component: !item.temporary,
                  builder: (value) => value
                      ? widget.builder.call(
                          index,
                          item.data,
                        )
                      : null);
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget get verticalGrid {
    final end = (itemCount / snapCount).ceil();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: items.getRange(0, end).map((item) {
        final end = index + (snapCount);
        return Row(
          children: items.getRange(index, end).map((item) {
            index++;
            return Expanded(
              child: ViewBuilder(
                  component: !item.temporary,
                  builder: (value) => value
                      ? widget.builder.call(
                          index,
                          item.data,
                        )
                      : null),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

class _Item {
  final dynamic data;
  final bool temporary;

  const _Item({
    this.data,
    this.temporary = false,
  });
}
