import 'package:connectivity_plus/connectivity_plus.dart';

import '../services/connectivity_service.dart';

class ConnectivityProvider {
  const ConnectivityProvider._();

  static ConnectivityProvider? _instance;

  static ConnectivityProvider get I =>
      _instance ??= const ConnectivityProvider._();

  Future<bool> get isMobile =>
      ConnectivityService.I.isAvailable(ConnectivityResult.mobile);

  Future<bool> get isWifi =>
      ConnectivityService.I.isAvailable(ConnectivityResult.wifi);

  Future<bool> get isEthernet =>
      ConnectivityService.I.isAvailable(ConnectivityResult.ethernet);

  Future<bool> get isBluetooth =>
      ConnectivityService.I.isAvailable(ConnectivityResult.bluetooth);

  Future<bool> get isVPN =>
      ConnectivityService.I.isAvailable(ConnectivityResult.vpn);

  Future<bool> get isNone =>
      ConnectivityService.I.isAvailable(ConnectivityResult.none);

  Future<bool> get isConnected async {
    final ConnectivityResult status = await ConnectivityService.I.checkStatus;
    final mobile = status == ConnectivityResult.mobile;
    final wifi = status == ConnectivityResult.wifi;
    final ethernet = status == ConnectivityResult.ethernet;
    return mobile || wifi || ethernet;
  }
}
