import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:log/log.dart';
import 'package:vocabualize/constants/secrets/deepl_secrets.dart';
import 'package:vocabualize/src/common/models/deepl_api/deepl_request.dart';
import 'package:vocabualize/src/common/models/deepl_api/deepl_response.dart';

class DeepLService {
  Future<DeepLResponse?> translate(DeepLRequest deepLRequest) async {
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

    if (deepLRequest.sourceLang != null) body.addAll({'source_lang': deepLRequest.sourceLang!});
    if (deepLRequest.splitSentences != null) body.addAll({'split_sentences': deepLRequest.splitSentences!});
    if (deepLRequest.preserveFormatting != null) body.addAll({'preserve_formatting': deepLRequest.preserveFormatting!});
    if (deepLRequest.formality != null) body.addAll({'formality': deepLRequest.formality!});
    if (deepLRequest.glossaryId != null) body.addAll({'glossary_id': deepLRequest.glossaryId!});
    if (deepLRequest.tagHandling != null) body.addAll({'tag_handling': deepLRequest.tagHandling!});
    if (deepLRequest.nonSplittingTags != null) body.addAll({'non_splitting_tags': deepLRequest.nonSplittingTags!});
    if (deepLRequest.outlineDetection != null) body.addAll({'outline_detection': deepLRequest.outlineDetection!});
    if (deepLRequest.splittingTags != null) body.addAll({'splitting_tags': deepLRequest.splittingTags!});
    if (deepLRequest.ignoreTags != null) body.addAll({'ignore_tags': deepLRequest.ignoreTags!});

    Client client = Client();
    Response response = await client.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      dynamic decoded = jsonDecode(utf8.decode(response.bodyBytes))["translations"][0];
      String filteredText = decoded["text"].toString().replaceAll("[", "").replaceAll("]", "");
      deepLResponse = DeepLResponse(translation: filteredText);
    } else {
      Log.error("DeepL API request failed: ${response.statusCode} ${response.reasonPhrase}");
    }

    return deepLResponse;
  }
}
