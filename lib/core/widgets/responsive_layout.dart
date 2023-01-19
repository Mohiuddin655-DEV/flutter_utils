import 'package:flutter/material.dart';

import '../utils/configurations/device_config.dart';

class ResponsiveLayout extends StatelessWidget {
  final DeviceConfig config;

  final Widget mobileBody;
  final Widget? desktopBody;
  final Widget? tabBody;
  final Widget? laptopBody;
  final Widget? tvBody;
  final Size? initialSize;

  const ResponsiveLayout({
    Key? key,
    this.config = const DeviceConfig(),
    required this.mobileBody,
    this.desktopBody,
    this.tabBody,
    this.laptopBody,
    this.tvBody,
    this.initialSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cx = initialSize?.width ?? constraints.maxWidth;
        final cy = initialSize?.height ?? constraints.maxHeight;
        if (config.isMobile(cx, cy)) {
          return mobileBody;
        } else if (config.isTab(cx, cy)) {
          return tabBody ?? mobileBody;
        } else if (config.isLaptop(cx, cy)) {
          return laptopBody ?? desktopBody ?? mobileBody;
        } else if (config.isDesktop(cx, cy)) {
          return desktopBody ?? mobileBody;
        } else {
          return tvBody ?? desktopBody ?? mobileBody;
        }
      },
    );
  }
}
