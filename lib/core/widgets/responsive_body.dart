import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/size_config.dart';

class ResponsiveBody extends StatelessWidget {
  final Widget Function(BuildContext context, SizeConfig config) builder;
  final Color? background;

  const ResponsiveBody({
    Key? key,
    required this.builder,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig.of(context);
    return Container(
      color: background,
      child: builder.call(context, config),
    );
  }
}
