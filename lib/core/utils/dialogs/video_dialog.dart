import 'package:flutter/material.dart';

import '../../widgets/video_view.dart';

class MediaDialog {
  final BuildContext context;

  const MediaDialog(this.context);

  void media({
    int transparency = 0,
    double? width,
    double? height,
    double? borderRadius,
    double? titlePaddingX,
    double? titlePaddingY,
    double? iconSize,
    double? titleSize,
    double? borderSize,
    String? title,
    String? body,
    Color? titleColor,
    Color? bodyColor,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return _MediaView(
            width: width,
            height: height,
            borderRadius: borderRadius,
            titlePaddingX: titlePaddingX,
            titlePaddingY: titlePaddingY,
            iconSize: iconSize,
            borderSize: borderSize,
            title: title,
            titleSize: titleSize,
            body: body,
            titleColor: titleColor,
            bodyColor: bodyColor,
          );
        });
  }
}

class _MediaView extends StatefulWidget {
  final double? width, height;
  final double? borderRadius;
  final double? titlePaddingX, titlePaddingY;
  final double? iconSize;
  final String? title;
  final Color? titleColor;
  final double? titleSize;
  final double? borderSize;
  final String? body;
  final Color? bodyColor;

  const _MediaView({
    Key? key,
    this.width,
    this.height,
    this.borderRadius = 24,
    this.titlePaddingX,
    this.titlePaddingY,
    this.title,
    this.titleColor,
    this.titleSize,
    this.iconSize,
    this.borderSize,
    this.body,
    this.bodyColor,
  }) : super(key: key);

  @override
  State<_MediaView> createState() => _MediaViewState();
}

class _MediaViewState extends State<_MediaView> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
      ),
      elevation: 5,
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: widget.width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: double.infinity,
          margin: EdgeInsets.all(widget.borderSize ?? 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Title(
                text: widget.title ?? "Title",
                textColor: widget.titleColor,
                textSize: widget.titleSize,
                icon: Icons.clear,
                iconSize: widget.iconSize ?? 24,
                iconColor: Colors.grey,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.titlePaddingX ?? 16,
                  vertical: widget.titlePaddingY ?? 12,
                ),
                onPressed: _dismiss,
              ),
              const SeparatorLine(height: 1),
              const VideoView(
                loopingEnable: false,
                videoUrl:
                    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
              ),
              widget.body != null
                  ? Expanded(child: Body(text: widget.body!))
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void _dismiss() {
    Navigator.pop(context);
  }
}

class Title extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textStyle;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed;

  const Title({
    Key? key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textStyle,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.padding,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: textSize ?? 16,
              fontWeight: textStyle,
            ),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Icon(
              icon ?? Icons.clear,
              size: iconSize,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}

class SeparatorLine extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? width, height;

  const SeparatorLine({
    Key? key,
    this.margin,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.grey.withOpacity(0.25),
      margin: margin,
      height: height ?? 1,
      width: width ?? double.infinity,
    );
  }
}

class Body extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final EdgeInsetsGeometry? padding;

  const Body({
    Key? key,
    required this.text,
    this.textColor,
    this.textSize,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tv = Text(
      text,
      style: TextStyle(
        color: textColor ?? Colors.grey,
        fontSize: textSize ?? 14,
      ),
    );
    return SingleChildScrollView(
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
        child: tv,
      ),
    );
  }
}
