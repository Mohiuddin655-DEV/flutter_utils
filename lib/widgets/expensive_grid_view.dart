import 'dart:math';

import 'package:flutter/material.dart';

class ExpensiveGridView extends StatefulWidget {
  final List<dynamic> items;
  final Axis direction;
  final int? itemCount;
  final int snapCount;
  final bool scrollingEnabled;
  final ScrollPhysics? physics;

  final Widget Function(int index, dynamic item) builder;

  const ExpensiveGridView({
    Key? key,
    required this.items,
    required this.builder,
    this.direction = Axis.vertical,
    this.itemCount,
    this.snapCount = 1,
    this.scrollingEnabled = true,
    this.physics,
  }) : super(key: key);

  @override
  State<ExpensiveGridView> createState() => _ExpensiveGridViewState();
}

class _ExpensiveGridViewState extends State<ExpensiveGridView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    index = 0;
    return _ViewBuilder(
      component: widget.direction == Axis.horizontal,
      builder: (value) {
        return value ? _horizontal : _vertical;
      },
    );
  }

  @override
  void didUpdateWidget(covariant ExpensiveGridView oldWidget) {
    index = 0;
    super.didUpdateWidget(oldWidget);
  }

  List<_Item> get _items {
    List<_Item> list = [];
    if (widget.items.isNotEmpty) {
      list = widget.items
          .getRange(0, _itemCount)
          .map((e) => _Item(data: e))
          .toList();
      if (_missingCount > 0) {
        for (int i = 0; i < _missingCount; i++) {
          list.add(const _Item(temporary: true));
        }
      }
    }
    return list;
  }

  int get _itemCount {
    return min(
      widget.itemCount ?? (widget.items.length + 1),
      widget.items.length,
    );
  }

  int get _snapCount => widget.snapCount;

  int get _missingCount {
    final line = (_itemCount / _snapCount).ceil();
    final require = line * _snapCount;
    final missing = require - _itemCount;
    return missing.abs();
  }

  Widget get _horizontal {
    return _ViewBuilder(
      component: widget.scrollingEnabled,
      builder: (value) {
        if (value) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: widget.physics,
            child: _h,
          );
        } else {
          return _h;
        }
      },
    );
  }

  Widget get _vertical {
    return _ViewBuilder(
      component: widget.scrollingEnabled,
      builder: (value) {
        if (value) {
          return SingleChildScrollView(
            physics: widget.physics,
            child: _v,
          );
        } else {
          return _v;
        }
      },
    );
  }

  Widget get _h {
    final end = (_itemCount / _snapCount).ceil();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: _items.getRange(0, end).map((item) {
        final end = index + (_snapCount);
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _items.getRange(index, end).map((item) {
            index++;
            return _ViewBuilder(
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
    );
  }

  Widget get _v {
    final end = (_itemCount / _snapCount).ceil();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: _items.getRange(0, end).map((item) {
        final end = index + (_snapCount);
        return Row(
          children: _items.getRange(index, end).map((item) {
            index++;
            return Expanded(
              child: _ViewBuilder(
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

class _ViewBuilder<T> extends StatelessWidget {
  final T component;
  final Widget? Function(T value) builder;

  const _ViewBuilder({
    Key? key,
    required this.component,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder.call(component) ?? const SizedBox();
  }
}
