import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/usecases/translator/translate_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/add_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/presentation/widgets/start.dart';
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/screens/details_screen.dart';
import 'package:vocabualize/src/features/details/utils/details_arguments.dart';
import 'package:vocabualize/src/features/record/utils/record_sheet_controller.dart';

class RecordService {
  final addVocabulary = sl.get<AddVocabularyUseCase>();
  final translate = sl.get<TranslateUseCase>();

  void save({required Vocabulary vocabulary}) async {
    RecordSheetController recordSheetController = RecordSheetController.instance;
    recordSheetController.hide();
    addVocabulary(vocabulary).whenComplete(() {
      Navigator.popUntil(Global.context, ModalRoute.withName(Start.routeName)); // Pop des LoadingDialogs
      Navigator.pushNamed(Global.context, DetailsScreen.routeName, arguments: DetailsScreenArguments(vocabulary: vocabulary));
    });
  }

  void validateAndSave({required String source}) async {
    HelperWidgets.loadingAnimation();
    Vocabulary vocabulary = Vocabulary(source: source, target: await translate(source));
    // TODO: Check if already exists and then show dialog
    if (vocabulary.isValid()) save(vocabulary: vocabulary);
  }
}
