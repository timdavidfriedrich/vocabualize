import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:vocabualize/constants/common_constants.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/features/home/presentation/controllers/home_controller.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_empty_screen.dart';
import 'package:vocabualize/src/features/home/presentation/states/home_state.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/collections_view.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/new_vocabularies_row.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/status_card.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/vocabulary_list_tile.dart';
import 'package:vocabualize/src/features/record/presentation/utils/record_sheet_controller.dart';
import 'package:vocabualize/src/features/record/presentation/widgets/record_grab.dart';
import 'package:vocabualize/src/features/record/presentation/widgets/record_sheet.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = "/Home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RecordSheetController recordSheetController = RecordSheetController.instance;

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
            child: ref.watch(homeControllerProvider).when(
              loading: () {
                return const Center(child: CircularProgressIndicator.adaptive());
              },
              data: (HomeState state) {
                if (state.vocabularies.isEmpty && state.isStillLoading) {
                  return const Center(child: CircularProgressIndicator.adaptive());
                }
                if (state.vocabularies.isEmpty) {
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
                              IconButton(
                                onPressed: () {
                                  ref.read(homeControllerProvider.notifier).openReportPage(context);
                                },
                                icon: const Icon(Icons.bug_report_rounded),
                              ),
                              IconButton(
                                onPressed: () {
                                  ref.read(homeControllerProvider.notifier).showSettings(context);
                                },
                                icon: const Icon(Icons.settings_rounded),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          StatusCard(vocabularies: state.vocabularies),
                        ],
                      ),
                    ),
                    NewVocabulariesRow(state: state),
                    CollectionsView(state: state),
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
                              state.vocabularies.length,
                              (index) => VocabularyListTile(
                                areImagesEnabled: state.areImagesEnabled,
                                vocabulary: state.vocabularies.elementAt(index),
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
