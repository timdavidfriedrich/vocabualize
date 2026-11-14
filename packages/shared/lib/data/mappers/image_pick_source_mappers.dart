import 'package:image_picker/image_picker.dart';
import 'package:shared/domain/entities/image_pick_source.dart';

extension ImagePickSourceMappers on ImagePickSource {
  ImageSource toImageSource() => switch (this) {
    ImagePickSource.gallery => ImageSource.gallery,
    ImagePickSource.camera => ImageSource.camera,
  };
}
