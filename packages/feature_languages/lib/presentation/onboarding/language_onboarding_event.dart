import 'package:shared/domain/entities/language.dart';

sealed class LanguageOnboardingEvent {
  const LanguageOnboardingEvent();
}

class const LanguageOnboardingStarted() extends LanguageOnboardingEvent;

class const LanguageOnboardingMainChanged({
  required final Language language,
}) extends LanguageOnboardingEvent;

class const LanguageOnboardingLearnedToggled({
  required final Language language,
}) extends LanguageOnboardingEvent;

class const LanguageOnboardingSaveRequested() extends LanguageOnboardingEvent;
