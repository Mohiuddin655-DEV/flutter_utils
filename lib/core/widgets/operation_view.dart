import 'package:flutter/material.dart';

class OperationView<T> extends StatelessWidget {
  final T operation;
  final Widget? Function(T value) builder;

  const OperationView({
    Key? key,
    required this.operation,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder.call(operation) ?? const SizedBox();
  }
}
