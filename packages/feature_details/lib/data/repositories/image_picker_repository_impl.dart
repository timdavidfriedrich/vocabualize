import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_details/data/data_sources/image_picker_data_source.dart';
import 'package:feature_details/domain/repositories/image_picker_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/image_pick_source.dart';

@Injectable(as: ImagePickerRepository)
class const ImagePickerRepositoryImpl(
  final ImagePickerDataSource _dataSource,
) implements ImagePickerRepository {
  @override
  Future<AppResult<String?>> pickImage(ImagePickSource source) async {
    try {
      return Success(await _dataSource.pickImage(source));
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<()>> discardImage(String path) async {
    try {
      await _dataSource.deleteImage(path);
      return const Success(());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }
}
