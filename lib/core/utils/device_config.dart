import 'device_info.dart';
import 'device.dart';

class ScreenConfig {
  final Device mobile, tab, laptop, desktop;

  const ScreenConfig({
    this.mobile = const Device(
      x: DeviceInfo.mobileX,
      y: DeviceInfo.mobileY,
      name: 'Mobile',
    ),
    this.tab = const Device(
      x: DeviceInfo.tabX,
      y: DeviceInfo.tabY,
      name: 'Tab',
    ),
    this.laptop = const Device(
      x: DeviceInfo.laptopX,
      y: DeviceInfo.laptopY,
      name: 'Laptop',
    ),
    this.desktop = const Device(
      x: DeviceInfo.desktopX,
      y: DeviceInfo.desktopY,
      name: 'Desktop',
    ),
  });

  bool isMobile(double cx, double cy) {
    return isDevice(mobile, cx, cy);
  }

  bool isTab(double cx, double cy) {
    return isDevice(tab, cx, cy);
  }

  bool isLaptop(double cx, double cy) {
    return isDevice(laptop, cx, cy);
  }

  bool isDesktop(double cx, double cy) {
    return isDevice(desktop, cx, cy);
  }

  bool isDevice(Device device, double cx, double cy){
    final x = device.aspectRatio;   print('\n${device.name}\t => X : ${x.toStringAsFixed(2)}');
    final y = device.ratio(cx, cy); print('${device.name}\t => Y : ${y.toStringAsFixed(2)}');
    return x > y;
  }
}
