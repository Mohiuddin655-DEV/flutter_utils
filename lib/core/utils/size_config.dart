import 'package:flutter/cupertino.dart';
import 'package:flutter_utils/core/utils/device_config.dart';

class SizeConfig {
  late DeviceConfig deviceConfig;
  late Size size;
  late double width;
  late double height;
  late double _detectedPixel, _detectedSpace;
  late bool isMobile, isTab, isLaptop, isDesktop, isTV;

  SizeConfig(
    BuildContext context, [
    Size? requireSize,
    bool isScreenDetected = false,
    DeviceConfig config = const DeviceConfig(),
  ]) {
    size = requireSize ?? MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    isMobile = width <= config.mobile.width;
    isTab = width > config.mobile.width && width <= config.tab.width;
    isLaptop = width > config.tab.width && width <= config.laptop.width;
    isDesktop = width > config.laptop.width && width <= config.desktop.width;
    isTV = width > config.desktop.width;
    _detectedPixel = isScreenDetected ? _suggestedPixel() : width;
    _detectedSpace = isScreenDetected ? _suggestedSpace() : width;
  }

  static SizeConfig of(
    BuildContext context, {
    bool isScreenDetected = false,
    DeviceConfig config = const DeviceConfig(),
    Size? size,
  }) {
    return SizeConfig(context, size, isScreenDetected, config);
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

  double pixel(double initialSize, {bool isScreenDetected = false}) {
    final x = initialSize / _screenVariant();
    final v = x < 0 ? 1.0 : x;
    return percentageSize(_detectedPixel, v);
  }

  double space(double initialSize) {
    final x = initialSize / _screenVariant();
    final v = x < 0 ? 1.0 : x;
    return percentageSize(_detectedSpace, v);
  }

  double squire({double percentage = 100}) {
    return percentageSize(_detectedPixel, percentage);
  }

  double percentageWidth(double percentage) {
    return percentageSize(width, percentage);
  }

  double percentageHeight(double percentage) {
    return percentageSize(height, percentage);
  }

  double percentageFontSize(double percentage) {
    return percentageSize(_detectedPixel, percentage);
  }

  double percentageSpace(double percentage) {
    return percentageSize(_detectedPixel, percentage);
  }

  // Optional
  double percentageSpaceHorizontal(double percentage) {
    return percentageSpace(percentage);
  }

  double percentageSpaceVertical(double percentage) {
    return percentageSize(height, percentage);
  }

  double dividedSpace(double dividedLength) {
    return dividedSize(_detectedPixel, dividedLength);
  }

  // Optional
  double dividedSpaceHorizontal(double dividedLength) {
    return dividedSpace(dividedLength);
  }

  double dividedSpaceVertical(double dividedLength) {
    return dividedSize(height, dividedLength);
  }

  // TODO: Customize by Screen position
  double _screenVariant() {
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

  double _suggestedPixel() {
    if (isTV || isDesktop || isLaptop) {
      return height;
    } else {
      return width;
    }
  }

  double _suggestedSpace() {
    return width;
  }
}
