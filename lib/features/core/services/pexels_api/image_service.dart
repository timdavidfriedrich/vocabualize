import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:vocabualize/features/core/services/pexels_api/image_model.dart';
import 'package:vocabualize/features/core/services/pexels_api/pexels_key.dart';

class ImageService {
  Future<List<ImageModel>> getImages(String search) async {
    List<ImageModel> imageModelList = [];
    Client client = Client();
    Response response = await client.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$search&per_page=7"),
      headers: {HttpHeaders.authorizationHeader: pexelsKey},
    );
    if (response.statusCode == 200) {
      dynamic decoded = json.decode(response.body)["photos"];
      for (dynamic imageModel in decoded) {
        imageModelList.add(ImageModel.fromJson(imageModel));
      }
    }
    return imageModelList;
  }
}
