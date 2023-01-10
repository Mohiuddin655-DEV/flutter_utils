import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/dialogs/toast.dart';

class BaseDialog extends Toast {
  final BuildContext context;

  const BaseDialog(this.context);

  void build({
    required Widget child,
    Color? background,
    bool? dismissible,
    double? borderRadius,
    double? elevation,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismissible ?? false,
      barrierColor: background ?? Colors.black54,
      builder: (context) {
        return Dialog(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          child: child,
        );
      },
    );
  }

  void dismiss() => Navigator.pop(context);
}
