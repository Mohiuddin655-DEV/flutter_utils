import 'package:flutter/material.dart';

import 'object_wrapper.dart';

class WidgetWrapper extends SingleChildRenderObjectWidget {
  final Function(Size size) wrapper;

  const WidgetWrapper({
    Key? key,
    required this.wrapper,
    super.child,
  }) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return ObjectWrapper(wrapper);
  }
}
