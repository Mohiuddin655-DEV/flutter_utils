import 'package:flutter/material.dart';

import '../../../core/utils/size_config.dart';
import 'text_view_with_app_size_config.dart';
import 'text_view_without_app_size_config.dart';

class SizeConfigBody extends StatelessWidget {
  const SizeConfigBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          TextViewWithAppSizeConfig(),
          SizedBox(height: 40),
          TextViewWithoutAppSizeConfig(),
        ],
      ),
    );
  }
}

class HItems extends StatelessWidget {
  final bool responsive;

  const HItems({
    Key? key,
    this.responsive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig.of(context);
    return SizedBox(
      height: responsive ? config.pixel(224) : 196.5,
      child: ListView.separated(
        //padding: EdgeInsets.all(config.pixel(12),),
        scrollDirection: Axis.horizontal,
        itemBuilder: (c, i) {
          return const Item();
        },
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
              //width: config.pixel(12),
              //height: config.pixel(12),
              //width: 12, height: 12,
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
  final bool responsive;

  const Item({
    Key? key,
    this.responsive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(
          responsive ? config.pixel(100) : 100,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      width: responsive ? config.pixel(196.5) : 196.5,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  config.fontSize(24).toStringAsFixed(10),
                  style: TextStyle(
                    fontSize: config.fontSize(24),
                  ),
                  maxLines: 1,
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
          Container(
            color: Colors.black,
            height: responsive ? config.pixel(50) : 50,
          ),
        ],
      ),
    );
  }
}
