import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  final String hint;
  final String? initialValue, level;
  final EdgeInsetsGeometry? padding, margin;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final BorderRadius? borderRadius;
  final TextEditingController? controller;

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
    this.controller,
  }) : super(key: key);

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nullable = widget.initialValue == 'null';
    widget.controller?.text = !nullable ? widget.initialValue ?? '' : '';
    return Container(
      color: Colors.red.withOpacity(0.2),
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        keyboardType: widget.inputType,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          //constraints: const BoxConstraints(maxHeight: 50),

          errorText: "This is error text",
          hintText: widget.hint,
          //border: const UnderlineInputBorder(),
          // border: OutlineInputBorder(
          //   borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
          // ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: widget.level ?? widget.hint,
          //contentPadding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        ),
      ),
    );
  }
}

class InputBorder extends StatelessWidget {
  const InputBorder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
