import 'package:flutter/material.dart';

import '../utils/models/live_data.dart';
class LiveTextView extends StatefulWidget {
  final LiveTextViewController? controller;
  final LiveData<String> liveData;
  final double? width, height;
  final TextAlign? textAlign;
  final Color? textColor;
  final TextOverflow? textOverflow;
  final double textSize;
  final FontWeight? textStyle;
  final EdgeInsetsGeometry? margin, padding;
  final int? maxLines;

  const LiveTextView({
    Key? key,
    required this.liveData,
    this.controller,
    this.width,
    this.height,
    this.textAlign,
    this.textColor,
    this.textOverflow,
    this.textSize = 14,
    this.textStyle,
    this.margin,
    this.padding,
    this.maxLines,
  }) : super(key: key);

  @override
  State<LiveTextView> createState() => _LiveTextViewState();
}

class _LiveTextViewState extends State<LiveTextView> {
  late LiveTextViewController controller;

  @override
  void initState() {
    controller = widget.controller ?? LiveTextViewController();
    controller.setCallback(setState);
    controller.liveData = widget.liveData;
    controller.textAlign = widget.textAlign;
    controller.textColor = widget.textColor;
    controller.textOverflow = widget.textOverflow;
    controller.textSize = widget.textSize;
    controller.maxLines = widget.maxLines;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LiveTextView oldWidget) {
    controller.liveData = widget.liveData;
    controller.textAlign = widget.textAlign;
    controller.textColor = widget.textColor;
    controller.textOverflow = widget.textOverflow;
    controller.textSize = widget.textSize;
    controller.maxLines = widget.maxLines;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      margin: widget.margin,
      child: ValueListenableBuilder(
          valueListenable: widget.liveData,
          builder: (context, value, child) {
            return Text(
              value,
              maxLines: controller.maxLines,
              textAlign: controller.textAlign,
              overflow: controller.textOverflow,
              style: TextStyle(
                fontSize: controller.textSize,
                fontWeight: controller.fontWeight,
                color: controller.textColor,
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    controller._dispose();
    super.dispose();
  }
}

class LiveTextViewController {
  late Function(VoidCallback fn) callback;
  LiveData<String> liveData = LiveData<String>("");
  double? textSize;
  TextAlign? textAlign;
  Color? textColor;
  TextOverflow? textOverflow;
  FontWeight? fontWeight;
  int? maxLines;

  void setCallback(void Function(VoidCallback fn) callback) {
    this.callback = callback;
  }

  void setText(String? value) => liveData.setValue(value ?? "");

  void setTextAlign(TextAlign value) {
    callback(() {
      textAlign = value;
    });
  }

  void setTextColor(Color value) {
    callback(() {
      textColor = value;
    });
  }

  void setTextOverflow(TextOverflow value) {
    callback(() {
      textOverflow = value;
    });
  }

  void setTextSize(double value) {
    callback(() {
      textSize = value;
    });
  }

  void setTextWeight(FontWeight value) {
    callback(() {
      fontWeight = value;
    });
  }

  void setMaxLine(int value) {
    callback(() {
      maxLines = value;
    });
  }

  void _dispose() => liveData.dispose();
}
