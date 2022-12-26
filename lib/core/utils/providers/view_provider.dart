import 'package:flutter/cupertino.dart';
import 'package:flutter_utils/core/utils/extensions/widget_helper.dart';

class ViewProvider {
  const ViewProvider._();

  static Widget setViewStatus(Widget view, bool isActivate) {
    return view.setActivated(isActivate);
  }
}
