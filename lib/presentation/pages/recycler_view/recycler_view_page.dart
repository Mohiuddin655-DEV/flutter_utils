import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/recycler_view.dart';

class RecyclerViewPage extends StatelessWidget {
  const RecyclerViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final items = [
    ];
    final items2 = [
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
              RecyclerView(
                direction: Axis.vertical,
                layoutType: LayoutType.grid,
                items: items2,
                snapCount: 2,
                builder: (index, item) {
                  return Container(
                    height: 100,
                    color: item,
                  );
                },
              ),
              const SizedBox(height: 40),
              RecyclerView(
                direction: Axis.horizontal,
                layoutType: LayoutType.grid,
                items: items2,
                snapCount: 4,
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
