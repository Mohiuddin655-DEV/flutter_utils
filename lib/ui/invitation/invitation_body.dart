import 'package:flutter/material.dart';

import '../../core/utils/controllers/search_view_controller.dart';
import '../../core/widgets/ex_button.dart';
import '../../core/widgets/search_view.dart';
import '../../core/widgets/view_builder.dart';
import 'data/contact.dart';
import 'invitation_item.dart';

class InvitationBody extends StatefulWidget {
  final List<ContactNumber> items;

  const InvitationBody({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<InvitationBody> createState() => _InvitationBodyState();
}

class _InvitationBodyState extends State<InvitationBody> {
  final List<ContactNumber> selectedContacts = [];
  final SearchViewController<ContactNumber> controller =
      SearchViewController(ContactNumber.contacts);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.shade100,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Select the invitation users you would like to invite.",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  "An email invite will be sent on your behalf to the selected person.",
                  style: TextStyle(
                    color: theme.primaryColor.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  height: 2,
                  color: Colors.grey.shade100,
                ),
                SearchView<ContactNumber>(
                  controller: controller,
                  hint: "Type phone or name ... ",
                  primary: theme.primaryColor,
                  keyBuilder: (query, item) {
                    final name = item.name.toLowerCase();
                    final number = item.number.toLowerCase();

                    if (name.contains(query) ||
                        number.toLowerCase().contains(query)) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  onQueries: (items) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ViewBuilder(
              component: controller.queries.isNotEmpty,
              builder: (value) {
                if (value) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    itemBuilder: (context, index) {
                      final item = controller.queries[index];
                      return InvitationItem(
                        item: item,
                        queryText: controller.query,
                        isSelected: selectedContacts.contains(item),
                        onSelectItem: (item) {
                          if (!selectedContacts.contains(item)) {
                            selectedContacts.add(item);
                          }
                          setState(() {});
                        },
                        onUnselectItem: (item) {
                          selectedContacts.remove(item);
                          setState(() {});
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 2,
                        color: Colors.grey.shade100,
                      );
                    },
                    itemCount: controller.queries.length,
                  );
                } else {
                  return Center(
                    child: Text(
                      "No contact found!",
                      style: TextStyle(
                        color: theme.primaryColor.withOpacity(0.4),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          ExButton(
            margin: const EdgeInsets.only(
              left: 32,
              right: 32,
              top: 12,
              bottom: 16,
            ),
            height: 40,
            text: buttonText,
            //background: kAppYellowColor,
            onClick: selectedContacts.isNotEmpty
                ? () {
                    print(selectedContacts);
                  }
                : null,
          ),
        ],
      ),
    );
  }

  String get buttonText {
    if (selectedContacts.isNotEmpty) {
      return "Invite ${selectedContacts.length} persons";
    } else {
      return "Select some person";
    }
  }
}
