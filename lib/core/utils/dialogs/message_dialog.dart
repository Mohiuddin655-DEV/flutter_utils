import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/dialogs/base_dialog.dart';
import 'package:flutter_utils/core/utils/extensions/string_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageDialog extends BaseDialog {
  const MessageDialog(super.context);

  void message(
    String text, {
    TextAlign? textAlign,
    Color? textColor,
    int? textMaxLine,
    double? textSize,
    FontWeight? textStyle,
    EdgeInsetsGeometry? textPadding,
    String? buttonText,
    TextAlign? buttonTextAlign,
    Color? buttonTextColor,
    double? buttonTextSize,
    FontWeight? buttonTextStyle,
    EdgeInsetsGeometry? buttonPadding,
    EdgeInsetsGeometry? padding,
  }) {
    build(
      child: _View(
        text: text,
        textAlign: textAlign,
        textColor: textColor,
        textMaxLine: textMaxLine,
        textSize: textSize,
        textStyle: textStyle,
        textPadding: textPadding,
        buttonText: buttonText,
        buttonTextAlign: buttonTextAlign,
        buttonTextColor: buttonTextColor,
        buttonTextSize: buttonTextSize,
        buttonTextStyle: buttonTextStyle,
        buttonPadding: buttonPadding,
        dismiss: dismiss,
      ),
    );
  }
}

class _View extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textStyle;
  final EdgeInsetsGeometry? textPadding;
  final String? buttonText;
  final TextAlign? buttonTextAlign;
  final Color? buttonTextColor;
  final double? buttonTextSize;
  final FontWeight? buttonTextStyle;
  final EdgeInsetsGeometry? buttonPadding;
  final int? textMaxLine;
  final Function()? dismiss;

  const _View({
    Key? key,
    this.text,
    this.textAlign,
    this.textColor,
    this.textSize,
    this.textStyle,
    this.textPadding,
    this.buttonText,
    this.buttonTextAlign,
    this.buttonTextColor,
    this.buttonTextSize,
    this.buttonTextStyle,
    this.buttonPadding,
    this.textMaxLine,
    this.dismiss,
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
          Container(
            width: double.infinity,
            padding: textPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
            child: Text(
              text ?? '',
              textAlign: textAlign ?? TextAlign.center,
              maxLines: textMaxLine ?? 3,
              style: GoogleFonts.roboto(
                color: textColor ?? Colors.black,
                fontSize: textSize ?? 16,
                fontWeight: textStyle,
              ),
            ),
          ),
          GestureDetector(
            onTap: dismiss,
            child: Container(
              width: double.infinity,
              padding: buttonPadding ?? const EdgeInsets.all(12),
              child: Text(
                (buttonText ?? 'Ok').uppercase,
                textAlign: buttonTextAlign ?? TextAlign.center,
                maxLines: textMaxLine ?? 3,
                style: GoogleFonts.roboto(
                  color: buttonTextColor ?? theme.primaryColor,
                  fontSize: buttonTextSize ?? 16,
                  fontWeight: buttonTextStyle ?? FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
