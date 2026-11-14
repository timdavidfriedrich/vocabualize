import 'package:shared/data/models/local_language_settings.dart';
import 'package:shared/data/models/local_preference_key.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class SettingLocalDataSource {
  Stream<LocalLanguageSettings> watchLanguageSettings();

  Future<LocalLanguageSettings> readLanguageSettings();

  Future<void> saveLanguageSettings({
    required String? mainLanguage,
    required String? selectedLanguage,
    required Map<String, String> learnedLanguages,
    required DateTime changedAt,
  });

  Future<void> deleteLearnedLanguage(String languageCode);

  List<LocalSetting> createLanguageSettingRows({
    required String? mainLanguage,
    required String? selectedLanguage,
    required Map<String, String> learnedLanguages,
    required DateTime changedAt,
  });

  Stream<Map<LocalPreferenceKey, String>> watchPreferences();

  Future<Map<LocalPreferenceKey, String>> readPreferences();

  Future<void> savePreference(
    LocalPreferenceKey key,
    String value, {
    required DateTime changedAt,
  });

  LocalSetting createAdoptionRecord({
    required UuidValue localOwnerId,
    required DateTime adoptedAt,
  });

  Future<bool> hasAdoptionRecord(UuidValue localOwnerId);
}
