import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/usecases/language/read_out_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/tag/get_all_tags_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_use_case.dart';
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';
import 'package:vocabualize/src/features/collections/screens/collection_screen.dart';
import 'package:vocabualize/src/features/collections/utils/collection_arguments.dart';
import 'package:vocabualize/src/features/details/screens/details_screen.dart';
import 'package:vocabualize/src/features/details/utils/details_arguments.dart';
import 'package:vocabualize/src/features/home/states/home_state.dart';
import 'package:vocabualize/src/features/home/widgets/info_dialog.dart';
import 'package:vocabualize/src/features/reports/screens/report_screen.dart';
import 'package:vocabualize/src/features/reports/utils/report_arguments.dart';
import 'package:vocabualize/src/features/settings/screens/settings_screen.dart';

final homeControllerProvider = AutoDisposeAsyncNotifierProvider<HomeController, HomeState>(() {
  return HomeController();
});

class HomeController extends AutoDisposeAsyncNotifier<HomeState> {
  List<Vocabulary> _vocabularies = [];
  @override
  Future<HomeState> build() async {
    final getVocabularies = ref.watch(getVocabulariesUseCaseProvider(null));
    getVocabularies.when(
      loading: () {},
      error: (_, __) {},
      data: (vocabularies) => _vocabularies = vocabularies,
    );
    return HomeState(
      vocabularies: _vocabularies,
      tags: await ref.watch(getAllTagsUseCaseProvider.future),
      areImagesEnabled: await ref.watch(getAreImagesEnabledUseCaseProvider.future),
    );
  }

  void readOut(Vocabulary vocabulary) {
    final readOut = ref.read(readOutUseCaseProvider);
    readOut(vocabulary);
  }

  List<Vocabulary> getVocabulariesToPracise({Tag? tag}) {
    return _vocabularies.where((vocabulary) {
      if (tag == null) return vocabulary.isDue;
      return vocabulary.isDue && vocabulary.tagIds.contains(tag.id);
    }).toList();
  }

  void showVocabularyInfo(Vocabulary vocabulary) {
    HelperWidgets.showStaticDialog(
      InfoDialog(vocabulary: vocabulary),
    );
  }

  void goToDetails(BuildContext context, Vocabulary vocabulary) {
    Navigator.pushNamed(
      context,
      DetailsScreen.routeName,
      arguments: DetailsScreenArguments(vocabulary: vocabulary),
    );
  }

  void openReportPage(BuildContext context) {
    Navigator.pushNamed(context, ReportScreen.routeName, arguments: ReportArguments.bug());
  }

  void showSettings(BuildContext context) {
    Navigator.pushNamed(context, SettingsScreen.routeName);
  }

  void goToCollection(BuildContext context, Tag tag) {
    Navigator.pushNamed(context, CollectionScreen.routeName, arguments: CollectionScreenArguments(tag: tag));
  }
}
