import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/usecases/translator/translate_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/add_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/screens/details_screen.dart';
import 'package:vocabualize/src/features/details/utils/details_arguments.dart';

// TODO ARCHITECTURE: Remove RecordService!!! Use usecases instead, and move other logic to viewmodels
class RecordService {
  // TODO: Remove this ref! This is an anti-pattern.
  void save({required WidgetRef unwantedRef, required Vocabulary vocabulary}) async {
    final addVocabulary = unwantedRef.read(addVocabularyUseCaseProvider);
    addVocabulary(vocabulary).whenComplete(() {
      Navigator.pushNamed(Global.context, DetailsScreen.routeName, arguments: DetailsScreenArguments(vocabulary: vocabulary));
    });
  }

  void validateAndSave({required WidgetRef unwantedRef, required String source}) async {
    final translate = unwantedRef.read(translateUseCaseProvider);
    // TODO: Translation should happen elsewhere!
    Vocabulary vocabulary = Vocabulary(source: source, target: await translate(source));
    // TODO: Check if already exists and then show dialog
    if (vocabulary.isValid()) save(unwantedRef: unwantedRef, vocabulary: vocabulary);
  }
}
