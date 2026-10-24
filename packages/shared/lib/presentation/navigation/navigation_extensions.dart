import 'package:flutter/widgets.dart';
import 'package:kaisel/kaisel.dart';
import 'package:shared/presentation/navigation/routes.dart';

extension NavigationExtension on BuildContext {
  KaiselRouter<AppRoute> get appRouter => router<AppRoute>();

  void closeScreen() => appRouter.pop();

  Future<void> pushVocabularyDetails() => appRouter.push(const VocabularyDetails());

  Future<void> pushSettings() => appRouter.push(const Settings());

  Future<void> pushLanguageSelection() =>
      appRouter.push(const LanguageSelection(isOnboarding: false));
}
