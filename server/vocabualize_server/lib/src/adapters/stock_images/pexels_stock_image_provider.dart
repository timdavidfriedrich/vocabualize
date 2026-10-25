import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../generated/protocol.dart';
import 'stock_image_provider.dart';

const _host = "api.pexels.com";
const _searchPath = "/v1/search";
const _pageSize = 70;
const _locales = {
  "en": "en-US",
  "de": "de-DE",
  "es": "es-ES",
  "fr": "fr-FR",
  "pl": "pl-PL",
};

class const PexelsStockImageProvider(
  final http.Client _client,
  final String _apiKey,
) implements StockImageProvider {
  @override
  Future<List<RemoteStockImage>> search({
    required String query,
    required String language,
  }) async {
    final response = await _client.get(
      Uri.https(_host, _searchPath, {
        "query": query,
        "per_page": "$_pageSize",
        "locale": ?_locales[language],
      }),
      headers: {HttpHeaders.authorizationHeader: _apiKey},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw StockImageFailure("Pexels answered ${response.statusCode}");
    }
    return switch (jsonDecode(utf8.decode(response.bodyBytes))) {
      {"photos": final List<dynamic> photos} => [
        for (final photo in photos) ?_toStockImage(photo),
      ],
      _ => throw const StockImageFailure("Pexels answered without photos"),
    };
  }

  RemoteStockImage? _toStockImage(Object? photo) => switch (photo) {
    {
      "id": final int id,
      "src": {"large": final String url, "medium": final String thumbUrl},
    } =>
      RemoteStockImage(
        id: "$id",
        url: url,
        thumbUrl: thumbUrl,
        photographer: switch (photo) {
          {"photographer": final String name} => name,
          _ => null,
        },
        photographerUrl: switch (photo) {
          {"photographer_url": final String link} => link,
          _ => null,
        },
      ),
    _ => null,
  };
}
