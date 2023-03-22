import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../utils/configurations/device_config.dart';
import '../utils/configurations/size_config.dart';

class ResponsiveBody extends StatefulWidget {
  final int? flex;
  final FlexFit? fit;
  final Color? background;
  final bool detectChild, detectScreen;
  final DeviceConfig config;
  final Widget Function(BuildContext context, SizeConfig config) builder;

  const ResponsiveBody({
    Key? key,
    this.background,
    this.flex,
    this.fit,
    this.detectChild = false,
    this.detectScreen = false,
    this.config = const DeviceConfig(),
    required this.builder,
  }) : super(key: key);

  @override
  State<ResponsiveBody> createState() => _ResponsiveBodyState();
}

class _ResponsiveBodyState extends State<ResponsiveBody> {
  Size? _size;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig.of(
      context,
      config: widget.config,
      detectScreen: widget.detectScreen,
      size: widget.detectChild ? _size : null,
    );
    return widget.flex != null
        ? Flexible(
            fit: widget.fit ?? FlexFit.loose,
            flex: widget.flex ?? 1,
            child: _parent(context, config),
          )
        : _parent(context, config);
  }

  Widget _parent(BuildContext context, SizeConfig config) => widget.detectChild
      ? _WidgetWrapper(
          wrapper: (size) => setState(() => _size = size),
          child: _child(context, config),
        )
      : _child(context, config);

  Widget _child(BuildContext context, SizeConfig config) => Container(
        color: widget.background,
        child: widget.builder.call(context, config),
      );
}

class _WidgetWrapper extends SingleChildRenderObjectWidget {
  final Function(Size size) wrapper;

  const _WidgetWrapper({
    Key? key,
    required this.wrapper,
    super.child,
  }) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ObjectWrapper(wrapper);
  }
}

class _ObjectWrapper extends RenderProxyBox {
  final Function(Size size) wrapper;

  Size? ox;

  _ObjectWrapper(this.wrapper);

  @override
  void performLayout() {
    super.performLayout();
    try {
      Size? nx = child?.size;
      if (nx != null && ox != nx) {
        ox = nx;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          wrapper(nx);
        });
      }
    } catch (_) {}
  }
}
