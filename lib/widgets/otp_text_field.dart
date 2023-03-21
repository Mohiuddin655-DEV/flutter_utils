import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpTextField extends StatefulWidget {
  final OtpEditingController? controller;
  final double? width;
  final String? text;
  final String hint;
  final String digits;
  final String? error;
  final int maxCharacters;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  final bool Function(String value)? validator;

  const OtpTextField({
    Key? key,
    this.controller,
    this.width,
    this.text,
    this.hint = "Code",
    this.digits = "1234567890",
    this.error,
    this.maxCharacters = 6,
    this.borderRadius = 0,
    this.margin,
    this.validator,
  }) : super(key: key);

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  late OtpEditingController controller;
  bool isChangedState = false;

  @override
  void initState() {
    controller = widget.controller ?? OtpEditingController();
    controller.text = widget.text ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: widget.margin ?? const EdgeInsets.only(bottom: 24),
      width: double.infinity,
      child: SizedBox(
        width: widget.width,
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.center,
          inputFormatters: controller.formatter(widget.digits),
          maxLength: widget.maxCharacters,
          buildCounter: counter,
          onChanged: (value) {
            isChangedState = true;
          },
          validator: (value) {
            bool valid = widget.validator?.call(value ?? "") ?? false;
            return !valid && isChangedState ? widget.error : null;
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            isDense: true,
            border: widget.borderRadius > 0
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius))
                : null,
          ),
        ),
      ),
    );
  }

  Widget? counter(
    BuildContext context, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  }) {
    return null;
  }
}

class OtpEditingController extends TextEditingController {
  List<TextInputFormatter>? formatter(String? formatters) {
    final digit = formatters ?? "";
    if (digit.isNotEmpty) {
      return [
        FilteringTextInputFormatter.allow(RegExp("[$digit]")),
      ];
    }
    return null;
  }
}
