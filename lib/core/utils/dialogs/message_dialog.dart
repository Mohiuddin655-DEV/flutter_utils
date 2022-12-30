import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_utils/core/utils/extensions/string_helper.dart';

class MessageDialog {
  static void message(String message) {
    if (message.isNotEmpty) {
      SmartDialog.show(builder: (context) {
        return View(message: message);
      });
    }
  }
}

class View extends StatelessWidget {
  final String message;

  const View({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: const TextStyle(
                color: Colors.black,
                wordSpacing: 6,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Text(
              "OK".uppercase,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                wordSpacing: 6,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
