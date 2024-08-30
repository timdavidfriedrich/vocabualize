import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/data/data_sources/draft_image_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/stock_image_data_source.dart';
import 'package:vocabualize/src/common/data/mappers/vocabulary_image_mappers.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final _draftImageDataSource = sl.get<DraftImageDataSource>();
  final _stockImageDataSource = sl.get<StockImageDataSource>();

  @override
  Future<List<StockImage>> getStockImages(String search) {
    return _stockImageDataSource.getImages(search).then((images) {
      return images.map((image) => image.toStockImage()).toList();
    });
  }

  @override
  Future<bool> uploadImage(VocabularyImage image) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }

  @override
  Future<DraftImage?> getImageFromCameraOrFiles() {
    return _draftImageDataSource.getImageFromCameraOrFiles().then((image) {
      return image?.toTemporaryImage();
    });
  }

  /*
  Future<void> _uploadImage() async {
    if (_cameraImageFile == null) return;
    Uint8List imageData = await _cameraImageFile!.readAsBytes();
    Uint8List compressImageData = await FlutterImageCompress.compressWithList(
      imageData,
      quality: 70,
      minHeight: 800,
      minWidth: 800,
    );
    await RemoteImageStorageDataSource.instance.uploadVocabularyImage(vocabulary: vocabulary, imageData: compressImageData);
  }
  */
}
