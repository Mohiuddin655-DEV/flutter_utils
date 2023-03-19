import 'package:flutter/material.dart';

abstract class View extends StatefulWidget {
  const View({super.key});

  @protected
  @override
  State<StatefulWidget> createState() {
    return _ViewState();
  }

  Widget build(BuildContext context);

  void onInit() {}

  void onChange() {}

  void onChangeDependencies() {}

  void onDispose() {}
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant View oldWidget) {
    widget.onChange();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    widget.onChangeDependencies();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }
}
