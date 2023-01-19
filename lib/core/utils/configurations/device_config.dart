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

class DeviceInfo {
  static const double mobileX = 9,
      mobileY = 16,
      mobileVariant = 3.9272727272727;
  static const double tabX = 1, tabY = 1, tabVariant = 8.0;
  static const double laptopX = 16, laptopY = 10, laptopVariant = 3.7;
  static const double desktopX = 16, desktopY = 8, desktopVariant = 3.7;
  static const double tvX = 0, tvY = 0, tvVariant = 3.7;
}

class DeviceConfig {
  final Device mobile, tab, laptop, desktop, tv;

  const DeviceConfig({
    this.mobile = const Device(
      x: DeviceInfo.mobileX,
      y: DeviceInfo.mobileY,
      variant: DeviceInfo.mobileVariant,
      name: 'Mobile',
    ),
    this.tab = const Device(
      x: DeviceInfo.tabX,
      y: DeviceInfo.tabY,
      variant: DeviceInfo.tabVariant,
      name: 'Tab',
    ),
    this.laptop = const Device(
      x: DeviceInfo.laptopX,
      y: DeviceInfo.laptopY,
      variant: DeviceInfo.laptopVariant,
      name: 'Laptop',
    ),
    this.desktop = const Device(
      x: DeviceInfo.desktopX,
      y: DeviceInfo.desktopY,
      variant: DeviceInfo.desktopVariant,
      name: 'Desktop',
    ),
    this.tv = const Device(
      x: DeviceInfo.tvX,
      y: DeviceInfo.tvY,
      variant: DeviceInfo.tvVariant,
      name: 'TV',
    ),
  });

  bool isMobile(double cx, double cy) => isDevice(mobile, cx, cy);

  bool isTab(double cx, double cy) => isDevice(tab, cx, cy);

  bool isLaptop(double cx, double cy) => isDevice(laptop, cx, cy);

  bool isDesktop(double cx, double cy) => isDevice(desktop, cx, cy);

  bool isDevice(Device device, double cx, double cy) {
    final x = device.aspectRatio;
    final y = device.ratio(cx, cy);
    print('\n${device.name}\t => X : ${x.toStringAsFixed(2)}');
    print('${device.name}\t => Y : ${y.toStringAsFixed(2)}');
    return x > y;
  }
}
