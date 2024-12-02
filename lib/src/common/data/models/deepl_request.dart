/// Documentation: https://www.deepl.com/de/docs-api/translate-text/translate-text/
class DeepLRequest {
  final String text; // Should actually be a list of strings, but only one string is necessary
  String targetLang;
  String? sourceLang;
  String? splitSentences;
  String? preserveFormatting;
  String? formality;
  String? glossaryId;
  String? tagHandling;
  String? nonSplittingTags;
  String? outlineDetection;
  String? splittingTags;
  String? ignoreTags;

  DeepLRequest({
    required this.text,
    required this.targetLang,
    this.sourceLang,
    this.splitSentences,
    this.preserveFormatting,
    this.formality,
    this.glossaryId,
    this.tagHandling,
    this.nonSplittingTags,
    this.outlineDetection,
    this.splittingTags,
    this.ignoreTags,
  }) {
    targetLang = targetLang.toUpperCase();
    sourceLang = sourceLang?.toUpperCase();
  }
}
