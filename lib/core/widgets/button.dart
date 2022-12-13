import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final double width, height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin, padding;
  final MaterialStateProperty<Color?>? background;
  final VoidCallback? onClick;

  const Button({
    Key? key,
    required this.text,
    this.width = double.infinity,
    this.height = 50,
    this.background,
    this.borderRadius = 0,
    this.margin,
    this.padding,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(backgroundColor: background),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
