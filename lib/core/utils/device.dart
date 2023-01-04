import 'dart:ui';

class Device extends Size {
  final String name;
  final double variant;

  const Device({
    required double x,
    required double y,
    this.name = 'Unknown',
    this.variant = 0,
  }) : super(x, y);

  @override
  double get width => super.width > 100 ? super.width : super.width * 100;

  @override
  double get height => super.height > 100 ? super.height : super.height * 100;

  double rationalWidth(double cx) => cx * aspectRatio;

  double rationalHeight(double cy) => cy * aspectRatio;

  double ratioX(double cx) => rationalWidth(cx) / 100;

  double ratioY(double cy) => rationalHeight(cy) / 100;

  double ratio(double cx, double cy) => Size(cx, cy).aspectRatio;
}
