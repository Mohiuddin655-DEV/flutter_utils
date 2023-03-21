import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  const PermissionService._();

  static PermissionService? _instance;

  static PermissionService get I => _instance ??= const PermissionService._();

  Future<bool> isEnabled(PermissionWithService service) async =>
      await service.serviceStatus.isEnabled;

  Future<bool> isDisabled(PermissionWithService service) async =>
      await service.serviceStatus.isDisabled;

  Future<bool> isNotApplicable(PermissionWithService service) async =>
      await service.serviceStatus.isNotApplicable;

  Future<bool> isGranted(Permission permission) async =>
      await permission.isGranted;

  Future<bool> isDenied(Permission permission) async =>
      await permission.isDenied;

  Future<bool> isShown(Permission permission) async =>
      await permission.shouldShowRequestRationale;

  Future<bool> isLimited(Permission permission) async =>
      await permission.isLimited;

  Future<bool> isRestricted(Permission permission) async =>
      await permission.isRestricted;

  Future<bool> isPermanentlyDenied(Permission permission) async =>
      await permission.isPermanentlyDenied;

  Future<PermissionStatus> status(Permission permission) async =>
      await permission.status;

  Future<PermissionStatus> allow(Permission permission) async =>
      await permission.request();

  Future<Map<Permission, PermissionStatus>> allows(
          List<Permission> permissions) async =>
      await permissions.request();

  void onSettings(Permission permission) async =>
      await permission.isPermanentlyDenied ? openAppSettings() : null;
}

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
