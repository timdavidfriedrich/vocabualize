import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/widgets/start.dart';
import 'package:vocabualize/features/core/services/messaging_service.dart';
import 'package:vocabualize/features/core/services/text/translation_service.dart';
import 'package:vocabualize/features/core/models/vocabulary.dart';
import 'package:vocabualize/features/details/screens/details_screen.dart';
import 'package:vocabualize/features/details/utils/details_arguments.dart';
import 'package:vocabualize/features/record/utils/record_sheet_controller.dart';

class RecordService {
  static void save({required Vocabulary vocabulary}) async {
    RecordSheetController recordSheetController = RecordSheetController.instance;
    recordSheetController.hide();
    Provider.of<VocabularyProvider>(Global.context, listen: false).add(vocabulary).whenComplete(() {
      Navigator.popUntil(Global.context, ModalRoute.withName(Start.routeName)); // Pop des LoadingDialogs
      Navigator.pushNamed(Global.context, DetailsScreen.routeName, arguments: DetailsScreenArguments(vocabulary: vocabulary));
    });
  }

  static void validateAndSave({required String source}) async {
    MessangingService.loadingAnimation();
    Vocabulary vocabulary = Vocabulary(source: source, target: await TranslationService.translate(source));
    if (vocabulary.isValid()) save(vocabulary: vocabulary);
  }
}
