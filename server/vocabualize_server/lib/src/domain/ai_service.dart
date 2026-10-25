import 'package:serverpod/serverpod.dart';

import '../adapters/stock_images/stock_image_provider.dart';
import '../adapters/translation/translation_provider.dart';
import '../generated/protocol.dart';
import 'ai_quota.dart';
import 'config_source.dart';

const supportedLanguageCodes = {"en", "de", "es", "fr", "pl"};

const _disabled = "disabled";
const _invalidRequest = "invalidRequest";
const _providerFailed = "providerFailed";
// * the app's Serverpod client gives up on a call after 20 s, so a provider call can never usefully run longer, and a reservation older than this can't still be in flight
const _providerTimeout = Duration(seconds: 20);

class const AiService(
  final TranslationProvider Function() _translationProvider,
  final StockImageProvider Function() _stockImageProvider,
) {
  Future<String> translate(
    Session session,
    UuidValue ownerId, {
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  }) {
    final config = const ConfigSource().read().ai;
    if (text.length > config.maxTextLength) {
      throw AiUnavailableException(reason: _invalidRequest);
    }
    return _run(
      session,
      ownerId,
      kind: aiTranslation,
      limit: config.translationsPerDay,
      isEnabled: config.enabled,
      request: () => _translationProvider().translate(
        text: text,
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      ),
    );
  }

  Future<List<RemoteStockImage>> searchStockImages(
    Session session,
    UuidValue ownerId, {
    required String query,
    required String language,
  }) {
    final config = const ConfigSource().read().ai;
    if (query.length > config.maxTextLength) {
      throw AiUnavailableException(reason: _invalidRequest);
    }
    return _run(
      session,
      ownerId,
      kind: aiStockSearch,
      limit: config.stockSearchesPerDay,
      isEnabled: config.enabled,
      request: () => _stockImageProvider().search(query: query, language: language),
    );
  }

  Future<T> _run<T>(
    Session session,
    UuidValue ownerId, {
    required String kind,
    required int limit,
    required bool isEnabled,
    required Future<T> Function() request,
  }) async {
    if (!isEnabled) throw AiUnavailableException(reason: _disabled);
    final usageId = await const AiQuota().reserve(
      session,
      ownerId,
      kind: kind,
      limit: limit,
      inFlightTimeout: _providerTimeout,
    );
    if (usageId == null) throw AiQuotaExceededException(kind: kind, limit: limit);
    final T result;
    try {
      result = await request().timeout(_providerTimeout);
    } on Object catch (error) {
      await const AiQuota().release(session, usageId);
      session.log("AI $kind failed: $error", level: LogLevel.warning);
      throw AiUnavailableException(reason: _providerFailed);
    }
    await const AiQuota().complete(session, usageId);
    return result;
  }
}
