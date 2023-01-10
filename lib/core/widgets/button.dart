import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textStyle;
  final double? width, height;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin, padding;
  final MaterialStateProperty<Color?>? background;
  final Function()? onClick;

  const Button({
    Key? key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textStyle,
    this.width,
    this.height,
    this.background,
    this.borderRadius,
    this.margin,
    this.padding,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ?? double.infinity,
      height: height ?? 50,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(backgroundColor: background),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: textStyle ?? FontWeight.bold,
            fontSize: textSize ?? 18,
          ),
        ),
      ),
    );
  }
}
