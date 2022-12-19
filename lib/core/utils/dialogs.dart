import 'package:flutter/material.dart';

class Dialog {
  final BuildContext context;
  final String title;
  final String buttonText;
  final ValueChanged<String> onChanged;
  late String hint;
  late TextEditingController controller;

  Dialog({
    required this.context,
    required this.onChanged,
    required this.title,
    this.hint = '',
    this.buttonText = 'Submit',
  }) {
    hint = hint.isNotEmpty ? hint : title;
    controller = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            onSubmitted: (_) => submit(),
            decoration: InputDecoration(hintText: hint),
          ),
          actions: [
            TextButton(
              onPressed: submit,
              child: Text(buttonText),
            )
          ],
        );
      },
    );
  }

  void submit() {
    final value = controller.text;
    onChanged.call(value);
    controller.clear();
    Navigator.of(context).pop();
  }
}
