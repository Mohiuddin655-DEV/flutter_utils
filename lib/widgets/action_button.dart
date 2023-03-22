import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActionButton extends StatelessWidget {
  final double size;
  final double? borderRadius;
  final dynamic icon;
  final Color? tint;
  final Color? background;
  final double? padding;
  final EdgeInsetsGeometry? margin;
  final Function()? onPressed;

  const ActionButton({
    Key? key,
    required this.icon,
    this.borderRadius,
    this.tint,
    this.background,
    this.size = 24,
    this.padding,
    this.margin,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: margin,
          child: Material(
            borderRadius: BorderRadius.circular(borderRadius ?? 50),
            color: background,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(borderRadius ?? 50),
              child: Container(
                width: size,
                height: size,
                margin: EdgeInsets.all(padding ?? (size / 3)),
                child: FittedBox(
                  child: icon is String
                      ? SvgPicture.asset(
                          icon,
                          width: size,
                          height: size,
                          color: tint,
                        )
                      : icon is IconData
                          ? Icon(
                              icon,
                              size: size,
                              color: tint,
                            )
                          : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
