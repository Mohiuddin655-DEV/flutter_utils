import 'package:flutter/material.dart';

import '../../core/widgets/tab_view.dart';
import '../../core/widgets/view_pager.dart';

class TabViewPage extends StatefulWidget {
  const TabViewPage({Key? key}) : super(key: key);

  @override
  State<TabViewPage> createState() => _TabViewPageState();
}

class _TabViewPageState extends State<TabViewPage>
    with SingleTickerProviderStateMixin {
  late List<String> titles = const ["A", "B", "C", "D", "E", "F"];
  late TabController controller = TabController(
    length: titles.length,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                child: TabView(
                  controller: controller,
                  titles: titles,
                ),
              ),
              ViewPager(
                controller: controller,
                items: titles.map((e) {
                  return View(
                    name: e,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class View extends StatelessWidget {
  final String name;

  const View({
    Key? key,
    this.name = "View",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
