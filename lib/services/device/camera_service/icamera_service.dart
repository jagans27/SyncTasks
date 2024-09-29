import 'dart:io';

abstract class ICameraService{
  Future<File?> launchCamera();
  Future<File?> launchSingleImagePicker();
}