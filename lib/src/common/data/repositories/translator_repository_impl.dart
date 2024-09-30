import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/data_sources/free_translator_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/premium_translator_data_source.dart';
import 'package:vocabualize/src/common/domain/repositories/translator_repository.dart';

final translatorRepositoryProvider = Provider((ref) {
  return TranslatorRepositoryImpl(
    freeTranslatorDataSource: ref.watch(freeTranslatorDataSourceProvider),
    premiumTranslatorDataSource: ref.watch(premiumTranslatorDataSourceProvider),
  );
});

class TranslatorRepositoryImpl implements TranslatorRepository {
  final FreeTranslatorDataSource _freeTranslatorDataSource;
  final PremiumTranslatorDataSource _premiumTranslatorDataSource;

  const TranslatorRepositoryImpl({
    required FreeTranslatorDataSource freeTranslatorDataSource,
    required PremiumTranslatorDataSource premiumTranslatorDataSource,
  })  : _freeTranslatorDataSource = freeTranslatorDataSource,
        _premiumTranslatorDataSource = premiumTranslatorDataSource;

  @override
  Future<String> translate({
    required String source,
    required String sourceLanguageId,
    required String targetLanguageId,
    required bool usePremiumTranslator,
  }) async {
    if (usePremiumTranslator) {
      return await _premiumTranslatorDataSource.translate(
        source: source,
        sourceLang: sourceLanguageId,
        targetLang: targetLanguageId,
      );
    } else {
      return await _freeTranslatorDataSource.translate(
        source: source,
        sourceLang: sourceLanguageId,
        targetLang: targetLanguageId,
      );
    }
  }
}
