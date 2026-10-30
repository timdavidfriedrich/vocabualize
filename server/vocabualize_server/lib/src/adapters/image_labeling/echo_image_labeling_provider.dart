import '../../generated/protocol.dart';
import 'image_labeling_provider.dart';

const _echo = "echo";

class const EchoImageLabelingProvider() implements ImageLabelingProvider {
  @override
  Future<LabeledImage> label({
    required List<int> image,
    required String language,
  }) async => LabeledImage(
    labels: [RemoteImageLabel(term: _echo, context: _echo)],
    inputTokens: null,
    outputTokens: null,
  );
}
