import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/size_config.dart';

import '../wrappers/widget_wrapper.dart';

class ResponsiveBody extends StatefulWidget {
  final int flex;
  final Color? background;
  final Widget Function(BuildContext context, SizeConfig config) builder;

  const ResponsiveBody({
    Key? key,
    this.background,
    this.flex = 1,
    required this.builder,
  }) : super(key: key);

  @override
  State<ResponsiveBody> createState() => _ResponsiveBodyState();
}

class _ResponsiveBodyState extends State<ResponsiveBody> {
  Size? _size;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig.of(context, size: _size);
    return Expanded(
      flex: widget.flex,
      child: WidgetWrapper(
        wrapper: (size) => setState(() => _size = size),
        child: Container(
          color: widget.background,
          child: widget.builder.call(context, config),
        ),
      ),
    );
  }
}
