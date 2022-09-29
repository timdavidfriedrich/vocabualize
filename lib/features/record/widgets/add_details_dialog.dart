import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/core/services/pexels_api/image_model.dart';
import 'package:vocabualize/features/core/services/pexels_api/image_service.dart';
import 'package:vocabualize/features/core/services/translator.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/core/widgets/tag_wrap.dart';
import 'package:vocabualize/features/home/screens/home.dart';
import 'package:vocabualize/features/record/screens/camera_screen.dart';
import 'package:vocabualize/features/record/services/camera_screen_arguments.dart';
import 'package:vocabualize/features/record/services/record_sheet_controller.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/features/settings/services/settings_sheet_controller.dart';

class AddDetailsDialog extends StatefulWidget {
  const AddDetailsDialog({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

  @override
  State<AddDetailsDialog> createState() => _AddDetailsDialogState();
}

class _AddDetailsDialogState extends State<AddDetailsDialog> {
  List<ImageModel> _imageModelList = [];
  dynamic _selected;
  File? _cameraImageFile;

  _getImages() async {
    Log.hint(await Translator.inEnglish(widget.vocabulary.source));
    List<ImageModel> imageModelList = await ImageService().getImages(await Translator.inEnglish(widget.vocabulary.source));
    setState(() => _imageModelList = imageModelList);
  }

  _selectImage(ImageModel? imageModel) {
    if (imageModel == null) return;
    setState(() => _selected = imageModel);
  }

  Future<dynamic> _openCam() async {
    // final cameras = await availableCameras();
    // final firstCamera = cameras.first;
    // final result = await Navigator.pushNamed(Keys.context, CameraScreen.routeName, arguments: CameraScreenArguments(camera: firstCamera));
    // return result;
    final result = await ImagePicker().pickImage(source: ImageSource.camera);
    return result;
  }

  _save() {
    if (_cameraImageFile != null && _cameraImageFile == _selected) {
      widget.vocabulary.cameraImageFile = _cameraImageFile;
    } else {
      widget.vocabulary.imageModel = _selected ?? ImageModel.fallback();
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
    _getImages();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Provider.of<SettingsProvider>(context).areImagesEnabled ? "Pick an image" : "Add some tags"),
      insetPadding: const EdgeInsets.all(12),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      actionsPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
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
                    itemCount: 8,
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
                            onTap: () => _imageModelList.isEmpty ? null : _selectImage(_imageModelList.elementAt(index - 1)),
                            borderRadius: BorderRadius.circular(16),
                            child: index >= _imageModelList.length + 1
                                ? const Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator(strokeWidth: 2))
                                : Ink(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: _imageModelList.elementAt(index - 1) != _selected
                                          ? null
                                          : Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(_imageModelList.elementAt(index - 1).src["small"]),
                                      ),
                                    ),
                                    child: _imageModelList.elementAt(index - 1) != _selected
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
