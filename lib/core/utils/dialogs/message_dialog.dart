import 'package:flutter/material.dart';

class MessageDialog {
  final BuildContext context;

  const MessageDialog(this.context);

  void show({
    int transparency = 0,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [],
              ),
            ),
          );
        });
  }
}
