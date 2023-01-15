import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/view_builder.dart';

class RecyclerView extends StatefulWidget {
  final List<dynamic> items;
  final Axis direction;
  final int? itemCount;
  final int snapCount;

  final LayoutType layoutType;
  final Widget Function(int index, dynamic item) builder;
  final Widget Function(int index, dynamic item)? separator;

  const RecyclerView({
    Key? key,
    required this.items,
    required this.builder,
    this.separator,
    this.direction = Axis.vertical,
    this.itemCount,
    this.snapCount = 1,
    this.layoutType = LayoutType.linear,
  }) : super(key: key);

  @override
  State<RecyclerView> createState() => _RecyclerViewState();
}

class _RecyclerViewState extends State<RecyclerView> {
  int index = 0;
  List<int> tempIndex = [];

  @override
  Widget build(BuildContext context) {
    index = 0;
    tempIndex.clear();
    return layout;
  }

  int get itemCount {
    return min(
      widget.itemCount ?? (widget.items.length + 1),
      widget.items.length,
    );
  }

  int get snapCount => widget.snapCount;

  @override
  void didUpdateWidget(covariant RecyclerView oldWidget) {
    index = 0;
    super.didUpdateWidget(oldWidget);
  }

  int get missingCount {
    final line = (itemCount / snapCount).ceil();
    final require = line * snapCount;
    final missing = require - itemCount;
    print("Missing $missing");
    return missing.abs();
  }

  List<ListItem> get items {
    List<ListItem> list = [];
    if (widget.items.isNotEmpty) {
      list = widget.items
          .getRange(0, itemCount)
          .map((e) => ListItem(data: e))
          .toList();
      final length = widget.items.length;
      if (missingCount > 0) {
        for (int i = 0; i < missingCount; i++) {
          list.add(const ListItem(isTemporary: true));
          tempIndex.add(length + i);
        }
      }
    }
    return list;
  }

  Widget get layout {
    switch (widget.layoutType) {
      case LayoutType.linear:
        return ViewBuilder(
          component: widget.direction == Axis.horizontal,
          builder: (value) {
            return value ? horizontal : vertical;
          },
        );
      case LayoutType.grid:
        return ViewBuilder(
          component: widget.direction == Axis.horizontal,
          builder: (value) {
            return value ? horizontalGrid : verticalGrid;
          },
        );
      case LayoutType.strangle:
        return ViewBuilder(
          component: widget.direction == Axis.horizontal,
          builder: (value) {
            return value ? horizontal : vertical;
          },
        );
    }
  }

  Widget get horizontal {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.items.getRange(0, itemCount).map((item) {
          final index = widget.items.indexOf(item);
          return ViewBuilder(
            component: widget.separator != null,
            builder: (value) {
              if (value) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.builder.call(
                      index,
                      item,
                    ),
                    ViewBuilder(
                      component: widget.items[itemCount - 1] != item,
                      builder: (value) {
                        if (value) {
                          return widget.separator?.call(index, item);
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                );
              } else {
                return widget.builder.call(
                  index,
                  item,
                );
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Widget get vertical {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.items.getRange(0, itemCount).map((item) {
          final index = widget.items.indexOf(item);
          return ViewBuilder(
            component: widget.separator != null,
            builder: (value) {
              if (value) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.builder.call(
                      index,
                      item,
                    ),
                    ViewBuilder(
                      component: widget.items[itemCount - 1] != item,
                      builder: (value) {
                        if (value) {
                          return widget.separator?.call(index, item);
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                );
              } else {
                return widget.builder.call(
                  index,
                  item,
                );
              }
            },
          );
        }).toList(),
      ),
    );
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
          return horizontalGridItem;
        }).toList(),
      ),
    );
  }

  Widget get horizontalGridItem {
    final end = index + (snapCount);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.getRange(index, end).map((item) {
        index++;
        return ViewBuilder(
            component: !item.isTemporary,
            builder: (value) => value
                ? widget.builder.call(
              index,
              item.data,
            )
                : null);
      }).toList(),
    );
  }

  Widget get verticalGrid {
    final end = (itemCount / snapCount).ceil();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: items.getRange(0, end).map((item) {
        return verticalGridItem;
      }).toList(),
    );
  }

  Widget get verticalGridItem {
    final end = index + (snapCount);
    return Row(
      children: items.getRange(index, end).map((item) {
        index++;
        return Expanded(
          child: ViewBuilder(
              component: !item.isTemporary,
              builder: (value) => value
                  ? widget.builder.call(
                index,
                item.data,
              )
                  : null),
        );
      }).toList(),
    );
  }
}

class ListItem {
  final dynamic data;
  final bool isTemporary;

  const ListItem({
    this.data,
    this.isTemporary = false,
  });
}

enum LayoutType { linear, grid, strangle }
