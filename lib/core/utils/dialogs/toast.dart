import 'package:fluttertoast/fluttertoast.dart' as t;

class Toast {
  const Toast();

  void toast(String message, {bool isLong = false}) {
    if (message.isNotEmpty) {
      if (isLong) {
        t.Fluttertoast.showToast(
          msg: message,
          toastLength: t.Toast.LENGTH_LONG,
          gravity: t.ToastGravity.BOTTOM,
        );
      } else {
        t.Fluttertoast.showToast(
          msg: message,
          toastLength: t.Toast.LENGTH_SHORT,
          gravity: t.ToastGravity.BOTTOM,
        );
      }
    }
  }

  static void message(String message, {bool isLong = false}) {
    return const Toast().toast(message, isLong: isLong);
  }
}
