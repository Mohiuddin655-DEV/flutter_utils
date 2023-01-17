import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/enums/src_type.dart';
import 'view_builder.dart';

class LottieView extends StatelessWidget {
  final dynamic src;
  final SrcType srcType;
  final double? width, height;
  final EdgeInsetsGeometry? margin;
  final Color? background, foreground;
  final BorderRadius? borderRadius;
  final bool cacheMode;
  final BoxFit? fit;

  const LottieView({
    Key? key,
    this.src,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.background,
    this.foreground,
    this.srcType = SrcType.detect,
    this.cacheMode = true,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewBuilder(
      component: margin != null ||
          background != null ||
          foreground != null ||
          borderRadius != null,
      builder: (value) {
        if (value) {
          return Container(
            margin: margin,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: background,
              borderRadius: borderRadius,
            ),
            foregroundDecoration: BoxDecoration(
              color: foreground,
              borderRadius: borderRadius,
            ),
            child: _view,
          );
        } else {
          return _view;
        }
      },
    );
  }

  LottieBuilder get _view => LottieBuilder(
        lottie: _image,
        width: width,
        height: height,
        fit: fit,
      );

  LottieProvider get _image {
    switch (type) {
      case SrcType.network:
        return NetworkLottie(src);
      case SrcType.file:
        return FileLottie(src);
      case SrcType.memory:
        return MemoryLottie(src);
      case SrcType.asset:
      default:
        return AssetLottie("$src");
    }
  }

  SrcType get type {
    final data = src;
    if (srcType == SrcType.detect) {
      if (data is String) {
        if (data.contains('https://') || data.contains('http://')) {
          return SrcType.network;
        } else if (data.contains('assets/')) {
          return SrcType.asset;
        } else {
          return srcType;
        }
      } else if (data is File) {
        return SrcType.file;
      } else if (data is Uint8List) {
        return SrcType.memory;
      } else {
        return srcType;
      }
    } else {
      return srcType;
    }
  }
}
