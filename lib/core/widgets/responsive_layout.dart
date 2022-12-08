import 'package:flutter/material.dart';

import '../utils/device_config.dart';

class ResponsiveLayout extends StatelessWidget {
  final ScreenConfig config;

  final Widget mobileBody;
  final Widget desktopBody;
  final Widget? tabBody;
  final Widget? laptopBody;
  final Widget? tvBody;

  const ResponsiveLayout({
    Key? key,
    required this.mobileBody,
    required this.desktopBody,
    this.tabBody,
    this.laptopBody,
    this.tvBody,
    this.config = const ScreenConfig(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cx = constraints.maxWidth;
        final cy = constraints.maxHeight;

        if (config.isMobile(cx, cy)) {
          return mobileBody;
        } else if (config.isTab(cx, cy)) {
          return tabBody ?? mobileBody;
        } else if (config.isLaptop(cx, cy)) {
          return laptopBody ?? desktopBody;
        } else if (config.isDesktop(cx, cy)) {
          return desktopBody;
        } else {
          return tvBody ?? desktopBody;
        }
      },
    );
  }
}
