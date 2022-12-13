import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  final String hint;
  final String? initialValue, level;
  final EdgeInsetsGeometry? padding, margin;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final BorderRadius? borderRadius;

  const EditText({
    Key? key,
    required this.hint,
    this.initialValue,
    this.level,
    this.padding,
    this.margin,
    this.inputType,
    this.onChanged,
    this.enabled = true,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        enabled: widget.enabled,
        controller: controller,
        keyboardType: widget.inputType,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: widget.level ?? widget.hint,
          contentPadding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        ),
      ),
    );
  }
}
