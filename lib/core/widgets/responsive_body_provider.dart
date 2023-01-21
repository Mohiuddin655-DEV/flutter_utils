import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/size_config.dart';

import '../wrappers/widget_wrapper.dart';

class ResponsiveBodyProvider extends StatefulWidget {
  final int? flex;
  final FlexFit? fit;
  final Color? background;
  final bool detectChild, detectScreen, detectMax;
  final List<Widget> Function(BuildContext context, SizeConfig config) builder;

  const ResponsiveBodyProvider({
    Key? key,
    this.background,
    this.flex,
    this.fit,
    this.detectChild = false,
    this.detectScreen = false,
    this.detectMax = false,
    required this.builder,
  }) : super(key: key);

  @override
  State<ResponsiveBodyProvider> createState() => _ResponsiveBodyProviderState();
}

class _ResponsiveBodyProviderState extends State<ResponsiveBodyProvider> {
  Size? _size;

  @override
  Widget build(BuildContext context) {
    final widgets = widget.builder(context, config);
    return Row(
      children: widget.detectChild && widgets.isNotEmpty
          ? widgets.map((e) {
              return _detectedChild(e);
            }).toList()
          : widget.builder(context, config),
    );
  }

  SizeConfig get config {
    return SizeConfig.of(
      context,
      detectScreen: widget.detectScreen,
      size: _size,
    );
  }

  Widget _detectedChild(Widget child) {
    return WidgetWrapper(
      wrapper: (size) => setState(() {
        if ((_size ?? MediaQuery.of(context).size) > size) {
          _size = size;
        }
      }),
      child: child,
    );
  }
}
