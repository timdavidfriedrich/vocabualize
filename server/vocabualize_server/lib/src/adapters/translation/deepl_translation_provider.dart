import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../domain/languages.dart';
import 'translation_provider.dart';

const _freeHost = "api-free.deepl.com";
const _proHost = "api.deepl.com";
const _freeKeySuffix = ":fx";
const _translatePath = "/v2/translate";

class const DeeplTranslationProvider(
  final http.Client _client,
  final String _apiKey,
) implements TranslationProvider {
  @override
  Future<String> translate({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    final response = await _client.post(
      Uri.https(_apiKey.endsWith(_freeKeySuffix) ? _freeHost : _proHost, _translatePath),
      headers: {
        HttpHeaders.authorizationHeader: "DeepL-Auth-Key $_apiKey",
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      },
      body: jsonEncode({
        "text": [text],
        "source_lang": ?supportedLanguages[sourceLanguage]?.deeplSource,
        "target_lang": ?supportedLanguages[targetLanguage]?.deeplTarget,
      }),
    );
    if (response.statusCode != HttpStatus.ok) {
      throw TranslationFailure("DeepL answered ${response.statusCode}");
    }
    return switch (jsonDecode(utf8.decode(response.bodyBytes))) {
      {"translations": [{"text": final String translation}, ...]} => translation,
      _ => throw const TranslationFailure("DeepL answered without a translation"),
    };
  }
}
