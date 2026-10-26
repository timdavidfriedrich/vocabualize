abstract class ImageLabelingProvider {
  Future<LabeledImage> label({
    required List<int> image,
    required String language,
  });
}

class const LabeledImage({
  required final List<String> labels,
  required final int? inputTokens,
  required final int? outputTokens,
});

class const ImageLabelingFailure(
  final String reason,
) implements Exception {
  @override
  String toString() => "ImageLabelingFailure: $reason";
}
