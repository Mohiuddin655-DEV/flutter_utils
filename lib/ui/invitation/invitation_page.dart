import 'package:flutter/material.dart';

import 'data/contact.dart';
import 'invitation_body.dart';

class InvitationPage extends StatelessWidget {
  const InvitationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: InvitationBody(
          items: ContactNumber.contacts,
        ),
      ),
    );
  }
}
