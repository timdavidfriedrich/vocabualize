import 'image_labeling_provider.dart';

const _labels = ["echo"];

class const EchoImageLabelingProvider() implements ImageLabelingProvider {
  @override
  Future<LabeledImage> label({
    required List<int> image,
    required String language,
  }) async => const LabeledImage(labels: _labels, inputTokens: null, outputTokens: null);
}
