import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_utils/ui/notification/data/notification.dart';

import 'notification_body.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        actionsIconTheme: IconThemeData(
          color: primary,
        ),
        actions: [
          GestureDetector(
            onTap: () {}, // TODO: all notification status for change
            child: AbsorbPointer(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/png_icons/icon_double_tick.png",
                      width: 20,
                      height: 20,
                      color: primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Mark as read",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: NotificationBody(
          items: NotificationData.notifications,
        ),
      ),
    );
  }
}
