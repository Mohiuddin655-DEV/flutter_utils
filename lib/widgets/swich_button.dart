import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'view.dart';

class SwitchButton extends StatefulWidget {
  final SwitchController? controller;
  final bool value;
  final OnChangeListener? onChange;

  const SwitchButton({
    Key? key,
    this.controller,
    this.value = false,
    this.onChange,
  }) : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  late SwitchController controller;

  @override
  void initState() {
    controller = widget.controller ?? SwitchController();
    super.initState();
  }

  void initController() {
    controller.setNotifier(setState);
    controller.value = widget.value;
    controller.onChange = widget.onChange;
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return CupertinoSwitch(
      value: controller.value,
      activeColor: primary,
      onChanged: (value) {
        if (controller.onChange != null) controller.onChange?.call(value);
        setState(() {
          controller.value = value;
        });
      },
    );
  }
}

class SwitchController extends ViewController {
  bool value = false;

  void setValue(bool value) {
    this.value = value;
    notify;
  }
}
