import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:vocabualize/src/common/models/pexels_model.dart';
import 'package:vocabualize/constants/secrets/pexels_secrets.dart';

class PexelsService {
  Future<List<PexelsModel>> getImages(String search) async {
    List<PexelsModel> imageModelList = [];
    Client client = Client();
    Response response = await client.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$search&per_page=70"),
      headers: {HttpHeaders.authorizationHeader: PexelsSecrets.apiKey},
    );
    if (response.statusCode == 200) {
      dynamic decoded = jsonDecode(utf8.decode(response.bodyBytes))["photos"];
      for (dynamic imageModel in decoded) {
        imageModelList.add(PexelsModel.fromJson(imageModel));
      }
    }
    return imageModelList;
  }
}
