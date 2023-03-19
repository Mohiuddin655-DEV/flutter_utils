import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/dialogs/media_dialog.dart';
import 'package:flutter_utils/core/widgets/ex_button.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dialog = MediaDialog(context);
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: ExButton(
            width: 200,
            text: "Click",
            onClick: () {
              dialog.media(
                media: media,
                mediaType: MediaType.video,
                title: "Mind School",
                body: message,
              );
            },
          ),
        ),
      ),
    );
  }
}

const String media =
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4';
const String message =
    "A healthy mind is the mantra of a healthy life, healthy physic, and healthy relationship. Mental Health is at top concerns in present era and improving the quality of our life experience is pre-eminent. Mind School is the platform where we aim to teach and train people how to develop your relationship, health, career, mindset and mental wellbeing by illuminating on your own inner intellectual strength and capacity. Here you can learn the prime lessons of your life that matters the most. \n\nWe desire to bring joy, love and fulfilment in people’s life by sharing this unique gift brought forward by our incredibly talented mind trainers. With the ease of access to internet and technological enhancement, backed by cutting edge IT solutions, we present contents and courses through this powerful platform that can transform you radically. We welcome you to grab this life changing opportunity and surround yourself with positive affirmation.";
