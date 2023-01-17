import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/expensive_list_view.dart';

import '../../../core/widgets/expensive_grid_view.dart';

class RecyclerViewPage extends StatelessWidget {
  const RecyclerViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final items = [
      Colors.red,
      Colors.green,
      Colors.amber,
      Colors.black,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.amberAccent,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.amberAccent,
      Colors.red,
      Colors.green,
      Colors.amber,
      Colors.black,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.amberAccent,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.amberAccent,
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpensiveGridView(
                direction: Axis.vertical,
                items: items,
                snapCount: 5,
                builder: (index, item) {
                  return Container(
                    height: 100,
                    color: item,
                  );
                },
              ),
              const SizedBox(height: 40),
              ExpensiveGridView(
                direction: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                items: items,
                snapCount: 2,
                builder: (index, item) {
                  return Container(
                    height: 100,
                    width: 150,
                    color: item,
                  );
                },
              ),
              const SizedBox(height: 40),
              ExpensiveListView(
                direction: Axis.horizontal,
                items: items,
                builder: (index, item) {
                  return Container(
                    height: 100,
                    width: 150,
                    color: item,
                  );
                },
              ),
              const SizedBox(height: 40),
              ExpensiveListView(
                direction: Axis.vertical,
                items: items,
                builder: (index, item) {
                  return Container(
                    height: 100,
                    width: 150,
                    color: item,
                  );
                },
              ),

              // const SizedBox(height: 40),
              // RecyclerView(
              //   direction: Axis.horizontal,
              //   layoutType: LayoutType.linear,
              //   items: items,
              //   builder: (index, item) {
              //     return Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Container(
              //           height: 50,
              //           width: 50,
              //           color: item,
              //         ),
              //       ],
              //     );
              //   },
              //   separator: (index, item) {
              //     return const SizedBox(
              //       height: 5,
              //       width: 5,
              //     );
              //   },
              // ),
              // const SizedBox(height: 40),
              // RecyclerView(
              //   direction: Axis.vertical,
              //   items: items,
              //   builder: (index, item) {
              //     return Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Container(
              //           height: 100,
              //           width: double.infinity,
              //           color: item,
              //         ),
              //       ],
              //     );
              //   },
              //   separator: (index, item) {
              //     return const SizedBox(
              //       height: 5,
              //       width: 5,
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
