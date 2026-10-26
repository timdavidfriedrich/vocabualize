import 'package:serverpod/serverpod.dart';

import '../composition.dart';
import '../domain/caller.dart';
import '../domain/languages.dart';
import '../domain/translation_service.dart';
import '../generated/protocol.dart';

const _invalidRequest = "invalidRequest";

final _translations = TranslationService(const Composition().translationProvider);

class TranslationEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<String> translate(
    Session session,
    String text,
    String sourceLanguage,
    String targetLanguage,
    RemoteInstallKey? installKey,
  ) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty ||
        sourceLanguage == targetLanguage ||
        !supportedLanguageCodes.contains(sourceLanguage) ||
        !supportedLanguageCodes.contains(targetLanguage)) {
      throw ServiceUnavailableException(reason: _invalidRequest);
    }
    return _translations.translate(
      session,
      await const CallerResolver().resolve(session, installKey),
      text: trimmed,
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
    );
  }
}
