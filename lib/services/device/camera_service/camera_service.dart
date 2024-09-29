import 'dart:io';
import 'package:sync_tasks/services/device/camera_service/icamera_service.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:image_picker/image_picker.dart';

class CameraService extends ICameraService {
  final ImagePicker _picker;

  CameraService(this._picker);

  @override
  Future<File?> launchCamera() async {
    try {
      final XFile? image =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 25);
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (ex) {
      ex.logError();
      return null;
    }
  }

  @override
  Future<File?> launchSingleImagePicker() async {
    try {
      final XFile? image =
          await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (ex) {
      ex.logError();
      return null;
    }
  }
}
