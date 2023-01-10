import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/dialogs/base_dialog.dart';
import 'package:flutter_utils/core/utils/size_config.dart';
import 'package:flutter_utils/core/widgets/responsive_layout.dart';

import '../../widgets/operation_view.dart';
import '../../widgets/video_view.dart';

class MediaDialog extends BaseDialog {
  const MediaDialog(super.context);

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
    AlignmentGeometry? titleAlign,
    String? body,
    double? bodySize,
    Color? titleColor,
    Color? bodyColor,
    bool? dismissible,
    Color? background,
    String url = '',
    MediaType type = MediaType.none,
  }) {
    build(
      dismissible: dismissible,
      background: background,
      child: _View(
        type: type,
        width: width,
        height: height,
        borderRadius: borderRadius,
        titlePaddingX: titlePaddingX,
        titlePaddingY: titlePaddingY,
        iconSize: iconSize,
        borderSize: borderSize,
        title: title,
        titleAlign: titleAlign,
        titleSize: titleSize,
        body: body,
        bodySize: bodySize,
        titleColor: titleColor,
        bodyColor: bodyColor,
        url: url,
        onDismiss: dismiss,
      ),
    );
  }
}

class _View extends StatelessWidget {
  final MediaType type;
  final double? width, height;
  final double? borderRadius;
  final double? titlePaddingX, titlePaddingY;
  final double? iconSize;
  final String? title;
  final AlignmentGeometry? titleAlign;
  final Color? titleColor;
  final double? titleSize;
  final double? borderSize;
  final String? body;
  final Color? bodyColor;
  final double? bodySize;
  final String url;
  final Function()? onDismiss;

  const _View({
    Key? key,
    this.type = MediaType.none,
    this.width,
    this.height,
    this.borderRadius = 24,
    this.titlePaddingX,
    this.titlePaddingY,
    this.title,
    this.titleAlign,
    this.titleColor,
    this.titleSize,
    this.iconSize,
    this.borderSize,
    this.body,
    this.bodyColor,
    this.bodySize,
    this.url = '',
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig.of(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      width: width ?? config.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        margin: EdgeInsets.all(borderSize ?? 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        child: ResponsiveLayout(
          mobileBody: PortraitMode(
            type: type,
            url: url,
            title: title,
            titleAlign: titleAlign,
            titleColor: titleColor,
            titleSize: titleSize,
            body: body,
            bodyColor: bodyColor,
            bodySize: bodySize,
            onDismiss: onDismiss,
          ),
          desktopBody: LandscapeMode(
            type: type,
            url: url,
            title: title,
            titleAlign: titleAlign ?? Alignment.center,
            titleColor: titleColor,
            titleSize: titleSize,
            body: body,
            bodyColor: bodyColor,
            bodySize: bodySize,
            onDismiss: onDismiss,
          ),
        ),
      ),
    );
  }
}

class PortraitMode extends StatelessWidget {
  final MediaType type;
  final String? title;
  final AlignmentGeometry? titleAlign;
  final Color? titleColor;
  final double? titleSize;
  final String? body;
  final Color? bodyColor;
  final double? bodySize;
  final String url;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final Function()? onDismiss;

  const PortraitMode({
    Key? key,
    this.type = MediaType.none,
    this.title,
    this.titleAlign,
    this.titleColor,
    this.titleSize,
    this.body,
    this.bodyColor,
    this.bodySize,
    this.url = '',
    this.iconSize,
    this.padding,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Title(
          text: title,
          textAlign: titleAlign,
          textColor: titleColor,
          textSize: titleSize,
          icon: Icons.clear,
          iconSize: iconSize ?? 24,
          iconColor: Colors.grey,
          padding: padding,
          onPressed: onDismiss,
        ),
        const SeparatorLine(height: 1),
        OperationView(
          operation: type,
          builder: (value) {
            if (value == MediaType.video) {
              return VideoView(
                loopingEnable: false,
                videoUrl: url,
              );
            } else {
              return null;
            }
          },
        ),
        OperationView(
          operation: body != null,
          builder: (value) {
            if (value) {
              return Expanded(
                child: Message(
                  text: body!,
                  textSize: bodySize,
                  textColor: bodyColor,
                ),
              );
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}

class LandscapeMode extends StatelessWidget {
  final MediaType type;
  final String? title;
  final AlignmentGeometry? titleAlign;
  final Color? titleColor;
  final double? titleSize;
  final String? body;
  final Color? bodyColor;
  final double? bodySize;
  final String url;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final Function()? onDismiss;

  const LandscapeMode({
    Key? key,
    this.type = MediaType.none,
    this.title,
    this.titleAlign,
    this.titleColor,
    this.titleSize,
    this.body,
    this.bodyColor,
    this.bodySize,
    this.url = '',
    this.iconSize,
    this.padding,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Title(
          text: title,
          textAlign: titleAlign,
          textColor: titleColor,
          textSize: titleSize,
          icon: Icons.clear,
          iconSize: iconSize,
          iconColor: Colors.grey,
          padding: padding,
          onPressed: onDismiss,
        ),
        const SeparatorLine(height: 1),
        Expanded(
          child: Row(
            children: [
              OperationView(
                operation: type,
                builder: (value) {
                  if (value == MediaType.video) {
                    return Expanded(
                      child: VideoView(
                        loopingEnable: false,
                        videoUrl: url,
                      ),
                    );
                  } else {
                    return null;
                  }
                },
              ),
              OperationView(
                operation: body != null,
                builder: (value) {
                  if (value) {
                    return Expanded(
                      child: Message(
                        text: body!,
                        textSize: bodySize,
                        textColor: bodyColor,
                      ),
                    );
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  final String? text;
  final AlignmentGeometry? textAlign;
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
    this.text,
    this.textAlign,
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
      width: double.infinity,
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
      child: Stack(
        alignment: textAlign ?? Alignment.centerLeft,
        children: [
          Text(
            text ?? '',
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: textSize ?? 16,
              fontWeight: textStyle,
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: onPressed,
              child: Icon(
                icon ?? Icons.clear,
                size: iconSize,
                color: iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final EdgeInsetsGeometry? padding;

  const Message({
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
      physics: const BouncingScrollPhysics(),
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

enum MediaType {
  none,
  photo,
  video,
}
