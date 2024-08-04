import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/presentation/providers/vocabulary_provider.dart';
import 'package:vocabualize/src/common/presentation/widgets/start.dart';
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';
import 'package:vocabualize/src/common/data/repositories/translator_repository.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/screens/details_screen.dart';
import 'package:vocabualize/src/features/details/utils/details_arguments.dart';
import 'package:vocabualize/src/features/record/utils/record_sheet_controller.dart';

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
    HelperWidgets.loadingAnimation();
    Vocabulary vocabulary = Vocabulary(source: source, target: await TranslatorRepository.translate(source));
    if (vocabulary.isValid()) save(vocabulary: vocabulary);
  }
}
