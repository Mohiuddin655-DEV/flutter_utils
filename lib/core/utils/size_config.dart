import 'package:flutter/cupertino.dart';

class SizeConfig {
  final int _resMobile = 480; //320 << 480
  final int _resPad = 768; //481 << 768
  final int _resLaptop = 1024; //769 << 1024
  final int _resDesktop = 1200; //1025 << 1200

  late Size mSize;
  late double mScreenWidth;
  late double mScreenHeight;
  late double _detectedPixel, _detectedSpace;
  late bool isMobile, isPad, isLaptop, isDesktop, isTV;

  SizeConfig(BuildContext context, bool isScreenDetected) {
    mSize = MediaQuery.of(context).size;
    mScreenWidth = mSize.width;
    mScreenHeight = mSize.height;
    isMobile = mScreenWidth <= _resMobile;
    isPad = mScreenWidth > _resMobile && mScreenWidth <= _resPad;
    isLaptop = mScreenWidth > _resPad && mScreenWidth <= _resLaptop;
    isDesktop = mScreenWidth > _resLaptop && mScreenWidth <= _resDesktop;
    isTV = mScreenWidth > _resDesktop;
    _detectedPixel = isScreenDetected ? _suggestedPixel() : mScreenWidth;
    _detectedSpace = isScreenDetected ? _suggestedSpace() : mScreenWidth;
  }

  static SizeConfig of(BuildContext context,
      {bool isScreenDetected = false}) {
    return SizeConfig(context, isScreenDetected);
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

  double fontSize(double initialSize) {
    final x = initialSize / _screenVariant();
    final v = x < 0 ? 1.0 : x;
    return percentageSize(_detectedPixel, v);
  }

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
    return percentageSize(mScreenWidth, percentage);
  }

  double percentageHeight(double percentage) {
    return percentageSize(mScreenHeight, percentage);
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
    return percentageSize(mScreenHeight, percentage);
  }

  double dividedSpace(double dividedLength) {
    return dividedSize(_detectedPixel, dividedLength);
  }

  // Optional
  double dividedSpaceHorizontal(double dividedLength) {
    return dividedSpace(dividedLength);
  }

  double dividedSpaceVertical(double dividedLength) {
    return dividedSize(mScreenHeight, dividedLength);
  }

  // TODO: Customize by Screen position
  double _screenVariant() {
    if (isTV) {
      return 8;
    } else if (isDesktop) {
      return 7;
    } else if (isLaptop) {
      return 6;
    } else if (isPad) {
      return 5;
    } else {
      return 3.6;
    }
  }

  double _suggestedPixel() {
    if (isTV || isDesktop || isLaptop) {
      return mScreenHeight;
    } else {
      return mScreenWidth;
    }
  }

  double _suggestedSpace() {
    return mScreenWidth;
  }
}
