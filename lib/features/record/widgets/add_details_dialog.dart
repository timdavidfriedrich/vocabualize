import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/core/widgets/tag_wrap.dart';
import 'package:vocabualize/features/home/screens/home.dart';
import 'package:vocabualize/features/record/services/record_sheet_controller.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/features/settings/services/settings_sheet_controller.dart';

class AddDetailsDialog extends StatelessWidget {
  const AddDetailsDialog({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

  _selectImage() {
    // TODO: select image
  }

  _save() {
    // TODO: save selected image (check if image selected, if not => fallback image)
    Navigator.popUntil(Keys.context, ModalRoute.withName(Home.routeName));
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
            ? TagWrap(vocabulary: vocabulary)
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: MaterialButton(
                        onPressed: () => _selectImage(),
                        color: Theme.of(context).colorScheme.surface,
                        child: index != 0 ? null : Icon(Icons.camera_alt_rounded, color: Theme.of(context).colorScheme.primary, size: 28),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TagWrap(vocabulary: vocabulary),
                ],
              ),
      ),
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: () => _save(), child: const Text("Save")),
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
