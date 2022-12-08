import 'package:flutter/cupertino.dart';
import 'package:flutter_utils/core/utils/device_config.dart';

class SizeConfig {
  late DeviceConfig mScreenConfig;
  late Size mSize;
  late double mWidth;
  late double mHeight;
  late double _detectedPixel, _detectedSpace;
  late bool isMobile, isTab, isLaptop, isDesktop, isTV;

  SizeConfig(BuildContext context, bool isScreenDetected, DeviceConfig config) {
    mSize = MediaQuery.of(context).size;
    mWidth = mSize.width;
    mHeight = mSize.height;

    isMobile = config.isMobile(mWidth, mHeight);
    isTab = config.isTab(mWidth, mHeight);
    isLaptop = config.isLaptop(mWidth, mHeight);
    isDesktop = config.isDesktop(mWidth, mHeight);
    isTV = !(isMobile && isTab && isLaptop && isDesktop);
    // isMobile = mScreenWidth <= _resMobile;
    // isPad = mScreenWidth > _resMobile && mScreenWidth <= _resPad;
    // isLaptop = mScreenWidth > _resPad && mScreenWidth <= _resLaptop;
    // isDesktop = mScreenWidth > _resLaptop && mScreenWidth <= _resDesktop;
    // isTV = mScreenWidth > _resDesktop;
    _detectedPixel = isScreenDetected ? _suggestedPixel() : mWidth;
    _detectedSpace = isScreenDetected ? _suggestedSpace() : mWidth;
  }

  static SizeConfig of(
    BuildContext context, {
    bool isScreenDetected = false,
    DeviceConfig config = const DeviceConfig(),
  }) {
    return SizeConfig(context, isScreenDetected, config);
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
    return percentageSize(mWidth, percentage);
  }

  double percentageHeight(double percentage) {
    return percentageSize(mHeight, percentage);
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
    return percentageSize(mHeight, percentage);
  }

  double dividedSpace(double dividedLength) {
    return dividedSize(_detectedPixel, dividedLength);
  }

  // Optional
  double dividedSpaceHorizontal(double dividedLength) {
    return dividedSpace(dividedLength);
  }

  double dividedSpaceVertical(double dividedLength) {
    return dividedSize(mHeight, dividedLength);
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
      return mHeight;
    } else {
      return mWidth;
    }
  }

  double _suggestedSpace() {
    return mWidth;
  }
}
