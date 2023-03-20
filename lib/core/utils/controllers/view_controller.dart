import 'package:flutter/cupertino.dart';

import '../../widgets/activity.dart';

typedef OnChangeListener = Function();
typedef OnErrorListener = String Function(ErrorType type);
typedef OnNotifyListener = void Function(VoidCallback fn);
typedef OnValidListener = bool Function();
typedef OnViewListener = Function();

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
  OnViewListener? _onClick, _onDoubleClick, _onLongClick;

  set onChange(OnChangeListener? listener) => _onChange = listener;

  set onClick(OnViewListener? listener) => _onClick = listener;

  set onError(OnErrorListener? listener) => _onError = listener;

  set onDoubleClick(OnViewListener? listener) => _onDoubleClick = listener;

  set onLongClick(OnViewListener? listener) => _onLongClick = listener;

  set onValidListener(OnValidListener? listener) => _onValid = listener;

  OnChangeListener? get onChange => enabled ? _onChange : null;

  OnViewListener? get onClick => enabled ? _onClick : null;

  OnErrorListener? get onError => enabled ? _onError : null;

  OnViewListener? get onDoubleClick => enabled ? _onDoubleClick : null;

  OnViewListener? get onLongClick => enabled ? _onLongClick : null;

  OnValidListener? get onValid => enabled ? _onValid : null;

  void attach(Activity activity) {
    activity.key;
  }

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

  void setListener(OnNotifyListener notifier) {
    _notifier = notifier;
  }

  void setOnChangeListener(OnChangeListener listener) {
    _onChange = listener;
  }

  void setOnClickListener(OnViewListener listener) {
    _onClick = listener;
  }

  void setOnErrorListener(OnErrorListener listener) {
    _onError = listener;
  }

  void setOnDoubleClickListener(OnViewListener listener) {
    _onDoubleClick = listener;
  }

  void setOnLongClickListener(OnViewListener listener) {
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

enum ErrorType {
  none,
  empty,
  invalid,
  maximum,
  minimum,
  unmodified,
}
