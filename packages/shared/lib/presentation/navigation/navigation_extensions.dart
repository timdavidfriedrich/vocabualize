import 'package:flutter/widgets.dart';
import 'package:kaisel/kaisel.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/presentation/navigation/routes.dart';

extension NavigationExtension on BuildContext {
  KaiselRouter<AppRoute> get appRouter => router<AppRoute>();

  void closeScreen() => appRouter.pop();

  Future<void> closeToHome() => appRouter.popUntil((route) => route is Home);

  Future<void> pushNewVocabularyDetails({
    required String text,
    required Language language,
    ProcessedImage? photo,
    String? context,
  }) => appRouter.push(
    NewVocabularyDetails(text: text, language: language, photo: photo, context: context),
  );

  Future<void> pushScan() => appRouter.push(const Scan());

  Future<void> pushEditVocabularyDetails({required String vocabularyId}) =>
      appRouter.push(EditVocabularyDetails(vocabularyId: vocabularyId));

  Future<void> pushSettings() => appRouter.push(const Settings());

  Future<void> pushFeedback() => appRouter.push(const FeedbackForm());

  Future<void> pushPractice({String? tagId}) => appRouter.push(Practice(tagId: tagId));

  Future<void> pushCollection({required String tagId}) => appRouter.push(Collection(tagId: tagId));

  Future<void> pushLanguages() => appRouter.push(const Languages());

  Future<void> pushLearnedLanguageDetails({required Language language}) =>
      appRouter.push(LearnedLanguageDetails(language: language));

  Future<void> pushLanguageWords({required Language language, required bool isAdding}) =>
      appRouter.push(LanguageWords(language: language, isAdding: isAdding));
}
