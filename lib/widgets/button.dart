import 'dart:async';

import 'package:flutter/material.dart';

import 'view.dart';

class Button extends StatefulWidget {
  final ButtonController? controller;
  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? primary;
  final double? width, height;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding, margin;
  final bool enabled;
  final Function()? onPressed;
  final Future<bool> Function()? onExecute;

  const Button({
    Key? key,
    required this.text,
    this.textAlign,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.controller,
    this.primary,
    this.width = double.infinity,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.enabled = true,
    this.onPressed,
    this.onExecute,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  late ButtonController controller;

  late Color primary = widget.primary ?? Theme.of(context).primaryColor;

  @override
  void initState() {
    controller = widget.controller ?? ButtonController();
    controller.enabled = widget.enabled;
    controller.text = widget.text;
    controller.textAlign = widget.textAlign;
    controller.textColor = widget.textColor;
    controller.textSize = widget.textSize;
    controller.fontWeight = widget.fontWeight;
    controller.setNotifier(setState);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Button oldWidget) {
    controller.enabled = widget.enabled;
    controller.text = widget.text;
    controller.textAlign = widget.textAlign;
    controller.textColor = widget.textColor;
    controller.textSize = widget.textSize;
    controller.fontWeight = widget.fontWeight;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final color =
        controller.enabled ? Colors.white : Colors.black.withOpacity(0.4);
    final background = controller.enabled ? primary : primary.withOpacity(0.1);

    return GestureDetector(
      onTap: controller.enabled ? _onClick : null,
      child: Container(
        margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.antiAlias,
        width: widget.width ?? double.infinity,
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text(
            controller.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  void _onClick() async {
    controller.setEnabled(false);
    if (widget.onExecute != null) {
      await widget.onExecute?.call();
    } else {
      controller.onClick?.call();
    }
  }

  get loaded {
    const duration = Duration(milliseconds: 250);
    Timer(duration, () {
      controller.setEnabled(true);
    });
  }
}

class ButtonController extends ViewController {
  String? _text;
  double? textSize;
  TextAlign? textAlign;
  Color? textColor;
  FontWeight? fontWeight;

  set text(String value) => _text = value;

  String get text => _text ?? "";

  void setText(String? value) {
    text = value ?? "";
    notify;
  }

  void setTextAlign(TextAlign value) {
    textAlign = value;
    notify;
  }

  void setTextColor(Color value) {
    textColor = value;
    notify;
  }

  void setTextSize(double value) {
    textSize = value;
    notify;
  }

  void setTextWeight(FontWeight value) {
    fontWeight = value;
    notify;
  }
}
