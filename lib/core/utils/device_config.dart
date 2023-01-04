import 'device.dart';
import 'device_info.dart';

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
