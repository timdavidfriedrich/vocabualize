/// Documentation: https://www.deepl.com/de/docs-api/translate-text/translate-text/
class DeepLResponse {
  final String translation;
  String? sourceLang;

  DeepLResponse({
    required this.translation,
    this.sourceLang,
  });
}
