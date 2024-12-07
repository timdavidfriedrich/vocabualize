import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/common/presentation/widgets/disconnected_dialog.dart';
import 'package:vocabualize/src/features/record/presentation/states/record_state.dart';

final recordControllerProvider =
    AutoDisposeAsyncNotifierProvider<RecordController, RecordState>(() {
  return RecordController();
});

class RecordController extends AutoDisposeAsyncNotifier<RecordState> {
  @override
  Future<RecordState> build() async {
    return RecordState(
      cameraController: await _getCameraController(),
    );
  }

  // TODO: Move getCameraController to use case??
  Future<CameraController> _getCameraController() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    return CameraController(
      firstCamera,
      ResolutionPreset.medium,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    ).also((controller) async {
      await controller.initialize();
    });
  }

  Future<bool> isOnlineAndShowDialogIfNot(BuildContext context) async {
    try {
      // TODO: Not only check for google, since this method's not working
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        if (context.mounted) {
          context.showDialog(const DisconnectedDialog());
        }
        return false;
      }
      return true;
    } on SocketException catch (_) {
      if (context.mounted) {
        context.showDialog(const DisconnectedDialog());
      }
      return false;
    }
  }
}
