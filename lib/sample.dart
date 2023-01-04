import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/size_config.dart';

class Simple extends StatelessWidget {
  const Simple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: const VItems(),
        ),
      ),
    );
  }
}

class HItems extends StatelessWidget {
  const HItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig(context);
    return SizedBox(
      height: config.pixel(224),
      child: ListView.separated(
        padding: EdgeInsets.all(config.pixel(12)),
        scrollDirection: Axis.horizontal,
        itemBuilder: (c, i) {
          return Item();
        },
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: config.pixel(12),
            height: config.pixel(12),
          );
        },
      ),
    );
  }
}

class VItems extends StatelessWidget {
  const VItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        HItems(),
        HItems(),
      ],
    );
  }
}

class Item extends StatelessWidget {
  const Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(
          config.pixel(100),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      width: config.pixel(200),
      child: Stack(
        children: [
          Center(
            child: Text(
              config.fontSize(24).toStringAsFixed(2),
              style: TextStyle(
                fontSize: config.fontSize(24),
              ),
            ),
          ),
          Container(
            color: Colors.black,
            height: config.pixel(50),
          ),
        ],
      ),
    );
  }
}
