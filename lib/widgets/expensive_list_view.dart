import 'dart:math';

import 'package:flutter/material.dart';

class ExpensiveListView extends StatefulWidget {
  final List<dynamic> items;
  final Axis direction;
  final int? itemCount;

  final Widget Function(int index, dynamic item) builder;
  final Widget Function(int index, dynamic item)? separator;

  const ExpensiveListView({
    Key? key,
    required this.items,
    required this.builder,
    this.separator,
    this.direction = Axis.vertical,
    this.itemCount,
  }) : super(key: key);

  @override
  State<ExpensiveListView> createState() => _ExpensiveListViewState();
}

class _ExpensiveListViewState extends State<ExpensiveListView> {
  @override
  Widget build(BuildContext context) {
    return _ViewBuilder(
      component: widget.direction == Axis.horizontal,
      builder: (value) {
        return value ? _horizontal : _vertical;
      },
    );
  }

  int get _itemCount {
    return min(
      widget.itemCount ?? (widget.items.length + 1),
      widget.items.length,
    );
  }

  Widget get _horizontal {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.items.getRange(0, _itemCount).map((item) {
          final index = widget.items.indexOf(item);
          return _ViewBuilder(
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
                    _ViewBuilder(
                      component: widget.items[_itemCount - 1] != item,
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

  Widget get _vertical {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.items.getRange(0, _itemCount).map((item) {
          final index = widget.items.indexOf(item);
          return _ViewBuilder(
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
                    _ViewBuilder(
                      component: widget.items[_itemCount - 1] != item,
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

  Widget get _h => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.items.getRange(0, _itemCount).map((item) {
          final index = widget.items.indexOf(item);
          return _ViewBuilder(
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
                    _ViewBuilder(
                      component: widget.items[_itemCount - 1] != item,
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
      );

  Widget get _v => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.items.getRange(0, _itemCount).map((item) {
          final index = widget.items.indexOf(item);
          return _ViewBuilder(
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
                    _ViewBuilder(
                      component: widget.items[_itemCount - 1] != item,
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
      );
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
