import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';

sealed class LanguagesEvent {
  const LanguagesEvent();
}

class const LanguagesStarted() extends LanguagesEvent;

class const LanguagesSetupChanged({
  required final LanguageSetup setup,
}) extends LanguagesEvent;

class const LanguagesMainLanguageChanged({
  required final Language language,
}) extends LanguagesEvent;
