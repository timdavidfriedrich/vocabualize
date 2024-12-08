import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:log/log.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:vocabualize/constants/asset_path.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_source_language_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_target_language_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/translator/translate_use_case.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/common/presentation/widgets/disconnected_dialog.dart';
import 'package:vocabualize/src/features/details/presentation/screens/details_screen.dart';
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
      sourceLanguage: await ref.read(getSourceLanguageUseCaseProvider),
      targetLanguage: await ref.read(getTargetLanguageUseCaseProvider),
    );
  }

  // TODO: Move getCameraController to use case??
  Future<CameraController> _getCameraController() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    final cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );

    await cameraController.initialize();
    await cameraController.setFlashMode(FlashMode.off);
    return cameraController;
  }

  Future<String> _getModelPath(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(p.dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
    }
    return file.path;
  }

  // TODO: Move photo taking + scanning to (separate?) use cases
  Future<void> takePhotoAndScan() async {
    state.value?.let((value) async {
      try {
        final photo = await value.cameraController.takePicture();
        final data = await photo.readAsBytes();

        state = AsyncData(
          value.copyWith(
            imageBytes: () => data,
          ),
        );
        _scanForSuggestions(InputImage.fromFilePath(photo.path));
      } catch (e) {
        Log.error('Error taking picture.', exception: e);
      }
    });
  }

  Future<void> _scanForSuggestions(InputImage inputImage) async {
    state.value?.let((value) async {
      final modelPath = await _getModelPath(AssetPath.mlModel);
      final options = LocalLabelerOptions(
        confidenceThreshold: 0.1,
        maxCount: 5,
        modelPath: modelPath,
      );
      final imageLabeler = ImageLabeler(options: options);
      final proccesedlabels = await imageLabeler.processImage(inputImage);

      final Iterable<String> suggestions = await Future.wait(
        proccesedlabels.map((e) async {
          final label = e.label.trim();
          return await ref.read(translateUseCaseProvider)(
            label,
            sourceLanguage: Language.english(),
            targetLanguage: value.sourceLanguage,
          );
        }),
      );

      state = AsyncData(
        value.copyWith(
          suggestions: {...suggestions},
        ),
      );
    });
  }

  void retakePhoto() {
    state.value?.let((value) {
      state = AsyncData(
        value.copyWith(
          suggestions: {},
          imageBytes: () => null,
        ),
      );
    });
  }

  Future<void> validateAndGoToDetails(
    BuildContext context, {
    required String source,
  }) async {
    state.value?.let((value) async {
      final translate = ref.read(translateUseCaseProvider);

      final image = value.imageBytes?.let((data) => DraftImage(content: data));
      Vocabulary draftVocabulary = Vocabulary(
        source: source,
        target: await translate(source),
        sourceLanguageId: value.sourceLanguage?.id ?? "",
        targetLanguageId: value.targetLanguage?.id ?? "",
        image: image ?? const FallbackImage(),
      );
      if (draftVocabulary.isValid && context.mounted) {
        context.pushNamed(
          DetailsScreen.routeName,
          arguments: DetailsScreenArguments(vocabulary: draftVocabulary),
        );
      }
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
