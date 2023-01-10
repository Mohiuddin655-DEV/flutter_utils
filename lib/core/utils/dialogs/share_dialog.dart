import 'dart:ui';

import 'package:flutter_utils/core/utils/dialogs/alert_dialog.dart';
import 'package:share/share.dart';

import '../models/sharable_data_source.dart';

class ShareDialog extends CustomAlertDialog {
  const ShareDialog(super.context);

  void share(
    SharableDataSource source, {
    Rect? shareOrigin,
  }) async {
    if (source.paths.isNotEmpty) {
      await Share.shareFiles(
        source.paths,
        subject: source.subject,
        text: source.text,
        mimeTypes: source.mimeTypes,
        sharePositionOrigin: shareOrigin,
      );
    } else {
      await Share.share(
        subject: source.subject,
        source.text ?? '',
        sharePositionOrigin: shareOrigin,
      );
    }
  }
}
