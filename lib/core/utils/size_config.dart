import 'package:flutter/cupertino.dart';
import 'package:flutter_utils/core/utils/device_config.dart';

class SizeConfig {
  final BuildContext context;
  final DeviceConfig config;
  final bool detectScreen;
  final Size? _requireSize;

  const SizeConfig(
    this.context, [
    this.detectScreen = false,
    this.config = const DeviceConfig(),
    this._requireSize,
  ]);

  static SizeConfig of(
    BuildContext context, {
    bool detectScreen = false,
    DeviceConfig config = const DeviceConfig(),
    Size? size,
  }) {
    return SizeConfig(context, detectScreen, config, size);
  }

  Size get size => _requireSize ?? MediaQuery.of(context).size;

  double get width => size.width;

  double get height => size.height;

  bool get isMobile => width <= config.mobile.width;

  bool get isTab => width > config.mobile.width && width <= config.tab.width;

  bool get isLaptop => width > config.tab.width && width <= config.laptop.width;

  bool get isDesktop =>
      width > config.laptop.width && width <= config.desktop.width;

  bool get isTV => width > config.desktop.width;

  double get _detectedPixel => detectScreen ? _suggestedPixel : width;

  double get _detectedSpace => detectScreen ? _suggestedSpace : width;

  // TODO: Customize by Screen position
  double get _screenVariant {
    if (isTV) {
      return 8;
    } else if (isDesktop) {
      return 7;
    } else if (isLaptop) {
      return 6;
    } else if (isTab) {
      return 5;
    } else {
      return 3.6;
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

  double pixel(double initialSize) {
    final x = initialSize / _screenVariant;
    final v = x < 0 ? 1.0 : x;
    return percentageSize(_detectedPixel, v);
  }

  double space(double initialSize) {
    final x = initialSize / _screenVariant;
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
