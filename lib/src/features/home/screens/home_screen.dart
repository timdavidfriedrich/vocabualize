import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:vocabualize/constants/common_constants.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/usecases/tag/get_all_tags_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_new_vocabularies_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_use_case.dart';
import 'package:vocabualize/src/features/home/screens/home_empty_screen.dart';
import 'package:vocabualize/src/features/home/widgets/collections_view.dart';
import 'package:vocabualize/src/features/home/widgets/new_word_card.dart';
import 'package:vocabualize/src/features/home/widgets/status_card.dart';
import 'package:vocabualize/src/features/home/widgets/vocabulary_list_tile.dart';
import 'package:vocabualize/src/features/record/utils/record_sheet_controller.dart';
import 'package:vocabualize/src/features/record/widgets/record_grab.dart';
import 'package:vocabualize/src/features/record/widgets/record_sheet.dart';
import 'package:vocabualize/src/features/reports/screens/report_screen.dart';
import 'package:vocabualize/src/features/reports/utils/report_arguments.dart';
import 'package:vocabualize/src/features/settings/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/Home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final getVocabularies = sl.get<GetVocabulariesUseCase>();
  final getNewVocabularies = sl.get<GetNewVocabulariesUseCase>();
  final getAllTags = sl.get<GetAllTagsUseCase>();
  late RecordSheetController recordSheetController;

  void _openReportPage() {
    Navigator.pushNamed(context, ReportScreen.routeName, arguments: ReportArguments.bug());
  }

  void _showSettings() {
    Navigator.pushNamed(context, SettingsScreen.routeName);
  }

  @override
  void initState() {
    recordSheetController = RecordSheetController.instance;
    super.initState();
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
          body: SnappingSheet(
            controller: recordSheetController,
            initialSnappingPosition: recordSheetController.retractedPosition,
            snappingPositions: [recordSheetController.retractedPosition, recordSheetController.extendedPosition],
            grabbing: const RecordGrab(),
            grabbingHeight: 64,
            sheetBelow: SnappingSheetContent(draggable: true, child: const RecordSheet()),
            child: StreamBuilder<List<Vocabulary>>(
                stream: getVocabularies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  }
                  if (!snapshot.hasData) return const HomeEmptyScreen();
                  List<Vocabulary> vocabularyList = snapshot.data!;
                  final newVocabularies = vocabularyList.where((v) {
                    return v.created.isAfter(DateTime.now().subtract(const Duration(days: 7)));
                  }).toList();
                  return vocabularyList.isEmpty
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
                                      Expanded(
                                        child: FittedBox(
                                          alignment: Alignment.centerLeft,
                                          fit: BoxFit.scaleDown,
                                          child: Text(CommonConstants.appName, style: Theme.of(context).textTheme.headlineLarge),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      IconButton(onPressed: () => _openReportPage(), icon: const Icon(Icons.bug_report_rounded)),
                                      IconButton(onPressed: () => _showSettings(), icon: const Icon(Icons.settings_rounded)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  const StatusCard(),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 32),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: Text(
                                    AppLocalizations.of(context)?.home_newWords ?? "",
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                newVocabularies.isEmpty
                                    ? Text(
                                        AppLocalizations.of(context)?.home_noNewWords ?? "",
                                        style: Theme.of(context).textTheme.bodySmall,
                                      )
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: List.generate(
                                            newVocabularies.length + 2,
                                            (index) => index == 0 || index == newVocabularies.length + 1
                                                ? index == 0
                                                    ? const SizedBox(width: 16)
                                                    : const SizedBox(width: 24)
                                                : Padding(
                                                    padding: const EdgeInsets.only(left: 8),
                                                    child: NewWordCard(
                                                      vocabulary: newVocabularies.elementAt(index - 1),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            FutureBuilder<List<Tag>>(
                              future: getAllTags(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return const SizedBox();
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 32),
                                      // TODO: Replace with arb
                                      Text(
                                        "Tags",
                                        style: Theme.of(context).textTheme.headlineMedium,
                                      ),
                                      const SizedBox(height: 12),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const CollectionsView(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 32),
                                  Text(AppLocalizations.of(context)?.home_allWords ?? "",
                                      style: Theme.of(context).textTheme.headlineMedium),
                                  const SizedBox(height: 12),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                      vocabularyList.length,
                                      (index) => VocabularyListTile(
                                        vocabulary: vocabularyList.elementAt(index),
                                      ),
                                    ).reversed.toList(),
                                  ),
                                  const SizedBox(height: 96),
                                ],
                              ),
                            ),
                          ],
                        );
                }),
          ),
        ),
      ),
    );
  }
}
