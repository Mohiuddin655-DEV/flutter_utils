import 'package:flutter/material.dart';

typedef OnChangeListener = Function<T>(T value);
typedef OnErrorListener = String Function(ViewError type);
typedef OnNotifyListener = void Function(VoidCallback fn);
typedef OnValidListener = bool Function();
typedef OnViewClickListener = Function();

class ViewController {
  static ViewController? _proxy;

  ViewController();

  factory ViewController.of() {
    return _proxy ??= ViewController();
  }

  bool enabled = true;
  bool activated = false;
  bool visibility = true;
  OnNotifyListener? _notifier;
  OnChangeListener? _onChange;
  OnErrorListener? _onError;
  OnValidListener? _onValid;
  OnViewClickListener? _onClick, _onDoubleClick, _onLongClick;

  set onChange(OnChangeListener? listener) => _onChange = listener;

  set onClick(OnViewClickListener? listener) => _onClick = listener;

  set onError(OnErrorListener? listener) => _onError = listener;

  set onDoubleClick(OnViewClickListener? listener) => _onDoubleClick = listener;

  set onLongClick(OnViewClickListener? listener) => _onLongClick = listener;

  set onValidListener(OnValidListener? listener) => _onValid = listener;

  OnChangeListener? get onChange => enabled ? _onChange : null;

  OnViewClickListener? get onClick => enabled ? _onClick : null;

  OnErrorListener? get onError => enabled ? _onError : null;

  OnViewClickListener? get onDoubleClick => enabled ? _onDoubleClick : null;

  OnViewClickListener? get onLongClick => enabled ? _onLongClick : null;

  OnValidListener? get onValid => enabled ? _onValid : null;

  void setActivated(bool value) {
    activated = value;
    notify;
  }

  void setEnabled(bool value) {
    enabled = value;
    notify;
  }

  void setVisibility(bool value) {
    visibility = value;
    notify;
  }

  void setNotifier(OnNotifyListener notifier) {
    _notifier = notifier;
  }

  void setOnChangeListener(OnChangeListener listener) {
    _onChange = listener;
  }

  void setOnClickListener(OnViewClickListener listener) {
    _onClick = listener;
  }

  void setOnErrorListener(OnErrorListener listener) {
    _onError = listener;
  }

  void setOnDoubleClickListener(OnViewClickListener listener) {
    _onDoubleClick = listener;
  }

  void setOnLongClickListener(OnViewClickListener listener) {
    _onLongClick = listener;
  }

  void setOnValidListener(OnValidListener listener) {
    _onValid = listener;
  }

  void get notify {
    if (_notifier != null) {
      _notifier!(() {});
    }
  }
}

enum ViewError {
  none,
  empty,
  invalid,
  maximum,
  minimum,
  unmodified,
}

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
