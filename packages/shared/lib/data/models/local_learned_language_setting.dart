import 'package:dart_mappable/dart_mappable.dart';

part 'local_learned_language_setting.mapper.dart';

@MappableClass()
class const LocalLearnedLanguageSetting({
  required final String language,
  required final String? askMeIn,
  required final String askMeInFromLevel,
  required final String newWords,
  required final bool isPaused,
  required final DateTime addedAt,
}) with LocalLearnedLanguageSettingMappable;
