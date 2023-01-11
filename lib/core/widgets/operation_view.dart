import 'package:flutter/material.dart';

class ViewBuilder<T> extends StatelessWidget {
  final T component;
  final Widget? Function(T value) builder;

  const ViewBuilder({
    Key? key,
    required this.component,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder.call(component) ?? const SizedBox();
  }
}
