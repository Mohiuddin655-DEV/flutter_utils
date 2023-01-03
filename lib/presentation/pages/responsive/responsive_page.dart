import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/responsive_body_provider.dart';

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
        desktopBody: ResponsiveBodyProvider(
          detectChild: true,
          builder: (context, config) {
            return [
              Container(
                width: 500,
                color: Colors.red.shade300,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        config.fontSize(24).toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: config.fontSize(24),
                        ),
                      ),
                      const Text(
                        "24",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                color: Colors.grey.shade300,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        config.fontSize(24).toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: config.fontSize(24),
                        ),
                      ),
                      const Text(
                        "24",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
        ),
        tvBody: Body(
          title: 'TV Body',
          color: Colors.green.shade300,
        ),
      ),
    );
  }
}
