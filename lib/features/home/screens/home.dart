import 'package:flutter/material.dart';
import 'package:log/log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/home/screens/home_empty.dart';
import 'package:vocabualize/features/home/widgets/double_sheet.dart';
import 'package:vocabualize/features/home/widgets/new_word_card.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/home/widgets/status_card.dart';
import 'package:vocabualize/features/home/widgets/vocabulary_list_tile.dart';
import 'package:vocabualize/features/record/services/record_sheet_controller.dart';
import 'package:vocabualize/features/record/services/speech.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/features/settings/services/settings_sheet_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = "/";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SettingsSheetController settingsSheetController;
  late RecordSheetController recordSheetController;

  _printPermissions() async {
    Log.hint("camera: ${await Permission.camera.status}");
    Log.hint("storage: ${await Permission.storage.status}");
    Log.hint("manageExternalStorage: ${await Permission.manageExternalStorage.status}");
    Log.hint("bluetooth: ${await Permission.bluetooth.status}");
    Log.hint("microphone: ${await Permission.microphone.status}");
    Log.hint("speech: ${await Permission.speech.status}");
    Log.hint("contacts: ${await Permission.contacts.status}");
  }

  _requestPermissions() async {
    Log.warning("camera: ${await Permission.camera.request()}");
    Log.warning("storage: ${await Permission.storage.request()}");
    Log.warning("manageExternalStorage: ${await Permission.manageExternalStorage.request()}");
    Log.warning("bluetooth: ${await Permission.bluetooth.request()}");
    Log.warning("microphone: ${await Permission.microphone.request()}");
    Log.warning("speech: ${await Permission.speech.request()}");
    Log.warning("contacts: ${await Permission.contacts.request()}");
  }

  @override
  void initState() {
    super.initState();

    settingsSheetController = SettingsSheetController.instance;
    recordSheetController = RecordSheetController.instance;

    //settingsSheetController.hide();
    //recordSheetController.hide();

    _printPermissions();
    _requestPermissions();

    Provider.of<VocabularyProvider>(context, listen: false).init();
    Provider.of<SettingsProvider>(context, listen: false).init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: DoubleSheet(
            settingsSheetController: settingsSheetController,
            recordSheetController: recordSheetController,
            child: Provider.of<VocabularyProvider>(context).vocabularyList.isEmpty
                ? const HomeEmpty()
                : ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 48),
                            Row(
                              children: [
                                Expanded(child: Text("Vocabualize", style: Theme.of(context).textTheme.headlineLarge)),
                                IconButton(onPressed: () => settingsSheetController.show(), icon: const Icon(Icons.settings_rounded)),
                              ],
                            ),
                            const SizedBox(height: 24),
                            const StatusCard(),
                            const SizedBox(height: 32),
                            Text("New words", style: Theme.of(context).textTheme.headlineMedium),
                            const SizedBox(height: 12),
                            Provider.of<VocabularyProvider>(context).lastest.isNotEmpty
                                ? Container()
                                : Text(
                                    "Oh, it seems like you have not added any words for a while now.  :(",
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            Provider.of<VocabularyProvider>(context).lastest.length + 2,
                            (index) => index == 0 || index == Provider.of<VocabularyProvider>(context).lastest.length + 1
                                ? index == 0
                                    ? const SizedBox(width: 16)
                                    : const SizedBox(width: 24)
                                : Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: NewWordCard(
                                      vocabulary: Provider.of<VocabularyProvider>(context, listen: false).lastest.elementAt(index - 1),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 32),
                            Text("All words", style: Theme.of(context).textTheme.headlineMedium),
                            const SizedBox(height: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                Provider.of<VocabularyProvider>(context).vocabularyList.length,
                                (index) => VocabularyListTile(
                                  vocabulary: Provider.of<VocabularyProvider>(context).vocabularyList.elementAt(index),
                                ),
                              ).reversed.toList(),
                            ),
                            const SizedBox(height: 96),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
