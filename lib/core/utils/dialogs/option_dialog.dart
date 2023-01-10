import 'package:flutter/cupertino.dart';
import 'package:flutter_utils/core/utils/dialogs/base_dialog.dart';

import '../callbacks/on_data_changed_listener.dart';

class OptionDialog extends BaseDialog {
  const OptionDialog(super.context);

  void options(
    List<String> options,
    OnDataChangeListener<String> listener,
  ) {
    build(
      child: Text(options[0]),
    );
  }
}
