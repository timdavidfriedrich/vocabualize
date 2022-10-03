import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:log/log.dart';
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
import 'package:vocabualize/features/record/services/record_sheet_controller.dart';
import 'package:vocabualize/features/record/widgets/camera_gallery_dialog.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/features/settings/services/settings_sheet_controller.dart';

class AddDetailsDialog extends StatefulWidget {
  const AddDetailsDialog({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

  @override
  State<AddDetailsDialog> createState() => _AddDetailsDialogState();
}

class _AddDetailsDialogState extends State<AddDetailsDialog> {
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
      await Translator.inEnglish(widget.vocabulary.source, filtered: true),
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
    final String formatedDate = DateFormat("yyyy-MM-dd_HH-mm-ss").format(widget.vocabulary.creationDate);
    final String target = widget.vocabulary.source.toLowerCase().replaceAll(RegExp(specialCharacters), "-");
    final String name = "${formatedDate}_$target";

    return await File(imagePath).copy("$path/$name");
  }

  _save() {
    if (_cameraImageFile != null && _cameraImageFile == _selected) {
      widget.vocabulary.cameraImageFile = _cameraImageFile;
    } else {
      widget.vocabulary.imageModel = _selected ?? PexelsModel.fallback();
    }
    Navigator.popUntil(Keys.context, ModalRoute.withName(Home.routeName));
    Messenger.showSaveMessage(widget.vocabulary);
  }

  _goToSettings() async {
    SettingsSheetController settingsSheetController = SettingsSheetController.instance;
    RecordSheetController recordSheetController = RecordSheetController.instance;
    recordSheetController.hide();
    await Future.delayed(const Duration(milliseconds: 150), () => Navigator.popUntil(Keys.context, ModalRoute.withName(Home.routeName)));
    await Future.delayed(const Duration(milliseconds: 750), () => settingsSheetController.show());
    await Future.delayed(const Duration(milliseconds: 750), () => Messenger.showSaveMessage(widget.vocabulary));
  }

  @override
  void initState() {
    super.initState();
    _getPexels();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(12),
      titlePadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      actionsPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      title: Provider.of<SettingsProvider>(context).areImagesDisabled
          ? const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text("Add some tags"))
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Add details"),
                IconButton(padding: EdgeInsets.zero, onPressed: () => _browseNext(), icon: const Icon(Icons.find_replace_rounded)),
              ],
            ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Provider.of<SettingsProvider>(context).areImagesDisabled
            ? TagWrap(vocabulary: widget.vocabulary)
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                            onTap: () => _pexelsModelList.isEmpty ? null : _selectImage(_pexelsModelList.elementAt(index + firstIndex - 1)),
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
                  TagWrap(vocabulary: widget.vocabulary),
                ],
              ),
      ),
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: () => _save(), child: Text(_selected == null ? "Save without image" : "Save")),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _goToSettings(),
              child: Text(
                "Don't ask again? Go to settings.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
              ),
            )
          ],
        )
      ],
    );
  }
}
