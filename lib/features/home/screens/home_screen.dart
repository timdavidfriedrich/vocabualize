import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/home/screens/home_empty_screen.dart';
import 'package:vocabualize/features/home/widgets/collections_view.dart';
import 'package:vocabualize/features/home/widgets/double_sheet.dart';
import 'package:vocabualize/features/home/widgets/new_word_card.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/home/widgets/status_card.dart';
import 'package:vocabualize/features/home/widgets/vocabulary_list_tile.dart';
import 'package:vocabualize/features/record/services/record_sheet_controller.dart';
import 'package:vocabualize/features/reports/screens/report_screen.dart';
import 'package:vocabualize/features/reports/services/report_screen_arguments.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/features/settings/services/settings_sheet_controller.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SettingsSheetController settingsSheetController;
  late RecordSheetController recordSheetController;

  void _openReportPage() {
    Navigator.pushNamed(context, ReportScreen.routeName, arguments: ReportScreenArguments.bug());
  }

  void _showSettings() {
    settingsSheetController.show();
  }

  @override
  void initState() {
    super.initState();

    settingsSheetController = SettingsSheetController.instance;
    recordSheetController = RecordSheetController.instance;

    //settingsSheetController.hide();
    //recordSheetController.hide();

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
                ? const HomeEmptyScreen()
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
                                // TODO: Replace with arb
                                Expanded(child: Text("Vocabualize", style: Theme.of(context).textTheme.headlineLarge)),
                                IconButton(onPressed: () => _openReportPage(), icon: const Icon(Icons.bug_report_rounded)),
                                IconButton(onPressed: () => _showSettings(), icon: const Icon(Icons.settings_rounded)),
                              ],
                            ),
                            const SizedBox(height: 24),
                            const StatusCard(),
                            const SizedBox(height: 32),
                            Text(AppLocalizations.of(context).home_newWords, style: Theme.of(context).textTheme.headlineMedium),
                            const SizedBox(height: 12),
                            Provider.of<VocabularyProvider>(context).lastest.isNotEmpty
                                ? Container()
                                : Text(AppLocalizations.of(context).home_noNewWords, style: Theme.of(context).textTheme.bodySmall),
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
                      Provider.of<VocabularyProvider>(context).allTags.isEmpty
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 32),
                                  Text("Collections", style: Theme.of(context).textTheme.headlineMedium),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                      const CollectionsView(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 32),
                            Text(AppLocalizations.of(context).home_allWords, style: Theme.of(context).textTheme.headlineMedium),
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
