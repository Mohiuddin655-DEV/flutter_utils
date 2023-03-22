import 'package:flutter/material.dart';

import 'view.dart';

class TextView extends StatefulWidget {
  final TextViewController? controller;
  final Color? background;
  final double borderRadius;
  final double? width, height;
  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  final TextOverflow? textOverflow;
  final double textSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? margin, padding;
  final int? maxLines;
  final OnViewClickListener? onClick;

  const TextView({
    Key? key,
    this.controller,
    this.background,
    this.borderRadius = 0,
    this.text = "",
    this.width,
    this.height,
    this.textAlign,
    this.textColor,
    this.textOverflow,
    this.textSize = 14,
    this.fontWeight,
    this.margin,
    this.padding,
    this.maxLines,
    this.onClick,
  }) : super(key: key);

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  late TextViewController controller;

  @override
  void initState() {
    controller = widget.controller ?? TextViewController();
    initController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextView oldWidget) {
    initController();
    super.didUpdateWidget(oldWidget);
  }

  void initController() {
    controller.setNotifier(setState);
    controller.fontWeight = widget.fontWeight;
    controller.maxLines = widget.maxLines;
    controller.text = widget.text;
    controller.textAlign = widget.textAlign;
    controller.textColor = widget.textColor;
    controller.textOverflow = widget.textOverflow;
    controller.textSize = widget.textSize;
    controller.onClick = widget.onClick;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.onClick,
      child: Container(
        decoration: BoxDecoration(
          color: widget.background,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        margin: widget.margin,
        child: Text(
          controller.text,
          maxLines: controller.maxLines,
          textAlign: controller.textAlign,
          overflow: controller.textOverflow,
          style: TextStyle(
            fontSize: controller.textSize,
            fontWeight: controller.fontWeight,
            color: controller.textColor,
          ),
        ),
      ),
    );
  }
}

class TextViewController extends ViewController {
  FontWeight? fontWeight;
  int? maxLines;
  String? _text;
  double? textSize;
  TextAlign? textAlign;
  Color? textColor;
  TextOverflow? textOverflow;

  set text(String? value) => _text = value;

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

  void setTextOverflow(TextOverflow value) {
    textOverflow = value;
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

  void setMaxLine(int value) {
    maxLines = value;
    notify;
  }
}
