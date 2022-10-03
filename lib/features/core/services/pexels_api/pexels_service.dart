import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:vocabualize/features/core/services/pexels_api/pexels_model.dart';
import 'package:vocabualize/features/core/services/pexels_api/pexels_key.dart';

class PexelsService {
  Future<List<PexelsModel>> getImages(String search) async {
    List<PexelsModel> imageModelList = [];
    Client client = Client();
    Response response = await client.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$search&per_page=70"),
      headers: {HttpHeaders.authorizationHeader: pexelsKey},
    );
    if (response.statusCode == 200) {
      dynamic decoded = json.decode(response.body)["photos"];
      for (dynamic imageModel in decoded) {
        imageModelList.add(PexelsModel.fromJson(imageModel));
      }
    }
    return imageModelList;
  }
}
