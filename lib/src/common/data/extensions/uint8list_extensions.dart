import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:vocabualize/constants/image_constants.dart';

extension Uint8ListExtensions on Uint8List {
  Future<Uint8List> compress() async {
    return await FlutterImageCompress.compressWithList(
      this,
      format: CompressFormat.jpeg,
      quality: ImageConstants.defaultCompressQuality,
    );
  }
}
