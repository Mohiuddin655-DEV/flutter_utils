import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/dialogs/loading_dialog.dart';
import 'package:flutter_utils/core/widgets/responsive_layout.dart';

import '../../widgets/video_view.dart';
import '../../widgets/view_builder.dart';
import '../configurations/size_config.dart';

class MediaDialog extends LoadingDialog {
  const MediaDialog(super.context);

  void media({
    int transparency = 0,
    double? width,
    double? height,
    double? mediaWidth,
    double? mediaHeight,
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
    dynamic media,
    MediaType mediaType = MediaType.none,
    VideoType videoType = VideoType.detect,
  }) {
    build(
      dismissible: dismissible,
      background: background,
      child: _View(
        mediaType: mediaType,
        width: width,
        height: height,
        mediaWidth: mediaWidth,
        mediaHeight: mediaHeight,
        borderRadius: borderRadius,
        titlePaddingX: titlePaddingX,
        titlePaddingY: titlePaddingY,
        iconSize: iconSize,
        borderSize: borderSize,
        title: title ?? '',
        titleAlign: titleAlign,
        titleSize: titleSize,
        body: body,
        bodySize: bodySize,
        titleColor: titleColor,
        bodyColor: bodyColor,
        media: media,
        videoType: videoType,
        onDismiss: dismiss,
      ),
    );
  }
}

class _View extends StatelessWidget {
  final MediaType mediaType;
  final double? width, height;
  final double? mediaWidth, mediaHeight;
  final double? borderRadius;
  final double? titlePaddingX, titlePaddingY;
  final double? iconSize;
  final String title;
  final AlignmentGeometry? titleAlign;
  final Color? titleColor;
  final double? titleSize;
  final double? borderSize;
  final String? body;
  final Color? bodyColor;
  final double? bodySize;
  final dynamic media;
  final VideoType videoType;
  final Function()? onDismiss;

  const _View({
    Key? key,
    this.mediaType = MediaType.none,
    this.width,
    this.height,
    this.mediaWidth,
    this.mediaHeight,
    this.borderRadius = 24,
    this.titlePaddingX,
    this.titlePaddingY,
    this.title = '',
    this.titleAlign,
    this.titleColor,
    this.titleSize,
    this.iconSize,
    this.borderSize,
    this.body,
    this.bodyColor,
    this.bodySize,
    this.media,
    this.videoType = VideoType.detect,
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
            mediaType: mediaType,
            video: media,
            videoType: videoType,
            title: title,
            titleAlign: titleAlign,
            titleColor: titleColor,
            titleSize: titleSize,
            mediaWidth: mediaWidth,
            mediaHeight: mediaHeight,
            body: body,
            bodyColor: bodyColor,
            bodySize: bodySize,
            onDismiss: onDismiss,
          ),
          desktopBody: LandscapeMode(
            mediaType: mediaType,
            mediaWidth: mediaWidth,
            mediaHeight: mediaHeight,
            video: media,
            videoType: videoType,
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
  final MediaType mediaType;
  final VideoType videoType;
  final String? title;
  final AlignmentGeometry? titleAlign;
  final Color? titleColor;
  final double? titleSize;
  final String? body;
  final Color? bodyColor;
  final double? bodySize;
  final double? mediaWidth, mediaHeight;
  final dynamic video;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final Function()? onDismiss;

  const PortraitMode({
    Key? key,
    this.mediaType = MediaType.none,
    this.videoType = VideoType.detect,
    this.title,
    this.titleAlign,
    this.titleColor,
    this.titleSize,
    this.body,
    this.bodyColor,
    this.bodySize,
    this.video,
    this.mediaWidth,
    this.mediaHeight,
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
        ViewBuilder(
          component: mediaType,
          builder: (value) {
            if (value == MediaType.video) {
              return VideoView(
                videoType: videoType,
                width: mediaWidth,
                height: mediaHeight,
                loopingEnable: false,
                video: video,
              );
            } else {
              return null;
            }
          },
        ),
        ViewBuilder(
          component: body != null,
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
  final MediaType mediaType;
  final VideoType videoType;
  final String title;
  final AlignmentGeometry? titleAlign;
  final Color? titleColor;
  final double? titleSize;
  final String? body;
  final Color? bodyColor;
  final double? bodySize;
  final double? mediaWidth, mediaHeight;
  final dynamic video;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final Function()? onDismiss;

  const LandscapeMode({
    Key? key,
    required this.title,
    this.titleAlign,
    this.titleColor,
    this.titleSize,
    this.body,
    this.bodyColor,
    this.bodySize,
    this.mediaType = MediaType.none,
    this.mediaWidth,
    this.mediaHeight,
    this.video,
    this.videoType = VideoType.detect,
    this.iconSize,
    this.padding,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig.of(context);
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
        SeparatorLine(height: config.pixel(1)),
        Expanded(
          child: Row(
            children: [
              ViewBuilder(
                component: mediaType,
                builder: (value) {
                  if (value == MediaType.video) {
                    return Expanded(
                      child: Container(
                        color: Colors.black,
                        height: double.infinity,
                        child: VideoView(
                          videoType: videoType,
                          width: mediaWidth,
                          height: mediaHeight,
                          loopingEnable: false,
                          video: video,
                        ),
                      ),
                    );
                  } else {
                    return null;
                  }
                },
              ),
              ViewBuilder(
                component: body != null,
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
