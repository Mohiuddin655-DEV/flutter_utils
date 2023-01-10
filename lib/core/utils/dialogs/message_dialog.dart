import 'package:flutter/cupertino.dart';
import 'package:flutter_utils/core/utils/dialogs/base_dialog.dart';

class MessageDialog extends BaseDialog {
  const MessageDialog(super.context);

  void message(String message) {
    build(
      child: Text(message),
    );
  }
}
