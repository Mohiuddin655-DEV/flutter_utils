import 'package:flutter/material.dart';

import 'view.dart';

abstract class Activity extends StatefulWidget {
  const Activity({super.key});

  @protected
  @override
  State<StatefulWidget> createState() {
    return _ActivityState();
  }

  @protected
  View onCreate(BuildContext context);

  @protected
  @mustCallSuper
  void onInit() => onListener();

  @protected
  void onListener() {}

  @protected
  void onPause() {}

  @protected
  void onRestart() {}

  @protected
  void onResume() {}

  @protected
  void onStart() {}

  @protected
  void onStop() {}

  @protected
  void onDetached() {}

  @protected
  void onDestroy() {}
}

class _ActivityState extends State<Activity> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.onCreate(context),
    );
  }

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Activity oldWidget) {
    widget.onRestart();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void activate() {
    widget.onStart();
    super.activate();
  }

  @override
  void deactivate() {
    widget.onStop();
    super.deactivate();
  }

  @override
  void dispose() {
    widget.onDestroy();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.onResume();
        break;
      case AppLifecycleState.inactive:
        widget.onStop();
        break;
      case AppLifecycleState.paused:
        widget.onPause();
        break;
      case AppLifecycleState.detached:
        widget.onDetached();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
