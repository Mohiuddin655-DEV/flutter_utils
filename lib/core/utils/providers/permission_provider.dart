import 'package:flutter_utils/core/utils/services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider {
  const PermissionProvider._();

  static PermissionProvider? _instance;

  static PermissionProvider get I => _instance ??= const PermissionProvider._();

  Future<bool> get isContactsGranted async =>
      await PermissionService.I.isGranted(Permission.contacts);

  Future<bool> get isStorageGranted async =>
      await PermissionService.I.isGranted(Permission.storage);

  Future<bool> get isPhoneGranted async =>
      await PermissionService.I.isGranted(Permission.phone);

  Future<bool> get isCurrentLocationGranted async =>
      await PermissionService.I.isGranted(Permission.locationWhenInUse);

  Future<bool> get isSMSGranted async =>
      await PermissionService.I.isGranted(Permission.sms);

  Future<PermissionStatus> get allowStorage async =>
      await PermissionService.I.allow(Permission.storage);

  Future<PermissionStatus> get allowPhone async =>
      await PermissionService.I.allow(Permission.phone);

  Future<PermissionStatus> get allowContacts async =>
      await PermissionService.I.allow(Permission.contacts);

  Future<PermissionStatus> get allowSMS async =>
      await PermissionService.I.allow(Permission.sms);
}
