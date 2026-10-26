import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../composition.dart';
import '../domain/ai_service.dart';
import '../generated/protocol.dart';

const _invalidRequest = "invalidRequest";

final _ai = AiService(
  const Composition().translationProvider,
  const Composition().stockImageProvider,
  const Composition().imageLabelingProvider,
);

class AiEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<String> translate(
    Session session,
    String text,
    String sourceLanguage,
    String targetLanguage,
  ) {
    final trimmed = text.trim();
    if (trimmed.isEmpty ||
        sourceLanguage == targetLanguage ||
        !supportedLanguageCodes.contains(sourceLanguage) ||
        !supportedLanguageCodes.contains(targetLanguage)) {
      throw AiUnavailableException(reason: _invalidRequest);
    }
    return _ai.translate(
      session,
      _owner(session),
      text: trimmed,
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
    );
  }

  Future<List<RemoteStockImage>> searchStockImages(
    Session session,
    String query,
    String language,
  ) {
    final trimmed = query.trim();
    if (trimmed.isEmpty || !supportedLanguageCodes.contains(language)) {
      throw AiUnavailableException(reason: _invalidRequest);
    }
    return _ai.searchStockImages(session, _owner(session), query: trimmed, language: language);
  }

  Future<List<String>> labelImage(
    Session session,
    ByteData image,
    String language,
  ) {
    if (image.lengthInBytes == 0 || !supportedLanguageCodes.contains(language)) {
      throw AiUnavailableException(reason: _invalidRequest);
    }
    return _ai.labelImage(
      session,
      _owner(session),
      image: image.buffer.asUint8List(image.offsetInBytes, image.lengthInBytes),
      language: language,
    );
  }

  UuidValue _owner(Session session) {
    try {
      return UuidValue.withValidation(session.authenticated?.userIdentifier ?? "");
    } on FormatException {
      throw AiUnavailableException(reason: _invalidRequest);
    }
  }
}
