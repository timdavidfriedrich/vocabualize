import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/use_cases/language/read_out_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/tag/get_all_tags_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/vocabulary/get_vocabularies_use_case.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/features/collections/presentation/screens/collection_screen.dart';
import 'package:vocabualize/src/features/details/presentation/screens/details_screen.dart';
import 'package:vocabualize/src/features/home/presentation/states/home_state.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/info_dialog.dart';
import 'package:vocabualize/src/features/reports/presentation/screens/report_screen.dart';
import 'package:vocabualize/src/features/settings/presentation/screens/settings_screen.dart';

final homeControllerProvider = AutoDisposeAsyncNotifierProvider<HomeController, HomeState>(() {
  return HomeController();
});

class HomeController extends AutoDisposeAsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    return HomeState(
      isStillLoading: true,
      vocabularies: ref.watch(getVocabulariesUseCaseProvider(null)),
      tags: await ref.watch(getAllTagsUseCaseProvider.future),
      areImagesEnabled: await ref.watch(getAreImagesEnabledUseCaseProvider.future),
    );
  }

  void readOut(Vocabulary vocabulary) {
    final readOut = ref.read(readOutUseCaseProvider);
    readOut(vocabulary);
  }

  Future<void> showVocabularyInfo(Vocabulary vocabulary) async {
    await Global.context.showDialog(
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
