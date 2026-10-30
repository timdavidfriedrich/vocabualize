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
  Future<List<String>> translate({
    required List<String> texts,
    required String sourceLanguage,
    required String targetLanguage,
    required String? context,
  }) async {
    final response = await _client.post(
      Uri.https(_apiKey.endsWith(_freeKeySuffix) ? _freeHost : _proHost, _translatePath),
      headers: {
        HttpHeaders.authorizationHeader: "DeepL-Auth-Key $_apiKey",
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      },
      body: jsonEncode({
        "text": texts,
        "context": ?context,
        "source_lang": ?supportedLanguages[sourceLanguage]?.deeplSource,
        "target_lang": ?supportedLanguages[targetLanguage]?.deeplTarget,
      }),
    );
    if (response.statusCode != HttpStatus.ok) {
      throw TranslationFailure("DeepL answered ${response.statusCode}");
    }
    final translations = switch (jsonDecode(utf8.decode(response.bodyBytes))) {
      {"translations": final List<dynamic> entries} => [
        for (final entry in entries)
          if (entry case {"text": final String translation}) translation,
      ],
      _ => const <String>[],
    };
    if (translations.length != texts.length) {
      throw const TranslationFailure("DeepL answered without all translations");
    }
    return translations;
  }
}
