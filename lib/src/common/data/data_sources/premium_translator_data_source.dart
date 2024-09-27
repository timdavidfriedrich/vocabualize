import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:log/log.dart';
import 'package:vocabualize/constants/secrets/deepl_secrets.dart';
import 'package:vocabualize/src/common/data/models/deepl_request.dart';
import 'package:vocabualize/src/common/data/models/deepl_response.dart';

final premiumTranslatorDataSourceProvider = Provider((ref) => PremiumTranslatorDataSource());

class PremiumTranslatorDataSource {
  Future<String> translate({
    required String source,
    required String targetLang,
    String? sourceLang,
  }) async {
    final deepLRequest = DeepLRequest(
      text: source,
      sourceLang: sourceLang,
      targetLang: targetLang,
    );
    DeepLResponse? deepLResponse;

    String url = "https://api-free.deepl.com/v2/translate";

    Map<String, String>? headers = {
      HttpHeaders.authorizationHeader: "DeepL-Auth-Key ${DeepLSecrets.apiKey}",
      HttpHeaders.acceptCharsetHeader: "UTF-8",
    };

    Map<String, String>? body = {
      'text': [deepLRequest.text].toString(),
      'target_lang': deepLRequest.targetLang,
    };

    if (deepLRequest.sourceLang != null) {
      body.addAll({'source_lang': deepLRequest.sourceLang!});
    }
    if (deepLRequest.splitSentences != null) {
      body.addAll({'split_sentences': deepLRequest.splitSentences!});
    }
    if (deepLRequest.preserveFormatting != null) {
      body.addAll({'preserve_formatting': deepLRequest.preserveFormatting!});
    }
    if (deepLRequest.formality != null) {
      body.addAll({'formality': deepLRequest.formality!});
    }
    if (deepLRequest.glossaryId != null) {
      body.addAll({'glossary_id': deepLRequest.glossaryId!});
    }
    if (deepLRequest.tagHandling != null) {
      body.addAll({'tag_handling': deepLRequest.tagHandling!});
    }
    if (deepLRequest.nonSplittingTags != null) {
      body.addAll({'non_splitting_tags': deepLRequest.nonSplittingTags!});
    }
    if (deepLRequest.outlineDetection != null) {
      body.addAll({'outline_detection': deepLRequest.outlineDetection!});
    }
    if (deepLRequest.splittingTags != null) {
      body.addAll({'splitting_tags': deepLRequest.splittingTags!});
    }
    if (deepLRequest.ignoreTags != null) {
      body.addAll({'ignore_tags': deepLRequest.ignoreTags!});
    }

    Client client = Client();
    Response response = await client.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      dynamic decoded = jsonDecode(utf8.decode(response.bodyBytes))["translations"][0];
      String filteredText = decoded["text"].toString().replaceAll("[", "").replaceAll("]", "");
      deepLResponse = DeepLResponse(translation: filteredText);
    } else {
      Log.error("DeepL API request failed: ${response.statusCode} ${response.reasonPhrase}");
    }

    return deepLResponse?.translation ?? "";
  }

  final Map<String, String> translatorLanguages = {
    "BG": "Bulgarian",
    "CS": "Czech",
    "DA": "Danish",
    "DE": "German",
    "EL": "Greek",
    "EN": "English (please use EN-GB or EN-US)",
    "EN-GB": "English (British)",
    "EN-US": "English (American)",
    "ES": "Spanish",
    "ET": "Estonian",
    "FI": "Finnish",
    "FR": "French",
    "HU": "Hungarian",
    "ID": "Indonesian",
    "IT": "Italian",
    "JA": "Japanese",
    "KO": "Korean",
    "LT": "Lithuanian",
    "LV": "Latvian",
    "NB": "Norwegian (Bokmål)",
    "NL": "Dutch",
    "PL": "Polish",
    "PT": "Portuguese (please use PT-BR or PT-PT)",
    "PT-BR": "Portuguese (Brazilian)",
    "PT-PT": "Portuguese (all, excluding Brazilian)",
    "RO": "Romanian",
    "RU": "Russian",
    "SK": "Slovak",
    "SL": "Slovenian",
    "SV": "Swedish",
    "TR": "Turkish",
    "UK": "Ukrainian",
    "ZH": "Chinese (simplified)"
  };
}
