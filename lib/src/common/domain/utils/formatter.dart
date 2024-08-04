class Formatter {
  static const String _specialCharacters = r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';
  static RegExp get specialCharacters => RegExp(_specialCharacters);

  static String normalize(String text) {
    return text.toLowerCase().trim().replaceAll(" ", "").replaceAll(specialCharacters, "");
  }
}
