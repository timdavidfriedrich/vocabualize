import 'package:serverpod/serverpod.dart';

import '../adapters/translation/translation_provider.dart';
import '../generated/protocol.dart';
import 'caller.dart';
import 'config_source.dart';
import 'metered_call.dart';
import 'usage_quota.dart';

const _invalidRequest = "invalidRequest";
const _maxContextLength = 200;
const maxTranslationBatchSize = 50;

class const TranslationService(
  final TranslationProvider Function() _provider,
) {
  Future<String> translate(
    Session session,
    Caller caller, {
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
    required String? context,
  }) async {
    final cleanContext = context?.trim();
    if (cleanContext != null && cleanContext.length > _maxContextLength) {
      throw ServiceUnavailableException(reason: _invalidRequest);
    }
    final translations = await _translate(
      session,
      caller,
      texts: [text],
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
      context: cleanContext == null || cleanContext.isEmpty ? null : cleanContext,
    );
    return translations.single;
  }

  Future<List<String>> translateBatch(
    Session session,
    Caller caller, {
    required List<String> texts,
    required String sourceLanguage,
    required String targetLanguage,
  }) {
    if (texts.isEmpty || texts.length > maxTranslationBatchSize) {
      throw ServiceUnavailableException(reason: _invalidRequest);
    }
    return _translate(
      session,
      caller,
      texts: texts,
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
      context: null,
    );
  }

  Future<List<String>> _translate(
    Session session,
    Caller caller, {
    required List<String> texts,
    required String sourceLanguage,
    required String targetLanguage,
    required String? context,
  }) {
    final config = const ConfigSource().read().translation;
    if (texts.any((text) => text.length > config.maxTextLength)) {
      throw ServiceUnavailableException(reason: _invalidRequest);
    }
    return const MeteredCall().run(
      session,
      caller,
      kind: UsageKind.translation,
      isEnabled: config.enabled,
      perDay: config.perDay,
      units: texts.length,
      request: (grantedUnits) => _provider().translate(
        texts: texts.take(grantedUnits).toList(),
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
        context: context,
      ),
    );
  }
}
