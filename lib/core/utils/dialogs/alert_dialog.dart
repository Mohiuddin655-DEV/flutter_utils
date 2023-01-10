import 'package:flutter_utils/core/utils/dialogs/message_dialog.dart';

import '../helpers/dialog_helper.dart';

class CustomAlertDialog extends MessageDialog {
  const CustomAlertDialog(super.context);

  void alert(
    String header,
    String body,
    String positiveButton,
    String negativeButton,
    OnDataChangeListener<String> listener,
  ) {}
}
