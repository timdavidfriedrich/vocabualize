import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/models/local_image_variant.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _variantFull = "full";
const _variantThumbnail = "thumbnail";

abstract class ImageTransferDataSource {
  Future<bool> upload(String imageId, LocalImageVariant variant, Uint8List bytes);

  Future<List<RemoteImageDownload>> createDownloads(
    List<String> imageIds,
    LocalImageVariant variant,
  );

  Future<Uint8List> download(String url);
}

@Injectable(as: ImageTransferDataSource)
class const ImageTransferDataSourceImpl(
  final Client _client,
  final Dio _dio,
) implements ImageTransferDataSource {
  @override
  Future<bool> upload(String imageId, LocalImageVariant variant, Uint8List bytes) async {
    final description = await _client.image.createUpload(
      imageId,
      _variantName(variant),
      bytes.length,
    );
    if (description == null) return false;
    final isUploaded = await FileUploader(description).uploadByteData(ByteData.sublistView(bytes));
    if (!isUploaded) return false;
    return _client.image.verifyUpload(imageId, _variantName(variant));
  }

  @override
  Future<List<RemoteImageDownload>> createDownloads(
    List<String> imageIds,
    LocalImageVariant variant,
  ) {
    return _client.image.createDownloads(imageIds, _variantName(variant));
  }

  @override
  Future<Uint8List> download(String url) async {
    final response = await _dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final data = response.data;
    if (data == null) throw StateError("The image download returned no data.");
    return Uint8List.fromList(data);
  }

  String _variantName(LocalImageVariant variant) => switch (variant) {
    LocalImageVariant.full => _variantFull,
    LocalImageVariant.thumbnail => _variantThumbnail,
  };
}
