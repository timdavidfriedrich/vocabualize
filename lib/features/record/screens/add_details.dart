import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/core/services/pexels_api/pexels_model.dart';
import 'package:vocabualize/features/core/services/pexels_api/pexels_service.dart';
import 'package:vocabualize/features/core/services/translator.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/core/widgets/tag_wrap.dart';
import 'package:vocabualize/features/home/screens/home.dart';
import 'package:vocabualize/features/record/services/add_details_arguements.dart';
import 'package:vocabualize/features/record/services/record_sheet_controller.dart';
import 'package:vocabualize/features/record/widgets/camera_gallery_dialog.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/features/settings/services/settings_sheet_controller.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({super.key});

  static const routeName = "/AddDetails";

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  late Vocabulary vocabulary;

  List<PexelsModel> _pexelsModelList = [];
  dynamic _selected;
  File? _cameraImageFile;

  final int itemCount = 7;
  final int maxItems = 70;

  int firstIndex = 0;
  int lastIndex = 6;

  _browseNext() {
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

  _getPexels() async {
    List<PexelsModel> pexelsModelList = await PexelsService().getImages(
      await Translator.inEnglish(vocabulary.source, filtered: true),
    );
    setState(() => _pexelsModelList = pexelsModelList);
  }

  _selectImage(PexelsModel? imageModel) {
    if (imageModel == null) return;
    setState(() => _selected = imageModel);
  }

  Future<dynamic> _openCam() async {
    final imageSource = await Messenger.showAnimatedDialog(const CameraGalleryDialog());
    if (imageSource == null) return;

    final XFile? image = await ImagePicker().pickImage(source: imageSource);
    if (image == null) return;

    final file = await _saveFile(image.path);

    return file;
  }

  Future<File> _saveFile(String imagePath) async {
    final String path = (await getApplicationDocumentsDirectory()).path;

    const String specialCharacters = r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';
    final String formatedDate = DateFormat("yyyy-MM-dd_HH-mm-ss").format(vocabulary.creationDate);
    final String target = vocabulary.source.toLowerCase().replaceAll(RegExp(specialCharacters), "-");
    final String name = "${formatedDate}_$target";

    return await File(imagePath).copy("$path/$name");
  }

  _save() {
    if (_cameraImageFile != null && _cameraImageFile == _selected) {
      vocabulary.cameraImageFile = _cameraImageFile;
    } else {
      vocabulary.pexelsModel = _selected ?? PexelsModel.fallback();
    }
    Navigator.pushNamed(Keys.context, Home.routeName);
    Messenger.showSaveMessage(vocabulary);
  }

  _goToSettings() async {
    SettingsSheetController settingsSheetController = SettingsSheetController.instance;
    RecordSheetController recordSheetController = RecordSheetController.instance;
    recordSheetController.hide();
    await Future.delayed(const Duration(milliseconds: 150), () => Navigator.popUntil(Keys.context, ModalRoute.withName(Home.routeName)));
    await Future.delayed(const Duration(milliseconds: 750), () => settingsSheetController.show());
    await Future.delayed(const Duration(milliseconds: 750), () => Messenger.showSaveMessage(vocabulary));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    vocabulary = (ModalRoute.of(context)!.settings.arguments as AddDetailsArguments).vocabulary;
    _getPexels();
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(48, 0, 48, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 24),
                    // Text(vocabulary.source, textAlign: TextAlign.center),
                    // const SizedBox(height: 4),
                    // Icon(Icons.arrow_downward_rounded, color: Theme.of(context).colorScheme.primary),
                    // Text(vocabulary.target, textAlign: TextAlign.center),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TextButton(
                            onPressed: () => {},
                            child: Text(vocabulary.source, textAlign: TextAlign.right, style: Theme.of(context).textTheme.displayMedium),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Flexible(
                          child: TextButton(
                            onPressed: () => {},
                            child: Text(vocabulary.target, textAlign: TextAlign.left, style: Theme.of(context).textTheme.displayMedium),
                          ),
                        ),
                      ],
                    ),
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
                                  : DecorationImage(fit: BoxFit.cover, image: NetworkImage(_selected.src["small"])),
                        ),
                        child: _selected == null
                            ? const Center(child: Text("Choose an image\nor save without one", textAlign: TextAlign.center))
                            : _selected == _cameraImageFile
                                ? Container()
                                : Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text("Photo by ${_selected.photographer}", style: Theme.of(context).textTheme.bodySmall),
                                  ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Images provides by Pexels.", style: Theme.of(context).textTheme.bodySmall),
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
                                          : Center(child: Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.onBackground)),
                                    ),
                            )
                          : InkWell(
                              onTap: () =>
                                  _pexelsModelList.isEmpty ? null : _selectImage(_pexelsModelList.elementAt(index + firstIndex - 1)),
                              borderRadius: BorderRadius.circular(16),
                              child: firstIndex + index >= _pexelsModelList.length + 1
                                  ? const Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator(strokeWidth: 2))
                                  : Ink(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: _pexelsModelList.elementAt(index + firstIndex - 1) != _selected
                                            ? null
                                            : Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(_pexelsModelList.elementAt(index + firstIndex - 1).src["small"]),
                                        ),
                                      ),
                                      child: _pexelsModelList.elementAt(index + firstIndex - 1) != _selected
                                          ? null
                                          : Center(child: Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.onBackground)),
                                    ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    TagWrap(vocabulary: vocabulary),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.2),
                        foregroundColor: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () => {},
                      child: const Icon(Icons.delete_rounded),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _save(),
                        child: Text(_selected == null ? "Save without" : "Save"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => _goToSettings(),
                  child: Text(
                    "Never ask for image? Go to settings.",
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
