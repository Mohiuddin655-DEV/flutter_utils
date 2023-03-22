import 'package:flutter/material.dart';

class TabValue<T> {
  final T active, inactive;

  const TabValue({
    required this.active,
    T? inactive,
  }) : inactive = inactive ?? active;

  T detect(bool activated) => activated ? active : inactive;
}

class TabView extends StatefulWidget {
  final List<String> titles;
  final TabValue<double>? titleSize;
  final TabValue<Color>? titleColor;
  final TabValue<FontWeight>? fontWeight;

  final TabController? controller;

  const TabView({
    Key? key,
    this.controller,
    this.titles = const [],
    this.titleSize,
    this.titleColor,
    this.fontWeight,
  }) : super(key: key);

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  late TabController controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = widget.controller ??
        TabController(
          length: widget.titles.length,
          vsync: this,
        );
    currentIndex = controller.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.primaryColor;
    final activated = controller.previousIndex == currentIndex;
    final color = widget.titleColor ??
        TabValue(active: primary, inactive: primary.withOpacity(0.5));
    final size = widget.titleSize ?? const TabValue(active: 18, inactive: 16);
    final style = widget.fontWeight ??
        const TabValue(active: FontWeight.bold, inactive: FontWeight.normal);
    return TabBar(
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
      controller: controller,
      tabs: widget.titles.map((e) {
        return Text(
          e,
          style: TextStyle(
            color: color.detect(activated),
            fontWeight: style.detect(activated),
            fontSize: size.detect(activated),
          ),
        );
      }).toList(),
    );
  }
}
