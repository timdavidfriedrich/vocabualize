import 'package:shared/domain/entities/image_label.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

extension RemoteImageLabelMappers on RemoteImageLabel {
  ImageLabel toImageLabel() {
    return ImageLabel(
      text: term,
      context: context,
    );
  }
}
