class EmailValidator {
  static bool validate(String email) {
    bool containesNoSpaces = !email.trim().contains(" ");
    bool containsSymbols = email.contains("@") || email.contains(".");
    bool hasCorrectBeginning = !email.startsWith("@") && !email.startsWith(".");
    bool hasCorrectEnding = !email.endsWith("@") && !email.endsWith(".");
    return containesNoSpaces && containsSymbols && hasCorrectBeginning && hasCorrectEnding;
  }
}
