import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/use_cases/language/read_out_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/tag/get_all_tags_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/vocabulary/get_new_vocabularies_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/vocabulary/get_vocabularies_use_case.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/features/collections/presentation/screens/collection_screen.dart';
import 'package:vocabualize/src/features/details/presentation/screens/details_screen.dart';
import 'package:vocabualize/src/features/home/presentation/states/home_state.dart';
import 'package:vocabualize/src/common/presentation/widgets/vocabulary_info_dialog.dart';
import 'package:vocabualize/src/features/record/presentation/screens/record_screen.dart';
import 'package:vocabualize/src/features/reports/presentation/screens/report_screen.dart';
import 'package:vocabualize/src/features/settings/presentation/screens/settings_screen.dart';

final homeControllerProvider =
    AutoDisposeAsyncNotifierProvider<HomeController, HomeState>(() {
  return HomeController();
});

class HomeController extends AutoDisposeAsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    return HomeState(
      vocabularies: ref.watch(getVocabulariesUseCaseProvider).call(),
      newVocabularies: ref.watch(getNewVocabulariesUseCaseProvider),
      tags: await ref.watch(getAllTagsUseCaseProvider.future),
      areImagesEnabled: await ref.watch(
        getAreImagesEnabledUseCaseProvider.future,
      ),
    );
  }

  void goToRecordScreen(BuildContext context) {
    context.pushNamed(RecordScreen.routeName);
  }

  void readOut(Vocabulary vocabulary) {
    final readOut = ref.read(readOutUseCaseProvider);
    readOut(vocabulary);
  }

  Future<void> showVocabularyInfo(
    BuildContext context,
    Vocabulary vocabulary,
  ) async {
    await context.showDialog(
      VocabularyInfoDialog(vocabulary: vocabulary),
    );
  }

  void goToDetails(BuildContext context, Vocabulary vocabulary) {
    context.pushNamed(
      DetailsScreen.routeName,
      arguments: DetailsScreenArguments(vocabulary: vocabulary),
    );
  }

  void openReportPage(BuildContext context) {
    context.pushNamed(ReportScreen.routeName, arguments: ReportArguments.bug());
  }

  void showSettings(BuildContext context) {
    context.pushNamed(SettingsScreen.routeName);
  }

  void goToCollection(BuildContext context, Tag tag) {
    context.pushNamed(
      CollectionScreen.routeName,
      arguments: CollectionScreenArguments(tag: tag),
    );
  }
}
