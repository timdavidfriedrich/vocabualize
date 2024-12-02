import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:vocabualize/constants/image_constants.dart';
import 'package:vocabualize/src/common/data/mappers/vocabulary_image_mappers.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary_image.dart';
import 'package:vocabualize/constants/secrets/pexels_secrets.dart';
import 'package:vocabualize/src/common/data/utils/uri_parser.dart';

final stockImageDataSourceProvider = Provider((ref) => StockImageDataSource());

class StockImageDataSource {
  final queryParameterName = "query";
  final perPageParameterName = "per_page";
  final photosFieldName = "photos";

  Future<List<RdbStockImage>> getImages(String search) async {
    Client client = Client();
    Response response = await client.get(
      UriParser.parseWithParameters(
        uri: ImageConstants.stockImageBaseSearchUrl,
        parameters: {
          queryParameterName: search,
          perPageParameterName: ImageConstants.stockImagePageSize.toString(),
        },
      ),
      headers: {
        HttpHeaders.authorizationHeader: PexelsSecrets.apiKey,
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> imageModels =
          jsonDecode(utf8.decode(response.bodyBytes))[photosFieldName];
      return imageModels
          .cast<Map<String, dynamic>>()
          .map((model) => model.toRdbStockImage())
          .toList();
    }
    return [];
  }
}
