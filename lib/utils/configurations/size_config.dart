import 'package:flutter/cupertino.dart';

import 'device_config.dart';

class SizeConfig {
  final BuildContext context;
  final DeviceConfig config;
  final bool detectScreen;
  final bool detectVariant;
  final Size? _requireSize;

  const SizeConfig._(
    this.context, [
    this.detectScreen = false,
    this.detectVariant = false,
    this.config = const DeviceConfig(),
    this._requireSize,
  ]);

  static SizeConfig of(
    BuildContext context, {
    bool detectScreen = false,
    bool detectVariant = false,
    DeviceConfig config = const DeviceConfig(),
    Size? size,
  }) {
    return SizeConfig._(context, detectScreen, detectVariant, config, size);
  }

  Size get size => _requireSize ?? MediaQuery.of(context).size;

  double get width => size.width;

  double get height => size.height;

  bool get isLandscapeMode => !(isMobile || isTab);

  bool get isMobile =>
      config.isMobile(width, height); //width <= config.mobile.width;

  bool get isTab => config.isTab(
        width,
        height,
      ); //width > config.mobile.width && width <= config.tab.width;

  bool get isLaptop => config.isLaptop(
        width,
        height,
      ); //width > config.tab.width && width <= config.laptop.width;

  bool get isDesktop => config.isDesktop(
        width,
        height,
      ); //width > config.laptop.width && width <= config.desktop.width;

  bool get isTV => width > config.desktop.width;

  double get _detectedPixel => detectScreen ? _suggestedPixel : width;

  double get _detectedSpace => detectScreen ? _suggestedSpace : width;

  double get _variant {
    if (detectVariant) {
      if (isMobile) {
        return config.mobile.variant;
      } else if (isTab) {
        return config.tab.variant;
      } else if (isLaptop) {
        return config.laptop.variant;
      } else if (isDesktop) {
        return config.desktop.variant;
      } else {
        return config.tv.variant;
      }
    } else {
      return config.mobile.variant;
    }
  }

  double get _suggestedPixel {
    if (width > height) {
      return height;
    } else {
      return width;
    }
  }

  double get _suggestedSpace {
    if (width > height) {
      return height;
    } else {
      return width;
    }
  }

  double percentageSize(double totalSize, double percentageSize) {
    if (percentageSize > 100) return totalSize;
    if (percentageSize < 0) return 0;
    return totalSize * (percentageSize / 100);
  }

  double dividedSize(double totalSize, double dividedLength) {
    if (dividedLength > totalSize) return totalSize;
    if (dividedLength < 0) return 0;
    return totalSize / dividedLength;
  }

  double fontSize(double initialSize) => pixel(initialSize);

  double pixel(double? initialSize) {
    final x = (initialSize ?? 0) / _variant;
    final v = x < 0 ? 1.0 : x;
    return percentageSize(_detectedPixel, v);
  }

  double space(double? initialSize) {
    final x = (initialSize ?? 0) / _variant;
    final v = x < 0 ? 1.0 : x;
    return percentageSize(_detectedSpace, v);
  }

  double squire({double percentage = 100}) =>
      percentageSize(_detectedPixel, percentage);

  double percentageWidth(double percentage) =>
      percentageSize(width, percentage);

  double percentageHeight(double percentage) =>
      percentageSize(height, percentage);

  double percentageFontSize(double percentage) =>
      percentageSize(_detectedPixel, percentage);

  double percentageSpace(double percentage) =>
      percentageSize(_detectedPixel, percentage);

  // Optional
  double percentageSpaceHorizontal(double percentage) =>
      percentageSpace(percentage);

  double percentageSpaceVertical(double percentage) =>
      percentageSize(height, percentage);

  double dividedSpace(double dividedLength) =>
      dividedSize(_detectedPixel, dividedLength);

  // Optional
  double dividedSpaceHorizontal(double dividedLength) =>
      dividedSpace(dividedLength);

  double dividedSpaceVertical(double dividedLength) =>
      dividedSize(height, dividedLength);
}
