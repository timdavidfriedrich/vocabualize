class Formatter {
  static const String _specialCharacters = r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';
  static RegExp get specialCharacters => RegExp(_specialCharacters);

  static String normalize(String text) {
    return text.toLowerCase().trim().replaceAll(" ", "").replaceAll(specialCharacters, "");
  }

  static String filterOutArticles(
    String source, {
    List<String> articles = const ["the", "a", "an"],
  }) {
    for (String article in articles) {
      if (source.toString().startsWith("$article ")) {
        source = source.toString().replaceFirst("$article ", "");
      }
    }
    return source;
  }
}
