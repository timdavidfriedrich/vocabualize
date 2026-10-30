class const SupportedLanguage({
  required final String deeplSource,
  required final String deeplTarget,
  required final String name,
  required final String pexelsLocale,
});

const supportedLanguages = {
  "en-GB": SupportedLanguage(
    deeplSource: "EN",
    deeplTarget: "EN-GB",
    name: "British English",
    pexelsLocale: "en-US",
  ),
  "en-US": SupportedLanguage(
    deeplSource: "EN",
    deeplTarget: "EN-US",
    name: "American English",
    pexelsLocale: "en-US",
  ),
  "es-ES": SupportedLanguage(
    deeplSource: "ES",
    deeplTarget: "ES-ES",
    name: "European Spanish",
    pexelsLocale: "es-ES",
  ),
  "es-419": SupportedLanguage(
    deeplSource: "ES",
    deeplTarget: "ES-419",
    name: "Latin American Spanish",
    pexelsLocale: "es-ES",
  ),
  "fr-FR": SupportedLanguage(
    deeplSource: "FR",
    deeplTarget: "FR-FR",
    name: "French",
    pexelsLocale: "fr-FR",
  ),
  "fr-CA": SupportedLanguage(
    deeplSource: "FR",
    deeplTarget: "FR-CA",
    name: "Canadian French",
    pexelsLocale: "fr-FR",
  ),
  "de-DE": SupportedLanguage(
    deeplSource: "DE",
    deeplTarget: "DE-DE",
    name: "German",
    pexelsLocale: "de-DE",
  ),
  "de-CH": SupportedLanguage(
    deeplSource: "DE",
    deeplTarget: "DE-CH",
    name: "Swiss Standard German",
    pexelsLocale: "de-DE",
  ),
  "pl": SupportedLanguage(
    deeplSource: "PL",
    deeplTarget: "PL",
    name: "Polish",
    pexelsLocale: "pl-PL",
  ),
  "it": SupportedLanguage(
    deeplSource: "IT",
    deeplTarget: "IT",
    name: "Italian",
    pexelsLocale: "it-IT",
  ),
  "el": SupportedLanguage(
    deeplSource: "EL",
    deeplTarget: "EL",
    name: "Greek",
    pexelsLocale: "el-GR",
  ),
  "ro": SupportedLanguage(
    deeplSource: "RO",
    deeplTarget: "RO",
    name: "Romanian",
    pexelsLocale: "ro-RO",
  ),
};

bool isTranslatablePair(String source, String target) {
  final from = supportedLanguages[source];
  final to = supportedLanguages[target];
  return from != null && to != null && from.deeplSource != to.deeplSource;
}
