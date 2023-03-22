import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../utils/configurations/device_config.dart';
import '../utils/configurations/size_config.dart';
import 'image_button.dart';

typedef SectionBuilder = Widget Function(SizeConfig config);
typedef DashboardCallback = Function(VoidCallback fn);

class Dashboard extends StatelessWidget {
  final DeviceConfig config;

  final Color? background;
  final dynamic leadingIcon;
  final Color? leadingTint;
  final Color? leadingBackground;
  final Brightness? brightness;
  final DashboardHeader header;
  final DashboardMenu menu;
  final DashboardBody body;
  final DashboardReport? report;

  final Size? initialSize;

  const Dashboard({
    Key? key,
    required this.header,
    required this.menu,
    required this.body,
    this.report,
    this.config = const DeviceConfig(),
    this.initialSize,
    this.background = Colors.white,
    this.brightness = Brightness.dark,
    this.leadingIcon,
    this.leadingTint,
    this.leadingBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cx = initialSize?.width ?? constraints.maxWidth;
        final cy = initialSize?.height ?? constraints.maxHeight;
        if (config.isMobile(cx, cy)) {
          return MobileLayout(
            key: key,
            header: header,
            menu: menu,
            body: body,
            background: background,
            brightness: brightness,
            leadingIcon: leadingIcon,
            leadingTint: leadingTint,
            leadingBackground: leadingBackground,
          );
        } else if (config.isTab(cx, cy)) {
          return TabLayout(
            key: key,
            header: header,
            menu: menu,
            body: body,
          );
        } else {
          return DesktopLayout(
            key: key,
            header: header,
            menu: menu,
            body: body,
            report: report,
          );
        }
      },
    );
  }
}

class DesktopLayout extends StatelessWidget {
  final DashboardHeader header;
  final DashboardMenu menu;
  final DashboardBody body;
  final DashboardReport? report;

  const DesktopLayout({
    Key? key,
    required this.header,
    required this.menu,
    required this.body,
    this.report,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.horizontal,
          children: [
            menu,
            Expanded(
              child: Flex(
                direction: Axis.vertical,
                children: [
                  header,
                  Expanded(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        body,
                        if (report != null) report!,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabLayout extends StatelessWidget {
  final DashboardHeader header;
  final DashboardMenu menu;
  final DashboardBody body;

  const TabLayout({
    Key? key,
    required this.header,
    required this.menu,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.horizontal,
          children: [
            menu,
            Expanded(
              child: Flex(
                direction: Axis.vertical,
                children: [
                  header,
                  body,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileLayout extends StatefulWidget {
  final Color? background;
  final dynamic leadingIcon;
  final Color? leadingTint;
  final Color? leadingBackground;
  final Brightness? brightness;
  final DashboardHeader header;
  final DashboardMenu menu;
  final DashboardBody body;

  const MobileLayout({
    Key? key,
    required this.header,
    required this.menu,
    required this.body,
    this.background,
    this.brightness,
    this.leadingIcon,
    this.leadingTint,
    this.leadingBackground,
  }) : super(key: key);

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  bool isOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: widget.background,
        child: SafeArea(child: widget.menu),
      ),
      appBar: AppBar(
        backgroundColor: widget.background,
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: widget.brightness,
          statusBarIconBrightness: widget.brightness,
          statusBarColor: Colors.transparent,
        ),
      ),
      body: Container(
        color: widget.background,
        child: SafeArea(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  ImageButton(
                    background: widget.leadingBackground,
                    tint: widget.leadingTint,
                    icon: widget.leadingIcon ?? Icons.menu,
                    margin: const EdgeInsets.all(8),
                    onClick: (con) => Scaffold.of(con).openDrawer(),
                  ),
                  Expanded(child: widget.header),
                ],
              ),
              widget.body,
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardHeader extends StatelessWidget {
  final Color? background;
  final double height;
  final SectionBuilder builder;

  const DashboardHeader({
    Key? key,
    required this.builder,
    this.background,
    this.height = 54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: _Section(
        background: background,
        builder: builder,
      ),
    );
  }
}

class DashboardMenu extends StatelessWidget {
  final Color background;
  final double width;
  final SectionBuilder builder;

  const DashboardMenu({
    Key? key,
    required this.builder,
    this.background = Colors.white,
    this.width = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: double.infinity,
      child: _Section(
        background: background,
        builder: builder,
      ),
    );
  }
}

class DashboardBody extends StatelessWidget {
  final Color? background;
  final SectionBuilder builder;

  const DashboardBody({
    Key? key,
    required this.builder,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _Section(
        background: background,
        builder: builder,
      ),
    );
  }
}

class DashboardReport extends StatelessWidget {
  final Color? background;

  final double width;
  final SectionBuilder builder;

  const DashboardReport({
    Key? key,
    required this.builder,
    this.background,
    this.width = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: double.infinity,
      child: _Section(
        background: background,
        builder: builder,
      ),
    );
  }
}

class _Section extends StatefulWidget {
  final double? width, height;
  final Color? background;
  final SectionBuilder? builder;

  const _Section({
    Key? key,
    this.width,
    this.height,
    this.background,
    this.builder,
  }) : super(key: key);

  @override
  State<_Section> createState() => _SectionState();
}

class _SectionState extends State<_Section> {
  late SizeConfig config = SizeConfig.of(context, size: const Size(0, 0));

  @override
  Widget build(BuildContext context) {
    return _WidgetWrapper(
      wrapper: (Size size) {
        setState(() {
          config = SizeConfig.of(context, size: size);
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        color: widget.background,
        child: widget.builder?.call(config),
      ),
    );
  }
}

class _WidgetWrapper extends SingleChildRenderObjectWidget {
  final Function(Size size) wrapper;

  const _WidgetWrapper({
    Key? key,
    required this.wrapper,
    super.child,
  }) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ObjectWrapper(wrapper);
  }
}

class _ObjectWrapper extends RenderProxyBox {
  final Function(Size size) wrapper;

  Size? ox;

  _ObjectWrapper(this.wrapper);

  @override
  void performLayout() {
    super.performLayout();
    try {
      Size? nx = child?.size;
      if (nx != null && ox != nx) {
        ox = nx;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          wrapper(nx);
        });
      }
    } catch (_) {}
  }
}
