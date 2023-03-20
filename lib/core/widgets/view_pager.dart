import 'package:flutter/material.dart';

class ViewPager extends StatefulWidget {
  final TabController? controller;
  final List<Widget> items;

  const ViewPager({
    Key? key,
    this.controller,
    this.items = const [],
  }) : super(key: key);

  @override
  State<ViewPager> createState() => _ViewPagerState();
}

class _ViewPagerState extends State<ViewPager>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = widget.controller ??
        TabController(
          length: widget.items.length,
          vsync: this,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: controller,
        children: widget.items,
      ),
    );
  }
}

class ViewPagerItem {
  final String title;
  final Widget view;

  const ViewPagerItem({
    required this.title,
    required this.view,
  });
}
