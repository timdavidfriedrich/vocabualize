import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/firebase/root.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/core/services/translator.dart';
import 'package:vocabualize/features/core/models/vocabulary.dart';
import 'package:vocabualize/features/details/screens/details_screen.dart';
import 'package:vocabualize/features/details/services/details_arguments.dart';
import 'package:vocabualize/features/record/services/record_sheet_controller.dart';

class RecordService {
  static void save({required Vocabulary vocabulary}) async {
    RecordSheetController recordSheetController = RecordSheetController.instance;
    recordSheetController.hide();
    Provider.of<VocabularyProvider>(Global.context, listen: false).add(vocabulary).whenComplete(() {
      Navigator.popUntil(Global.context, ModalRoute.withName(Root.routeName)); // Pop des LoadingDialogs
      Navigator.pushNamed(Global.context, DetailsScreen.routeName, arguments: DetailsScreenArguments(vocabulary: vocabulary));
    });
  }

  static void validateAndSave({required String source}) async {
    Messenger.loadingAnimation();
    Vocabulary vocabulary = Vocabulary(source: source, target: await Translator.translate(source));
    if (vocabulary.isValid()) save(vocabulary: vocabulary);
  }
}
