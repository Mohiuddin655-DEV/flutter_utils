import 'package:flutter/material.dart';

import '../../../core/utils/device.dart';
import '../../../core/utils/device_config.dart';
import '../../../core/widgets/responsive_layout.dart';
import 'body.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        config: const DeviceConfig(
          mobile: Device(x: 1, y: 1.5),
          tab: Device(x: 1, y: 1),
          laptop: Device(x: 1.5, y: 1),
          desktop: Device(x: 2.5, y: 1),
        ),
        mobileBody: Body(
          title: 'Mobile Body',
          color: Colors.deepOrange.shade300,
        ),
        tabBody: Body(
          title: 'Tab Body',
          color: Colors.deepPurple.shade300,
        ),
        laptopBody: Body(
          title: 'Laptop Body',
          color: Colors.blue.shade300,
        ),
        desktopBody: Body(
          title: 'Desktop Body',
          color: Colors.deepPurple.shade300,
        ),
        tvBody: Body(
          title: 'TV Body',
          color: Colors.green.shade300,
        ),
      ),
    );
  }
}
