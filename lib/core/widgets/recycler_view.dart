import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/view_builder.dart';

class RecyclerView<T> extends StatefulWidget {
  final List<T> items;
  final Axis direction;
  final int? itemCount;
  final int itemSnap;

  final LayoutType layoutType;
  final Widget Function(int index, T item) builder;
  final Widget Function(int index, T item)? separator;

  const RecyclerView({
    Key? key,
    required this.items,
    required this.builder,
    this.separator,
    this.direction = Axis.vertical,
    this.itemCount,
    this.itemSnap = 1,
    this.layoutType = LayoutType.linear,
  }) : super(key: key);

  @override
  State<RecyclerView<T>> createState() => _RecyclerViewState<T>();
}

class _RecyclerViewState<T> extends State<RecyclerView<T>> {
  late int itemCount = widget.items.length;

  @override
  Widget build(BuildContext context) {
    itemCount = widget.itemCount ?? itemCount;
    return layout;
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

  Widget get verticalGrid {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: widget.items.getRange(i, itemCount~/widget.itemSnap).map((item) {
        final index = widget.items.indexOf(item);
        return verticalGridItem(index, item);
      }).toList(),
    );
  }

  int i = 0;

  Widget verticalGridItem(int start, T item) {
    final end = start + (widget.itemSnap);
    return Row(
      children: widget.items.getRange(start, end).map((item) {
        i = widget.items.indexOf(item);
        return Expanded(
          child: widget.builder.call(
            i,
            item,
          ),
        );
      }).toList(),
    );
  }

  Widget expended(Widget child) {
    return Expanded(child: child);
  }
}

enum LayoutType { linear, grid, strangle }
