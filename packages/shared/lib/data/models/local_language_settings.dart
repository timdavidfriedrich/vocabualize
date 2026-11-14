import 'package:dart_mappable/dart_mappable.dart';

part 'local_language_settings.mapper.dart';

@MappableClass()
class const LocalLanguageSettings({
  required final String? mainLanguage,
  required final String? selectedLanguage,
  required final List<String> learnedLanguages,
}) with LocalLanguageSettingsMappable;
