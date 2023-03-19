import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_utils/core/utils/controllers/view_controller.dart';

class PasswordField extends StatefulWidget {
  final PasswordEditTextController? controller;
  final String? text;
  final String hint;
  final String digits;
  final String? error;
  final int maxCharacters;
  final EdgeInsetsGeometry? margin;
  final bool Function(String value)? validator;
  final Function(String value)? onChanged;

  const PasswordField({
    Key? key,
    this.controller,
    this.text,
    this.hint = "Password",
    this.digits = "",
    this.error,
    this.maxCharacters = 16,
    this.margin,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late PasswordEditTextController controller;
  bool isChangedState = false;

  @override
  void initState() {
    controller = widget.controller ?? PasswordEditTextController();
    controller.setValidator(widget.validator);
    controller._editable.text = widget.text ?? "";
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PasswordField oldWidget) {
    controller.setValidator(widget.validator);
    controller._editable.text = widget.text ?? "";
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller._dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.only(bottom: 24),
      child: TextFormField(
        controller: controller._editable,
        inputFormatters: controller.formatter(widget.digits),
        maxLength: widget.maxCharacters,
        buildCounter: counter,
        onChanged: (value) {
          isChangedState = true;
          controller.onChange?.call();
        },
        validator: (value) {
          return !controller.isValid && isChangedState ? widget.error : null;
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

class PasswordEditTextController extends ViewController {
  late TextEditingController _editable;
  late bool Function(String value)? validator;

  PasswordEditTextController(){
    _editable = TextEditingController();
  }

  List<TextInputFormatter>? formatter(String? formatters) {
    final digit = formatters ?? "";
    if (digit.isNotEmpty) {
      return [
        FilteringTextInputFormatter.allow(RegExp("[$digit]")),
      ];
    }
    return null;
  }

  void setValidator(bool Function(String value)? validator) {
    this.validator = validator;
  }

  String get text => _editable.text;

  bool get isValid {
    final v = validator?.call(_editable.text);
    return v ?? false;
  }

  void _dispose() {
    _editable.dispose();
  }
}
