import 'package:flutter/material.dart';

import '../../../core/widgets/responsive_layout.dart';
import 'body.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
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
          color: Colors.green.shade300,
        ),
        tvBody: Body(
          title: 'TV Body',
          color: Colors.green.shade300,
        ),
      ),
    );
  }
}
