import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/service_access_data_source.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class ImageLabelingRemoteDataSource {
  Future<List<RemoteImageLabel>> label({
    required Uint8List image,
    required String language,
  });
}

@Injectable(as: ImageLabelingRemoteDataSource)
class const ImageLabelingRemoteDataSourceImpl(
  final Client _client,
  final ServiceAccessDataSource _serviceAccess,
) implements ImageLabelingRemoteDataSource {
  @override
  Future<List<RemoteImageLabel>> label({
    required Uint8List image,
    required String language,
  }) => _serviceAccess.run(
    (installKey) => _client.imageLabeling.label(ByteData.sublistView(image), language, installKey),
  );
}
