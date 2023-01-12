import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'view_builder.dart';

class ImageView extends StatelessWidget {
  final dynamic src;
  final SrcType srcType;
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

  ViewBuilder get _view {
    return ViewBuilder(
      component: cacheMode && type == SrcType.network,
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
      case SrcType.network:
        return NetworkImage(src);
      case SrcType.file:
        return FileImage(src);
      case SrcType.memory:
        return MemoryImage(src);
      case SrcType.asset:
      default:
        return AssetImage("$src");
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

enum SrcType {
  detect,
  asset,
  file,
  memory,
  network,
}
