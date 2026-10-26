import 'package:flutter/widgets.dart';
import 'package:kaisel/kaisel.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/presentation/navigation/routes.dart';

extension NavigationExtension on BuildContext {
  KaiselRouter<AppRoute> get appRouter => router<AppRoute>();

  void closeScreen() => appRouter.pop();

  Future<void> closeToHome() => appRouter.popUntil((route) => route is Home);

  Future<void> pushNewVocabularyDetails({required String source, ProcessedImage? photo}) =>
      appRouter.push(NewVocabularyDetails(source: source, photo: photo));

  Future<void> pushScan() => appRouter.push(const Scan());

  Future<void> pushEditVocabularyDetails({required String vocabularyId}) =>
      appRouter.push(EditVocabularyDetails(vocabularyId: vocabularyId));

  Future<void> pushSettings() => appRouter.push(const Settings());

  Future<void> pushFeedback() => appRouter.push(const FeedbackForm());

  Future<void> pushPractice({String? tagId}) => appRouter.push(Practice(tagId: tagId));

  Future<void> pushCollection({required String tagId}) => appRouter.push(Collection(tagId: tagId));

  Future<void> pushLanguageSelection() =>
      appRouter.push(const LanguageSelection(isOnboarding: false));
}
