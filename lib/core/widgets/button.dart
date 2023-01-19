import 'package:flutter/material.dart';
import 'package:flutter_utils/core/sources/colors.dart';
import 'package:flutter_utils/core/utils/extensions/string_helper.dart';

class Button extends StatefulWidget {
  const Button({
    Key? key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.background,
    this.borderRadius,
    this.enabled = true,
    required this.text,
    this.textAlign,
    this.textAllCaps = false,
    this.textColor,
    this.textSize,
    this.textStyle,
    this.textOverflow,
    this.letterSpacing,
    this.lineSpacing,
    this.onClick,
  }) : super(key: key);

  final double? width, height;
  final EdgeInsetsGeometry? margin, padding;
  final Color? background;
  final double? borderRadius;
  final bool enabled;
  final String text;
  final TextAlign? textAlign;
  final bool textAllCaps;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textStyle;
  final TextOverflow? textOverflow;
  final double? letterSpacing;
  final double? lineSpacing;
  final Function()? onClick;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? widget.onClick : null,
          child: Container(
            padding: widget.padding ??
                const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
            child: Text(
              text,
              maxLines: 1,
              overflow: widget.textOverflow ?? TextOverflow.ellipsis,
              textAlign: widget.textAlign ?? TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.textSize ?? 16,
                fontWeight: widget.textStyle,
                letterSpacing: widget.letterSpacing,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String get text => widget.textAllCaps ? widget.text.uppercase : widget.text;

  bool get enabled => widget.enabled && widget.onClick != null;

  Color get color {
    final enabledColor = widget.textColor ?? Colors.white;
    final disabledColor = Colors.grey.shade600;
    return enabled ? enabledColor : disabledColor;
  }

  Color get background {
    final enabledColor = widget.background ?? Theme.of(context).primaryColor;
    final disabledColor = Color(0xFFFAFAFA);
    return enabled ? enabledColor : disabledColor;
  }
}
