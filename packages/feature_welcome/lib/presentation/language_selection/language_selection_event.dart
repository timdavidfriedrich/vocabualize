import 'package:shared/domain/entities/language.dart';

sealed class LanguageSelectionEvent {
  const LanguageSelectionEvent();
}

class const LanguageSelectionStarted() extends LanguageSelectionEvent;

class const LanguageSelectionSourceChanged({
  required final Language language,
}) extends LanguageSelectionEvent;

class const LanguageSelectionTargetChanged({
  required final Language language,
}) extends LanguageSelectionEvent;

class const LanguageSelectionSaveRequested() extends LanguageSelectionEvent;
