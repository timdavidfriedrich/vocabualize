import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:vocabualize/constants/common_constants.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_use_case.dart';
import 'package:vocabualize/src/features/home/screens/home_empty_screen.dart';
import 'package:vocabualize/src/features/home/widgets/collections_view.dart';
import 'package:vocabualize/src/features/home/widgets/new_vocabularies_row.dart';
import 'package:vocabualize/src/features/home/widgets/status_card.dart';
import 'package:vocabualize/src/features/home/widgets/vocabulary_list_tile.dart';
import 'package:vocabualize/src/features/record/utils/record_sheet_controller.dart';
import 'package:vocabualize/src/features/record/widgets/record_grab.dart';
import 'package:vocabualize/src/features/record/widgets/record_sheet.dart';
import 'package:vocabualize/src/features/reports/screens/report_screen.dart';
import 'package:vocabualize/src/features/reports/utils/report_arguments.dart';
import 'package:vocabualize/src/features/settings/screens/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = "/Home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getVocabularies = ref.watch(getVocabulariesUseCaseProvider(null));
    RecordSheetController recordSheetController = RecordSheetController.instance;

    void openReportPage() {
      Navigator.pushNamed(context, ReportScreen.routeName, arguments: ReportArguments.bug());
    }

    void showSettings() {
      Navigator.pushNamed(context, SettingsScreen.routeName);
    }

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
            child: getVocabularies.when(
              loading: () {
                return const Center(child: CircularProgressIndicator.adaptive());
              },
              data: (List<Vocabulary> vocabularies) {
                if (vocabularies.isEmpty) {
                  return const HomeEmptyScreen();
                }
                return ListView(
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
                              IconButton(onPressed: () => openReportPage(), icon: const Icon(Icons.bug_report_rounded)),
                              IconButton(onPressed: () => showSettings(), icon: const Icon(Icons.settings_rounded)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          StatusCard(vocabularies: vocabularies),
                        ],
                      ),
                    ),
                    const NewVocabulariesRow(),
                    const CollectionsView(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          Text(AppLocalizations.of(context)?.home_allWords ?? "", style: Theme.of(context).textTheme.headlineMedium),
                          const SizedBox(height: 12),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              vocabularies.length,
                              (index) => VocabularyListTile(
                                vocabulary: vocabularies.elementAt(index),
                              ),
                            ).reversed.toList(),
                          ),
                          const SizedBox(height: 96),
                        ],
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                // TODO: Replace with error widget
                return const HomeEmptyScreen();
              },
            ),
          ),
        ),
      ),
    );
  }
}
