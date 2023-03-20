import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/view.dart';

abstract class Fragment extends StatefulWidget {
  const Fragment({super.key});

  @protected
  @override
  State<StatefulWidget> createState() {
    return _FragmentState();
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

class _FragmentState extends State<Fragment> with WidgetsBindingObserver {
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
  void didUpdateWidget(covariant Fragment oldWidget) {
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
