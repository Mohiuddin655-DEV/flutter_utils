import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/dialogs/message_dialog.dart';
import 'package:flutter_utils/core/widgets/operation_view.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlertDialog extends MessageDialog {
  const CustomAlertDialog(super.context);

  void alert(
    String title,
    Function(String value) listener, {
    TextAlign? titleTextAlign,
    Color? titleTextColor,
    double? titleTextSize,
    FontWeight? titleTextStyle,
    String? body,
    TextAlign? bodyTextAlign,
    Color? bodyTextColor,
    double? bodyTextSize,
    FontWeight? bodyTextStyle,
    TextAlign? buttonTextAlign,
    double? buttonTextSize,
    FontWeight? buttonTextStyle,
    EdgeInsetsGeometry? buttonPadding,
    String? positiveButtonText,
    Color? positiveButtonTextColor,
    String? negativeButtonText,
    Color? negativeButtonTextColor,
  }) {
    build(
      dismissible: false,
      child: _View(
        title: title,
        titleTextAlign: titleTextAlign,
        titleTextColor: titleTextColor,
        titleTextSize: titleTextSize,
        titleTextStyle: titleTextStyle,
        body: body,
        bodyTextAlign: bodyTextAlign,
        bodyTextColor: bodyTextColor,
        bodyTextSize: bodyTextSize,
        bodyTextStyle: bodyTextStyle,
        positiveButtonText: positiveButtonText,
        positiveButtonTextColor: positiveButtonTextColor,
        negativeButtonText: negativeButtonText,
        negativeButtonTextColor: negativeButtonTextColor,
        buttonTextAlign: buttonTextAlign,
        buttonTextSize: buttonTextSize,
        buttonTextStyle: buttonTextStyle,
        buttonPadding: buttonPadding,
        onPressed: listener,
        onCancel: dismiss,
      ),
    );
  }
}

class _View extends StatelessWidget {
  final String title;
  final TextAlign? titleTextAlign;
  final Color? titleTextColor;
  final double? titleTextSize;
  final FontWeight? titleTextStyle;
  final String? body;
  final TextAlign? bodyTextAlign;
  final Color? bodyTextColor;
  final double? bodyTextSize;
  final FontWeight? bodyTextStyle;
  final TextAlign? buttonTextAlign;
  final double? buttonTextSize;
  final FontWeight? buttonTextStyle;
  final EdgeInsetsGeometry? buttonPadding;
  final String? positiveButtonText;
  final Color? positiveButtonTextColor;
  final String? negativeButtonText;
  final Color? negativeButtonTextColor;
  final Function(String value)? onPressed;
  final Function()? onCancel;

  const _View({
    Key? key,
    required this.title,
    this.titleTextAlign,
    this.titleTextColor,
    this.titleTextSize,
    this.titleTextStyle,
    this.body,
    this.bodyTextAlign,
    this.bodyTextColor,
    this.bodyTextSize,
    this.bodyTextStyle,
    this.buttonTextAlign,
    this.buttonTextSize,
    this.buttonTextStyle,
    this.buttonPadding,
    this.positiveButtonText,
    this.positiveButtonTextColor,
    this.negativeButtonText,
    this.negativeButtonTextColor,
    this.onPressed,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
        minWidth: 300,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    title,
                    maxLines: 5,
                    textAlign: titleTextAlign ?? TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      color: titleTextColor ?? Colors.black,
                      fontSize: titleTextSize ?? 16,
                      fontWeight: titleTextStyle,
                    ),
                  ),
                ),
                OperationView(
                  operation: body != null,
                  builder: (value) {
                    if (value) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          body ?? '',
                          textAlign: bodyTextAlign ?? TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: GoogleFonts.roboto(
                            color: bodyTextColor ?? Colors.grey,
                            fontSize: bodyTextSize ?? 14,
                            fontWeight: bodyTextStyle ?? FontWeight.w300,
                          ),
                        ),
                      );
                    } else {
                      return null;
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Button(
                    text: negativeButtonText ?? "Cancel",
                    textColor: negativeButtonTextColor ?? Colors.redAccent,
                    onPressed: () {
                      onPressed?.call(negativeButtonText ?? "Cancel");
                      onCancel?.call();
                    },
                  ),
                ),
                Expanded(
                  child: Button(
                    text: positiveButtonText ?? "OK",
                    textColor: positiveButtonTextColor ?? theme.primaryColor,
                    onPressed: () {
                      onPressed?.call(positiveButtonText ?? "OK");
                      onCancel?.call();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textStyle;
  final EdgeInsetsGeometry? buttonPadding;
  final Function()? onPressed;

  const Button({
    Key? key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textStyle,
    this.buttonPadding,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: buttonPadding ?? const EdgeInsets.all(12),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            color: textColor ?? theme.primaryColor,
            fontSize: textSize ?? 16,
            fontWeight: textStyle ?? FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
