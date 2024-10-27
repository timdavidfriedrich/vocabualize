import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
import 'package:vocabualize/src/common/data/mappers/language_mappers.dart';
import 'package:vocabualize/src/common/data/models/rdb_language.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/language_repository.dart';

final languageRepositoryProvider = Provider((ref) {
  return LanguageRepositoryImpl(
    remoteDatabaseDataSource: ref.watch(remoteDatabaseDataSourceProvider),
  );
});

class LanguageRepositoryImpl implements LanguageRepository {
  final RemoteDatabaseDataSource _remoteDatabaseDataSource;

  LanguageRepositoryImpl({
    required RemoteDatabaseDataSource remoteDatabaseDataSource,
  }) : _remoteDatabaseDataSource = remoteDatabaseDataSource;

  List<Language> _availableLanguages = [];

  Future<List<Language>> _getCachedLanguagesOrLoad() async {
    _availableLanguages = await _remoteDatabaseDataSource.getAvailabeLanguages().then((languages) {
      return languages.map((RdbLanguage language) => language.toLanguage()).toList();
    });
    return _availableLanguages;
  }

  @override
  Future<Language?> getLanguageById(String id) async {
    final languages = await _getCachedLanguagesOrLoad();
    return languages.cast<Language?>().firstWhere((language) {
      return language?.id == id;
    }, orElse: () => null);
  }

  @override
  Future<Language?> findLanguage({String? translatorId, String? speechToTextId, String? textToSpeechId}) async {
    final languages = await _getCachedLanguagesOrLoad();
    for (Language language in languages) {
      if (translatorId != null && language.translatorId.toLowerCase() != translatorId.toLowerCase()) continue;
      if (speechToTextId != null && language.translatorId.toLowerCase() != speechToTextId) continue;
      if (textToSpeechId != null && language.translatorId.toLowerCase() != textToSpeechId) continue;
      return language;
    }
    return null;
  }

  @override
  Future<List<Language>> getAvailableLanguages() async {
    return await _getCachedLanguagesOrLoad();
  }
}
