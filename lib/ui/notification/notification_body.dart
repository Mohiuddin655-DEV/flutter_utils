import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/dialogs/media_dialog.dart';

import '../../core/widgets/view_builder.dart';
import 'data/notification.dart';
import 'notification_item.dart';

class NotificationBody extends StatefulWidget {
  final List<NotificationData> items;

  const NotificationBody({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  late MediaDialog dialog = MediaDialog(context);
  late ThemeData theme = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return ViewBuilder(
      component: widget.items.isNotEmpty,
      builder: (value) {
        if (value) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return NotificationItem(
                item: item,
                onPressed: () {
                  dialog.message("The notification clicked!");
                },
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 2,
                margin: const EdgeInsets.only(left: 38),
                color: Colors.grey.shade100,
              );
            },
            itemCount: widget.items.length,
          );
        } else {
          return Center(
            child: Text(
              "No notification found!",
              style: TextStyle(
                color: theme.primaryColor.withOpacity(0.4),
              ),
            ),
          );
        }
      },
    );
  }
}
