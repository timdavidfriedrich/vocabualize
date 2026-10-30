import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../domain/languages.dart';
import 'image_labeling_provider.dart';

const _host = "generativelanguage.googleapis.com";
const _modelsPath = "/v1beta/models";
const _generateContentMethod = "generateContent";
const _apiKeyHeader = "x-goog-api-key";
const _imageMimeType = "image/jpeg";
const _maxOutputTokens = 512;
const _maxLabels = 5;
const _mediaResolution = "MEDIA_RESOLUTION_LOW";
const _thinkingLevel = "minimal";
const _labelsField = "labels";
const _termField = "term";
const _confidenceField = "confidence";

String _prompt(String languageName) =>
    """
Identify objects in the image.
Return up to $_maxLabels short labels with confidence scores.
Prefer simple and generic terms (e.g., "die Flasche" instead of "die Wasserflasche").
Use provided language ($languageName).
Words must have correct definite articles (e.g., "the car", "das Auto").
Prioritize accuracy.
""";

class const GeminiImageLabelingProvider(
  final http.Client _client,
  final String _apiKey,
  final String _model,
) implements ImageLabelingProvider {
  @override
  Future<LabeledImage> label({
    required List<int> image,
    required String language,
  }) async {
    final response = await _client.post(
      Uri.https(_host, "$_modelsPath/$_model:$_generateContentMethod"),
      headers: {
        _apiKeyHeader: _apiKey,
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      },
      body: jsonEncode(_requestBody(image, supportedLanguages[language]?.name ?? language)),
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ImageLabelingFailure("Gemini answered ${response.statusCode}");
    }
    final body = jsonDecode(utf8.decode(response.bodyBytes));
    return LabeledImage(
      labels: _labelsOf(body),
      inputTokens: _tokenCount(body, "promptTokenCount"),
      outputTokens: _tokenCount(body, "candidatesTokenCount"),
    );
  }

  Map<String, Object> _requestBody(List<int> image, String languageName) => {
    "contents": [
      {
        "parts": [
          {
            "inlineData": {"mimeType": _imageMimeType, "data": base64Encode(image)},
          },
          {"text": _prompt(languageName)},
        ],
      },
    ],
    "generationConfig": {
      "maxOutputTokens": _maxOutputTokens,
      "mediaResolution": _mediaResolution,
      "thinkingConfig": {"thinkingLevel": _thinkingLevel},
      "responseMimeType": ContentType.json.mimeType,
      "responseSchema": {
        "type": "object",
        "properties": {
          _labelsField: {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                _termField: {"type": "string"},
                _confidenceField: {"type": "number"},
              },
              "required": [_termField, _confidenceField],
            },
          },
        },
        "required": [_labelsField],
      },
    },
  };

  List<String> _labelsOf(Object? body) => switch (body) {
    {
      "candidates": [
        {
          "content": {
            "parts": [{"text": final String text}, ...],
          },
        },
        ...,
      ],
    } =>
      _parseLabels(text),
    _ => const [],
  };

  List<String> _parseLabels(String text) {
    final Object? parsed;
    try {
      parsed = jsonDecode(text);
    } on FormatException {
      throw const ImageLabelingFailure("Gemini answered with unreadable labels");
    }
    final scored = switch (parsed) {
      {_labelsField: final List<dynamic> labels} => [
        for (final label in labels)
          if (label
              case {
                _termField: final String term,
                _confidenceField: final num confidence,
              }
              when term.trim().isNotEmpty)
            (term: term.trim(), confidence: confidence),
      ],
      _ => throw const ImageLabelingFailure("Gemini answered without labels"),
    }..sort((first, second) => second.confidence.compareTo(first.confidence));
    final seen = <String>{};
    return [
      for (final label in scored)
        if (seen.add(label.term.toLowerCase())) label.term,
    ].take(_maxLabels).toList();
  }

  int? _tokenCount(Object? body, String field) => switch (body) {
    {"usageMetadata": final Map<String, dynamic> usage} => switch (usage[field]) {
      final int count => count,
      _ => null,
    },
    _ => null,
  };
}
