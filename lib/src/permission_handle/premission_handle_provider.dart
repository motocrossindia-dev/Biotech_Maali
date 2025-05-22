import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PermissionHandleProvider with ChangeNotifier {
  bool _locationPermission = false;
  bool _storagePermission = false;
  bool _cameraPermission = false;
  bool _microphonePermission = false;
  bool _notificationPermission = false;

  bool get locationPermission => _locationPermission;
  bool get storagePermission => _storagePermission;
  bool get cameraPermission => _cameraPermission;
  bool get microphonePermission => _microphonePermission;
  bool get notificationPermission => _notificationPermission;

  bool get allPermissionsGranted =>
      _locationPermission &&
      _storagePermission &&
      _cameraPermission &&
      _microphonePermission &&
      _notificationPermission;

  Future<void> checkPermissions() async {
    _locationPermission = await Permission.location.isGranted;
    _storagePermission = await Permission.storage.isGranted;
    _cameraPermission = await Permission.camera.isGranted;
    _microphonePermission = await Permission.microphone.isGranted;
    _notificationPermission = await Permission.notification.isGranted;
    notifyListeners();
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    _locationPermission = status.isGranted;
    notifyListeners();
  }

  Future<void> requestStoragePermission() async {
    final status = await Permission.storage.request();
    _storagePermission = status.isGranted;
    notifyListeners();
  }

  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    _cameraPermission = status.isGranted;
    notifyListeners();
  }

  Future<void> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    _microphonePermission = status.isGranted;
    notifyListeners();
  }

  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    _notificationPermission = status.isGranted;
    notifyListeners();
  }
}
