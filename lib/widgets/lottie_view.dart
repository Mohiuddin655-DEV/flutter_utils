import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum LottieType {
  detect,
  asset,
  file,
  memory,
  network,
}

class LottieView extends StatelessWidget {
  final dynamic src;
  final LottieType srcType;
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
    this.srcType = LottieType.detect,
    this.cacheMode = true,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ViewBuilder(
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
      case LottieType.network:
        return NetworkLottie(src);
      case LottieType.file:
        return FileLottie(src);
      case LottieType.memory:
        return MemoryLottie(src);
      case LottieType.asset:
      default:
        return AssetLottie("$src");
    }
  }

  LottieType get type {
    final data = src;
    if (srcType == LottieType.detect) {
      if (data is String) {
        if (data.contains('https://') || data.contains('http://')) {
          return LottieType.network;
        } else if (data.contains('assets/')) {
          return LottieType.asset;
        } else {
          return srcType;
        }
      } else if (data is File) {
        return LottieType.file;
      } else if (data is Uint8List) {
        return LottieType.memory;
      } else {
        return srcType;
      }
    } else {
      return srcType;
    }
  }
}

class _ViewBuilder<T> extends StatelessWidget {
  final T component;
  final Widget? Function(T value) builder;

  const _ViewBuilder({
    Key? key,
    required this.component,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder.call(component) ?? const SizedBox();
  }
}
