import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/dialogs/media_dialog.dart';
import 'package:flutter_utils/core/utils/dialogs/share_dialog.dart';
import 'package:flutter_utils/core/utils/enums/share_type.dart';
import 'package:flutter_utils/core/utils/models/sharable_data_source.dart';
import 'package:flutter_utils/core/utils/size_config.dart';
import 'package:flutter_utils/core/widgets/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

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
              print("Hi");
              dialog.media(
                //type: MediaType.video,
                url:
                    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
                borderRadius: 12,
                borderSize: 2,
                title: "আমাদের গল্প",
                //body: "তথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়।",
                body: "তথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়। \n\nতথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়।\n\nতথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়। \n\nতথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়।\n\nতথ্য ও প্রযুক্তি আমাদের দৈনন্দিন জীবনের গুরুত্বপূর্ণ অংশ হয়ে গেছে, কিন্তু শিক্ষা ক্ষেত্রে এখনও গতানুগতিক ধারাটিই রয়ে গেছে। Shikho মনে করে বাংলাদেশের শিক্ষা ক্ষেত্রে প্রযুক্তির বিপ্লব ঘটানোর এখনই উপযুক্ত সময়।",
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

class ShareData extends StatefulWidget {
  @override
  ShareDataState createState() => ShareDataState();
}

class ShareDataState extends State<ShareData> {
  String text = '';
  String subject = '';
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    String pickedFile = imagePaths == null ? "" : imagePaths.toString();
    String trimmedFileName = pickedFile.split("/").last;
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Flutter Share Data'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Share text:',
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: 'Enter some text and/or link to share',
                  ),
                  maxLines: 2,
                  onChanged: (String value) => setState(() {
                    text = value;
                  }),
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Share subject:',
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: 'Enter subject to share (optional)',
                  ),
                  maxLines: 2,
                  onChanged: (String value) => setState(() {
                    subject = value;
                  }),
                ),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text("Add image"),
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    final pickedFile = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        imagePaths.add(pickedFile.path);
                      });
                    }
                  },
                ),
                Text(imagePaths == null ? "" : trimmedFileName),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Builder(
                      builder: (BuildContext context) {
                        return Button(
                          text: "Share",
                          textColor: Colors.orangeAccent[100],
                          onClick: text.isEmpty && imagePaths.isEmpty
                              ? null
                              : () => _onShareData(context),
                        );
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(top: 12.0)),
                    Builder(
                      builder: (BuildContext context) {
                        return Button(
                          textColor: Colors.orangeAccent[100],
                          text: 'Share With Empty Fields',
                          onClick: () => _onShareWithEmptyFields(context),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _onShareData(BuildContext context) async {
    ShareDialog dialog = ShareDialog(context);
    SharableDataSource source = SharableDataSource(ShareType.any);
    source.setPaths(imagePaths);
    source.setSubject(subject);
    source.setText(text);
    dialog.share(source);
  }

  _onShareWithEmptyFields(BuildContext context) async {
    await Share.share("text");
  }
}
