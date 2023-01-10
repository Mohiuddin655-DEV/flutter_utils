import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/dialogs/loading_dialog.dart';

class BaseBottomSheetDialog extends LoadingDialog {
  const BaseBottomSheetDialog(super.context);

  void buildBSD(
    VoidCallback onClosing,
    Widget child,
  ) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: onClosing,
          builder: (context) {
            return child;
          },
        );
      },
    );
  }
}
