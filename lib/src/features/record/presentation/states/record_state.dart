import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';

class RecordState {
  final CameraController cameraController;
  final Uint8List? imageBytes;
  final Set<String> labels;
  final Language? sourceLanguage;

  const RecordState({
    required this.cameraController,
    this.imageBytes,
    this.labels = const {},
    this.sourceLanguage,
  });

  RecordState copyWith({
    CameraController? cameraController,
    Uint8List? imageBytes,
    Set<String>? labels,
    Language? sourceLanguage,
  }) {
    return RecordState(
      cameraController: cameraController ?? this.cameraController,
      imageBytes: imageBytes ?? this.imageBytes,
      labels: labels ?? this.labels,
      sourceLanguage: sourceLanguage ?? this.sourceLanguage,
    );
  }
}
