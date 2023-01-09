import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/dialogs/video_dialog.dart';
import 'package:flutter_utils/core/utils/size_config.dart';
import 'package:flutter_utils/core/widgets/button.dart';

class Simple extends StatelessWidget {
  const Simple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dialog = MediaDialog(context);
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Button(
            width: 200,
            text: "Click",
            onClick: () {
              print("Hi");
              dialog.media(
                borderRadius: 12,
                borderSize: 2,
                title: "আমাদের গল্প",
                //body: "তথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়।",
                body: "তথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়। \n\nতথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়।\n\nতথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়। \n\nতথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়।\n\nতথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়।"
              );
            },
            //onClick: MessageDialog.message("Hi"),
          ), //const VItems(),
        ),
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
          return Item();
        },
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
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
