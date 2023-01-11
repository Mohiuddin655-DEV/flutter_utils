import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/dialogs/media_dialog.dart';
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
          //child: ShareData(),
          child: Button(
            width: 200,
            text: "Click",
            onClick: () {
              dialog.media(
                media: videoUrl,
                mediaType: MediaType.video,
                title: "Mind School",
                body: message,
              );
              // dialog.alert(
              //   "Something went wrong, please try again?",
              //   (value) => print(value),
              // );
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

//const String videoUrl = "https://www.youtube.com/watch?v=zCNBJRJS4Ls";
const String videoUrl =
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4';
const String message =
    "A healthy mind is the mantra of a healthy life, healthy physic, and healthy relationship. Mental Health is at top concerns in present era and improving the quality of our life experience is pre-eminent. Mind School is the platform where we aim to teach and train people how to develop your relationship, health, career, mindset and mental wellbeing by illuminating on your own inner intellectual strength and capacity. Here you can learn the prime lessons of your life that matters the most. \n\nWe desire to bring joy, love and fulfilment in people’s life by sharing this unique gift brought forward by our incredibly talented mind trainers. With the ease of access to internet and technological enhancement, backed by cutting edge IT solutions, we present contents and courses through this powerful platform that can transform you radically. We welcome you to grab this life changing opportunity and surround yourself with positive affirmation.";
