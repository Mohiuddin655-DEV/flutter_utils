import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/view_builder.dart';
import 'data/notification.dart';

class NotificationItem extends StatelessWidget {
  final NotificationData item;
  final Color? primaryColor;
  final Color textColor;
  final Function()? onPressed;

  const NotificationItem({
    Key? key,
    required this.item,
    this.primaryColor,
    this.textColor = Colors.black,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newColor = primaryColor ?? Theme.of(context).primaryColor;
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        child: AbsorbPointer(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item.isNew ? newColor : textColor.withOpacity(0.1),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 60),
                              child: Text(
                                item.message ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight:
                                      item.isNew ? FontWeight.bold : null,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                ViewBuilder(
                                  component: item.name?.isNotEmpty ?? false,
                                  builder: (value) {
                                    if (value) {
                                      return Text(
                                        "${item.name} - ",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: textColor.withOpacity(0.5),
                                          fontSize: 14,
                                          fontWeight: item.isNew
                                              ? FontWeight.bold
                                              : null,
                                        ),
                                      );
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    "${item.date} at ${item.time}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: textColor.withOpacity(0.5),
                                      fontSize: 14,
                                      fontWeight:
                                          item.isNew ? FontWeight.bold : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ViewBuilder(
                          component: item.photo != null,
                          builder: (value) {
                            return value
                                ? Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: item.photo ?? '',
                                    ),
                                  )
                                : null;
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
