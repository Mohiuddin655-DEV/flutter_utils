import 'dart:ui';

class Device extends Size {
  final String name;
  final double variant;
  final double maxX, maxY;

  const Device({
    required double x,
    required double y,
    double? maxX,
    double? maxY,
    this.name = 'Unknown',
    this.variant = 0,
  })  : maxX = maxX ?? x,
        maxY = maxY ?? y,
        super(x, y);

  @override
  double get width => super.width > 100 ? super.width : super.width * 100;

  @override
  double get height => super.height > 100 ? super.height : super.height * 100;

  double get maxWidth => maxX > 100 ? maxX : maxX * 100;

  double get maxHeight => maxY > 100 ? maxY : maxY * 100;

  double rationalWidth(double cx) => cx * aspectRatio;

  double rationalHeight(double cy) => cy * aspectRatio;

  double ratioX(double cx) => rationalWidth(cx) / 100;

  double ratioY(double cy) => rationalHeight(cy) / 100;

  double ratio(double cx, double cy) => Size(cx, cy).aspectRatio;
}

class DeviceInfo {
  static const double mobileX = 0.65, mobileY = 1, mobileVariant = 4;
  static const double tabX = 1.2, tabY = 1, tabVariant = 8.0;
  static const double laptopX = 1.4, laptopY = 1, laptopVariant = 3.7;
  static const double desktopX = 1.8, desktopY = 0.9, desktopVariant = 3.7;
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
    final current = device.ratio(cx, cy);
    final min = device.aspectRatio;
    final max = device.ratio(device.maxX, device.maxY);
    print('\n${device.name}\t => Min : ${min.toStringAsFixed(2)}');
    print('${device.name}\t => Max : ${max.toStringAsFixed(2)}');
    print('${device.name}\t => Cur : ${current.toStringAsFixed(2)}');
    return min > current && current <= max;
  }
}
