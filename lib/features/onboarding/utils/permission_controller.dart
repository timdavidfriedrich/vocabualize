import 'package:log/log.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController {
  static requestPermissions() async {
    Log.warning("camera: ${await Permission.camera.request()}");
    Log.warning("storage: ${await Permission.storage.request()}");
    Log.warning("manageExternalStorage: ${await Permission.manageExternalStorage.request()}");
    Log.warning("bluetooth: ${await Permission.bluetooth.request()}");
    Log.warning("microphone: ${await Permission.microphone.request()}");
    Log.warning("speech: ${await Permission.speech.request()}");
  }
}
