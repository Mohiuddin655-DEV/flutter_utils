import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordTextField extends StatefulWidget {
  final PasswordEditingController? controller;
  final String? text;
  final String hint;
  final String digits;
  final String? error;
  final int maxCharacters;
  final EdgeInsetsGeometry? margin;
  final bool Function(String value)? validator;

  const PasswordTextField({
    Key? key,
    this.controller,
    this.text,
    this.hint = "Password",
    this.digits = "",
    this.error,
    this.maxCharacters = 16,
    this.margin,
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late PasswordEditingController controller;
  bool isChangedState = false;

  @override
  void initState() {
    controller = widget.controller ?? PasswordEditingController();
    controller.text = widget.text ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.only(bottom: 24),
      child: TextFormField(
        controller: controller,
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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

class PasswordEditingController extends TextEditingController {
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
