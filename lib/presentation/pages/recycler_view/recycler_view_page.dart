import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/recycler_view.dart';

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
      Colors.red,
      Colors.green,
      Colors.amber,
      Colors.black,
      Colors.red,
      Colors.green,
      Colors.amber,
      Colors.black,
      Colors.red,
      Colors.green,
      Colors.amber,
      Colors.black,
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
                items: items,
                itemCount: 3,
                itemSnap: 2,
                builder: (index, item) {
                  return Container(
                    height: size.width / 4,
                    width: size.width,
                    color: item,
                  );
                },
                separator: (index, item) {
                  return const SizedBox(
                    height: 5,
                    width: 5,
                  );
                },
              ),
              const SizedBox(height: 40),
              RecyclerView(
                direction: Axis.horizontal,
                layoutType: LayoutType.linear,
                items: items,
                builder: (index, item) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        color: item,
                      ),
                    ],
                  );
                },
                separator: (index, item) {
                  return const SizedBox(
                    height: 5,
                    width: 5,
                  );
                },
              ),
              const SizedBox(height: 40),
              RecyclerView(
                itemCount: 3,
                direction: Axis.vertical,
                items: items,
                builder: (index, item) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        color: item,
                      ),
                    ],
                  );
                },
                separator: (index, item) {
                  return const SizedBox(
                    height: 5,
                    width: 5,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
