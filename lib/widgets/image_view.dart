import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final dynamic src;
  final ImageType srcType;
  final double? width, height;
  final EdgeInsetsGeometry? margin;
  final Color? background, foreground;
  final BorderRadius? borderRadius;
  final bool cacheMode;
  final BoxFit? fit;

  const ImageView({
    Key? key,
    this.src,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.background,
    this.foreground,
    this.srcType = ImageType.detect,
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

  _ViewBuilder get _view {
    return _ViewBuilder(
      component: cacheMode && type == ImageType.network,
      builder: (value) {
        if (value) {
          return CachedNetworkImage(
            imageUrl: src,
            width: width,
            height: height,
            fit: fit,
          );
        } else {
          return Image(
            image: _image,
            width: width,
            height: height,
            fit: fit,
          );
        }
      },
    );
  }

  ImageProvider get _image {
    switch (type) {
      case ImageType.network:
        return NetworkImage(src);
      case ImageType.file:
        return FileImage(src);
      case ImageType.memory:
        return MemoryImage(src);
      case ImageType.asset:
      default:
        return AssetImage("$src");
    }
  }

  ImageType get type {
    final data = src;
    if (srcType == ImageType.detect) {
      if (data is String) {
        if (data.contains('https://') || data.contains('http://')) {
          return ImageType.network;
        } else if (data.contains('assets/')) {
          return ImageType.asset;
        } else {
          return srcType;
        }
      } else if (data is File) {
        return ImageType.file;
      } else if (data is Uint8List) {
        return ImageType.memory;
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

enum ImageType {
  detect,
  asset,
  file,
  memory,
  network,
}
