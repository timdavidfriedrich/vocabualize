import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:vocabualize/constants/image_constants.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary_image.dart';
import 'package:vocabualize/constants/secrets/pexels_secrets.dart';
import 'package:vocabualize/src/common/data/utils/uri_parser.dart';

class StockImageDataSource {
  final queryParameterName = "query";
  final perPageParameterName = "per_page";
  final photosFieldName = "photos";

  Future<List<RdbVocabualaryImage>> getImages(String search) async {
    List<RdbVocabualaryImage> imageModelList = [];
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
      final decoded = jsonDecode(utf8.decode(response.bodyBytes))[photosFieldName];
      for (final imageModel in decoded) {
        imageModelList.add(
          RdbVocabualaryImage.fromRecord(
            imageModel,
            type: RdbVocabularyImageType.stock,
          ),
        );
      }
    }
    return imageModelList;
  }
}
