import 'package:flutter/material.dart';

class TextView extends StatefulWidget {
  final TextViewController? controller;
  final double? width, height;
  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  final TextOverflow? textOverflow;
  final double textSize;
  final FontWeight? textStyle;
  final EdgeInsetsGeometry? margin, padding;
  final int? maxLines;

  const TextView({
    Key? key,
    this.controller,
    this.text = "",
    this.width,
    this.height,
    this.textAlign,
    this.textColor,
    this.textOverflow,
    this.textSize = 14,
    this.textStyle,
    this.margin,
    this.padding,
    this.maxLines,
  }) : super(key: key);

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  late TextViewController controller;

  @override
  void initState() {
    controller = widget.controller ?? TextViewController();
    controller.text = widget.text;
    controller.textAlign = widget.textAlign;
    controller.textColor = widget.textColor;
    controller.textOverflow = widget.textOverflow;
    controller.textSize = widget.textSize;
    controller.maxLines = widget.maxLines;
    controller._setCallback(setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class TextViewController {
  late Function(VoidCallback fn) _callback;
  String? _text;
  double? textSize;
  TextAlign? textAlign;
  Color? textColor;
  TextOverflow? textOverflow;
  FontWeight? fontWeight;
  int? maxLines;

  void _setCallback(void Function(VoidCallback fn) callback) {
    _callback = callback;
  }

  set text(String? value) => _text = value;

  String get text => _text ?? "";

  void setText(String? value) {
    _callback(() {
      text = value ?? "";
    });
  }

  void setTextAlign(TextAlign value) {
    _callback(() {
      textAlign = value;
    });
  }

  void setTextColor(Color value) {
    _callback(() {
      textColor = value;
    });
  }

  void setTextOverflow(TextOverflow value) {
    _callback(() {
      textOverflow = value;
    });
  }

  void setTextSize(double value) {
    _callback(() {
      textSize = value;
    });
  }

  void setTextWeight(FontWeight value) {
    _callback(() {
      fontWeight = value;
    });
  }

  void setMaxLine(int value) {
    _callback(() {
      maxLines = value;
    });
  }
}
