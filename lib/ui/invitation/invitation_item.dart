import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'data/contact.dart';

class InvitationItem extends StatefulWidget {
  final ContactNumber item;
  final String queryText;
  final bool isSelected;
  final Function(ContactNumber item)? onSelectItem;
  final Function(ContactNumber item)? onUnselectItem;

  const InvitationItem({
    Key? key,
    required this.item,
    this.queryText = '',
    this.isSelected = false,
    this.onSelectItem,
    this.onUnselectItem,
  }) : super(key: key);

  @override
  State<InvitationItem> createState() => _InvitationItemState();
}

class _InvitationItemState extends State<InvitationItem> {
  late ThemeData theme = Theme.of(context);
  late bool isSelected = widget.isSelected;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubstringHighlight(
                text: item.name,
                term: widget.queryText,
                textStyle: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textStyleHighlight: TextStyle(
                  color: theme.primaryColor.withOpacity(0.6),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SubstringHighlight(
                text: item.number,
                term: widget.queryText,
                textStyle: TextStyle(
                  color: theme.primaryColor.withOpacity(0.4),
                  fontSize: 14,
                ),
                textStyleHighlight: TextStyle(
                    color: theme.primaryColor.withOpacity(0.6),
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  isSelected = value ?? false;
                  if (isSelected) {
                    widget.onSelectItem?.call(item);
                  } else {
                    widget.onUnselectItem?.call(item);
                  }
                });
              }),
        ],
      ),
    );
  }
}
