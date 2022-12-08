import 'dart:ui';

class Device extends Size {
  final String name;

  const Device({
    required double x,
    required double y,
    this.name = 'Unknown',
  }) : super(x, y);

  @override
  double get width => super.width > 100 ? super.width : super.width * 100;

  @override
  double get height => super.height > 100 ? super.height : super.height * 100;

  double rationalWidth(double cx) {
    return cx * aspectRatio;
  }

  double rationalHeight(double cy) {
    return cy * aspectRatio;
  }

  double ratioX(double cx) {
    return rationalWidth(cx) / 100;
  }

  double ratioY(double cy) {
    return rationalHeight(cy) / 100;
  }

  double ratio(double cx, double cy) {
    return Size(cx, cy).aspectRatio;
  }
}
