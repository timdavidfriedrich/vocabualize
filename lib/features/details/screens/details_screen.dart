import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/scheduler.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:log/log.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/data/storage_service.dart';
import 'package:vocabualize/features/core/utils/format.dart';
import 'package:vocabualize/features/core/services/messaging_service.dart';
import 'package:vocabualize/features/core/models/pexels_model.dart';
import 'package:vocabualize/features/core/services/data/pexels_service.dart';
import 'package:vocabualize/features/core/services/text/translation_service.dart';
import 'package:vocabualize/features/core/models/vocabulary.dart';
import 'package:vocabualize/features/details/screens/details_disabled_images_screen.dart';
import 'package:vocabualize/features/details/widgets/source_to_target.dart';
import 'package:vocabualize/features/details/widgets/tag_wrap.dart';
import 'package:vocabualize/features/home/screens/home_screen.dart';
import 'package:vocabualize/features/details/utils/details_arguments.dart';
import 'package:vocabualize/features/details/widgets/camera_gallery_dialog.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/features/settings/screens/settings_screen.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = "${HomeScreen.routeName}/AddDetails";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Vocabulary vocabulary = Vocabulary(source: "", target: "");

  List<PexelsModel> _pexelsModelList = [];
  dynamic _selected;
  File? _cameraImageFile;

  final int itemCount = 7;
  final int maxItems = 70;

  int firstIndex = 0;
  int lastIndex = 6;

  void _initArguments() {
    DetailsScreenArguments arguments = ModalRoute.of(context)!.settings.arguments as DetailsScreenArguments;
    setState(() => vocabulary = arguments.vocabulary);
  }

  void _initImage() {
    if (!vocabulary.hasImage) return;
    _cameraImageFile = vocabulary.cameraImageFile;
    _selected = _cameraImageFile ?? vocabulary.pexelsModel;
  }

  void _getPexels() async {
    List<PexelsModel> pexelsModelList = await PexelsService().getImages(
      await TranslationService.inEnglish(vocabulary.source, filtered: true),
    );
    if (mounted) setState(() => _pexelsModelList = pexelsModelList);
  }

  void _browseNext() {
    if (lastIndex + itemCount < maxItems) {
      setState(() {
        firstIndex += itemCount;
        lastIndex += itemCount;
      });
    } else {
      setState(() {
        firstIndex = 0;
        lastIndex = 6;
      });
    }
  }

  void _openPhotographerLink() async {
    if (!await launchUrl(Uri.parse(_selected.url), mode: LaunchMode.externalApplication)) return;
  }

  void _selectImage(PexelsModel? imageModel) {
    if (imageModel == null) return;
    setState(() => _selected = imageModel);
  }

  Future<dynamic> _openCam() async {
    final imageSource = await MessangingService.showStaticDialog(const CameraGalleryDialog());
    if (imageSource == null) return;

    XFile? image;

    try {
      image = await ImagePicker().pickImage(source: imageSource);
    } catch (e) {
      Log.error("Failed to open camera or gallery.", exception: e);
    }

    if (image == null) return;

    final file = await _saveCameraFile(image.path);
    return file;
  }

  Future<File> _saveCameraFile(String imagePath) async {
    final String path = (await getApplicationDocumentsDirectory()).path;

    final String formatedDate = DateFormat("yyyy-MM-dd_HH-mm-ss").format(vocabulary.created);
    final String vocabularyName = vocabulary.source.toLowerCase().replaceAll(Format.specialCharacters, "-");
    final String name = "${formatedDate}_$vocabularyName";

    return await File(imagePath).copy("$path/$name");
  }

  void _save() {
    if (_cameraImageFile != null && _cameraImageFile == _selected) {
      vocabulary.cameraImageFile = _cameraImageFile;
      _uploadImage();
    } else {
      vocabulary.pexelsModel = _selected ?? PexelsModel.fallback();
    }
    Navigator.pop(Global.context);
    // ? Show message ?
    // Messenger.showSaveMessage(vocabulary);
  }

  Future<void> _uploadImage() async {
    if (_cameraImageFile == null) return;
    vocabulary.firebaseImageUrl = StorageService.instance.getVocabularyImageDownloadUrl(vocabulary: vocabulary);
    Uint8List imageData = await _cameraImageFile!.readAsBytes();
    Uint8List compressImageData = await FlutterImageCompress.compressWithList(
      imageData,
      quality: 70,
      minHeight: 800,
      minWidth: 800,
    );
    await StorageService.instance.uploadVocabularyImage(vocabulary: vocabulary, imageData: compressImageData);
    // item.firebaseImageUrl = await StorageService.instance.getItemImageDownloadUrl(item: item);
  }

  void _navigateToSettings() async {
    Navigator.pushNamed(context, SettingsScreen.routeName);
  }

  void _delete() {
    Provider.of<VocabularyProvider>(context, listen: false).remove(vocabulary);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _initArguments();
      _initImage();
      _getPexels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<SettingsProvider>(context).areImagesDisabled
        ? const DetailsDisabledImagesScreen()
        : SafeArea(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: vocabulary.source.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(48, 0, 48, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  const SizedBox(height: 24),
                                  SourceToTarget(vocabulary: vocabulary),
                                  const SizedBox(height: 12),
                                  AspectRatio(
                                    aspectRatio: 4 / 3,
                                    child: Container(
                                      padding: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                                        color: Theme.of(context).colorScheme.surface,
                                        image: _selected == null
                                            ? null
                                            : _selected == _cameraImageFile
                                                ? DecorationImage(fit: BoxFit.cover, image: FileImage(_cameraImageFile!))
                                                : DecorationImage(fit: BoxFit.cover, image: NetworkImage(_selected.src["large"])),
                                      ),
                                      child: _selected == null
                                          ? Center(
                                              child: Text(
                                                AppLocalizations.of(context)?.record_addDetails_noImage ?? "",
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : _selected == _cameraImageFile
                                              ? Container()
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(14),
                                                      backgroundBlendMode: BlendMode.darken,
                                                      gradient: LinearGradient(
                                                          begin: Alignment.bottomCenter,
                                                          end: Alignment.topCenter / 12,
                                                          colors: [Colors.black.withOpacity(0.5), Colors.transparent])),
                                                  child: Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: TextButton(
                                                      onPressed: () => _openPhotographerLink(),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          const SizedBox(width: 8),
                                                          Flexible(
                                                            child: Text(
                                                              // TODO: Replace with arb
                                                              "Photo by ${_selected.photographer}",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8),
                                                          Icon(
                                                            Icons.launch_rounded,
                                                            size: 18,
                                                            color: Theme.of(context).colorScheme.onPrimary,
                                                          ),
                                                          const SizedBox(width: 8),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppLocalizations.of(context)?.record_addDetails_providedBy ?? "",
                                          style: Theme.of(context).textTheme.bodySmall),
                                      IconButton(onPressed: () => _browseNext(), icon: const Icon(Icons.find_replace_rounded)),
                                    ],
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                    ),
                                    itemCount: itemCount + 1,
                                    itemBuilder: (context, index) => index == 0
                                        ? MaterialButton(
                                            padding: EdgeInsets.zero,
                                            elevation: 0,
                                            onPressed: _cameraImageFile != null && _cameraImageFile != _selected
                                                ? () => setState(() => _selected = _cameraImageFile)
                                                : () async {
                                                    final result = await _openCam();
                                                    if (result != null) {
                                                      setState(() {
                                                        _cameraImageFile = result;
                                                        _selected = result;
                                                      });
                                                    }
                                                  },
                                            color: Theme.of(context).colorScheme.surface,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                            child: _cameraImageFile == null
                                                ? Icon(Icons.camera_alt_rounded, color: Theme.of(context).colorScheme.primary, size: 28)
                                                : Ink(
                                                    padding: EdgeInsets.zero,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(16),
                                                      border: _selected != _cameraImageFile
                                                          ? null
                                                          : Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: FileImage(_cameraImageFile!),
                                                      ),
                                                    ),
                                                    child: _selected != _cameraImageFile
                                                        ? Container()
                                                        : Center(
                                                            child: Icon(Icons.done_rounded,
                                                                color: Theme.of(context).colorScheme.onBackground)),
                                                  ),
                                          )
                                        : InkWell(
                                            onTap: () => _pexelsModelList.isEmpty
                                                ? null
                                                : _selectImage(_pexelsModelList.elementAt(index + firstIndex - 1)),
                                            borderRadius: BorderRadius.circular(16),
                                            child: firstIndex + index >= _pexelsModelList.length + 1
                                                ? const Padding(
                                                    padding: EdgeInsets.all(24), child: CircularProgressIndicator(strokeWidth: 2))
                                                : Ink(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(16),
                                                      border: _pexelsModelList.elementAt(index + firstIndex - 1) != _selected
                                                          ? null
                                                          : Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image:
                                                            NetworkImage(_pexelsModelList.elementAt(index + firstIndex - 1).src["small"]),
                                                      ),
                                                    ),
                                                    child: _pexelsModelList.elementAt(index + firstIndex - 1) != _selected
                                                        ? null
                                                        : Center(
                                                            child: Icon(Icons.done_rounded,
                                                                color: Theme.of(context).colorScheme.onBackground)),
                                                  ),
                                          ),
                                  ),
                                  const SizedBox(height: 16),
                                  TagWrap(vocabulary: vocabulary),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(12),
                                    backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.2),
                                    foregroundColor: Theme.of(context).colorScheme.error,
                                  ),
                                  onPressed: () => _delete(),
                                  child: const Icon(Icons.delete_rounded),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => _save(),
                                    child: Text(
                                      _selected == null
                                          ? AppLocalizations.of(context)?.record_addDetails_saveWithoutButton ?? ""
                                          : AppLocalizations.of(context)?.record_addDetails_saveButton ?? "",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () => _navigateToSettings(),
                              child: Text(
                                AppLocalizations.of(context)?.record_addDetails_neverAskForImageButton ?? "",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
                              ),
                            )
                          ],
                        ),
                      ),
              ),
            ),
          );
  }
}
