import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  const ConnectivityService._();

  static ConnectivityService? _instance;
  static Connectivity? _connectivity;

  static ConnectivityService get I =>
      _instance ??= const ConnectivityService._();

  static Connectivity get connectivity => _connectivity ??= Connectivity();

  Future<ConnectivityResult> get checkStatus async =>
      await connectivity.checkConnectivity();

  Stream<ConnectivityResult> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;

  Future<bool> isAvailable(ConnectivityResult result) async {
    final status = await checkStatus;
    return status == result;
  }

  Future<bool> onChangedStatus([
    ConnectivityType type = ConnectivityType.single,
  ]) async {
    final result = await getDynamicResult(type);
    return isAvailable(result);
  }

  Future<ConnectivityResult> getDynamicResult(ConnectivityType type) async {
    switch (type) {
      case ConnectivityType.first:
        return await onConnectivityChanged.first;
      case ConnectivityType.last:
        return await onConnectivityChanged.last;
      default:
        return await onConnectivityChanged.single;
    }
  }
}

enum ConnectivityType {
  single,
  first,
  last,
}
