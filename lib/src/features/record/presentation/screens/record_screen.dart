import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:vocabualize/constants/asset_path.dart';
import 'package:vocabualize/constants/dimensions.dart';

import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_source_language_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_target_language_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/translator/translate_use_case.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/features/details/presentation/screens/details_screen.dart';

class RecordScreen extends ConsumerStatefulWidget {
  static const String routeName = "/Record";
  const RecordScreen({super.key});

  @override
  ConsumerState<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends ConsumerState<RecordScreen> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;
  Uint8List? _imageData;
  Set<String> labels = {};
  Language? sourceLanguage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeSourceLanguage();
  }

  Future<void> _initializeSourceLanguage() async {
    sourceLanguage = await ref.read(getSourceLanguageUseCaseProvider);
  }

  void retake() {
    setState(() {
      _imageData = null;
      labels.clear();
    });
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );

    _initializeControllerFuture = _cameraController!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<String> getModelPath(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(p.dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  Future<void> _takePhotoAndScan() async {
    final modelPath = await getModelPath(AssetPath.mlModel);
    final options = LocalLabelerOptions(
      confidenceThreshold: 0.1,
      maxCount: 5,
      modelPath: modelPath,
    );
    final imageLabeler = ImageLabeler(options: options);

    try {
      final photo = await _cameraController!.takePicture();
      final inputImage = InputImage.fromFilePath(photo.path);
      final proccesedlabels = await imageLabeler.processImage(inputImage);

      if (mounted) {
        // TODO: Translate all labels after taking photo
        final data = await photo.readAsBytes();
        setState(() {
          labels.addAll(proccesedlabels.map((e) => e.label.trim()));
          _imageData = data;
        });
      }

      /*
      await _cameraController!.startImageStream(
        (CameraImage cameraImage) async {
          _cameraController!.stopImageStream();

          final format = InputImageFormatValue.fromRawValue(
            cameraImage.format.raw,
          );
          if (format == null) {
            throw Exception('Unsupported image format');
          }
          final inputImage = InputImage.fromBytes(
            bytes: cameraImage.planes[0].bytes,
            metadata: InputImageMetadata(
              size: Size(
                cameraImage.width.toDouble(),
                cameraImage.height.toDouble(),
              ),
              rotation: InputImageRotation.rotation0deg,
              format: format,
              bytesPerRow: cameraImage.planes[0].bytesPerRow,
            ),
          );
          final proccesedlabels = await imageLabeler.processImage(inputImage);

          if (mounted) {
            setState(() {
              labels.addAll(proccesedlabels.map((e) => e.label.trim()));
              _cameraImageData = cameraImage;
            });
          }
        },
      );
      */
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _validateAndGoToDetails(String source) async {
    final translate = ref.read(translateUseCaseProvider);
    final sourceLanguage = await ref.read(getSourceLanguageUseCaseProvider);
    final targetLanguage = await ref.read(getTargetLanguageUseCaseProvider);

    /*
    Future<DraftImage?> covertFrame() async {
      final convertNative = ConvertNativeImgStream();
      final imageData = await _imageData?.let((data) {
        final frame = data.planes.first.bytes;
        return convertNative.convertImgToBytes(frame, data.width, data.height);
      });
      return imageData?.let((data) => DraftImage(content: data));
    }
    */

    final image = _imageData?.let((data) => DraftImage(content: data));
    Vocabulary draftVocabulary = Vocabulary(
      source: await translate(
        source,
        sourceLanguage: Language.english(),
        targetLanguage: sourceLanguage,
      ),
      target: await translate(source),
      sourceLanguageId: sourceLanguage.id,
      targetLanguageId: targetLanguage.id,
      image: image ?? const FallbackImage(),
    );
    if (draftVocabulary.isValid && mounted) {
      context.pushNamed(
        DetailsScreen.routeName,
        arguments: DetailsScreenArguments(vocabulary: draftVocabulary),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _imageData == null,
      onPopInvoked: (didPop) => retake(),
      child: Scaffold(
          appBar: AppBar(
            title: null,
          ),
          body: _cameraController == null
              ? const Center(child: CircularProgressIndicator())
              : FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.largeSpacing,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: Dimensions.mediumSpacing,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Dimensions.largeBorderRadius,
                              ),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: _imageData == null
                                    ? CameraPreview(
                                        _cameraController!,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: labels.length,
                                            itemBuilder: (context, index) {
                                              final label =
                                                  labels.elementAt(index);
                                              return ListTile(
                                                title: Text(
                                                  label,
                                                  textAlign: TextAlign.end,
                                                ),
                                                onTap: () {
                                                  _validateAndGoToDetails(
                                                      label);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : Image.memory(
                                        _imageData!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            if (_imageData == null) ...[
                              const Spacer(),
                              FloatingActionButton.large(
                                onPressed: _takePhotoAndScan,
                                child: const Icon(Icons.camera_alt_rounded),
                              ),
                            ] else ...[
                              const SizedBox(height: Dimensions.largeSpacing),
                              TextField(
                                decoration: InputDecoration(
                                  hintText:
                                      // TODO: Replace with arb
                                      "Type in ${sourceLanguage?.name ?? "Source"} word",
                                ),
                                onSubmitted: _validateAndGoToDetails,
                              ),
                              const SizedBox(
                                height: Dimensions.semiLargeSpacing,
                              ),
                              if (labels.isNotEmpty) ...[
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  // TODO: Replace with arb
                                  child: Text("Suggestions:"),
                                ),
                                const SizedBox(
                                    height: Dimensions.semiSmallSpacing),
                              ],
                              ListView.builder(
                                itemCount: labels.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final label = labels.elementAt(index);
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: Dimensions.smallSpacing,
                                    ),
                                    child: ListTile(
                                      title: Text(label),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          Dimensions.mediumBorderRadius,
                                        ),
                                      ),
                                      tileColor:
                                          Theme.of(context).colorScheme.surface,
                                      onTap: () {
                                        _validateAndGoToDetails(label);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                            const SizedBox(height: Dimensions.largeSpacing)
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )),
    );
  }
}
