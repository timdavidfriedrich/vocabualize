import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/image_picker_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/mappers/image_pick_source_mappers.dart';
import 'package:shared/domain/entities/image_pick_source.dart';
import 'package:shared/domain/repositories/image_picker_repository.dart';

const _cameraAccessDenied = "camera_access_denied";

@Injectable(as: ImagePickerRepository)
class const ImagePickerRepositoryImpl(
  final ImagePickerDataSource _dataSource,
) implements ImagePickerRepository {
  @override
  Future<AppResult<String?>> pickImage(ImagePickSource source) async {
    try {
      return Success(await _dataSource.pickImage(source.toImageSource()));
    } on PlatformException catch (exception) {
      return Failure(switch (exception.code) {
        _cameraAccessDenied => const CameraPermissionError(),
        _ => exception.toAppError(),
      });
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }
}
