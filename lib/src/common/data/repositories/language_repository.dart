import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/data/data_sources/speech_to_text_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/text_to_speech_data_source.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

// TODO ARCHITECURAL: It's a repo, but some things should be moved to their data sources
class LanguageRepository {
  static Future<Language?> findLanguage({String? translatorId, String? speechToTextId, String? textToSpeechId}) async {
    Language? result;
    List<Language> languages = await getLangauges();
    for (Language language in languages) {
      if (translatorId != null && language.translatorId.toLowerCase() != translatorId.toLowerCase()) continue;
      if (speechToTextId != null && language.translatorId.toLowerCase() != speechToTextId) continue;
      if (textToSpeechId != null && language.translatorId.toLowerCase() != textToSpeechId) continue;
      result = language;
    }
    return result;
  }

  static Future<List<Language>> getLangauges() async {
    List<Language> result = [];
    List<String> translatorIds = Provider.of<SettingsProvider>(Global.context, listen: false).useDeepL
        ? await getDeepLTranslatorIds()
        : await getGoogleTranslatorIds();
    Map<String, String> speechToTextMap = await getSpeechToTextMap();
    List<String> textToSpeechIds = await getTextToSpeechIds();
    for (String translatorId in translatorIds) {
      String speechToTextId = speechToTextMap.keys.toList().firstWhere(
            (id) => id.toLowerCase().startsWith(translatorId.toLowerCase()),
            orElse: () => "",
          );
      String textToSpeechId = textToSpeechIds.firstWhere(
        (id) => id.toLowerCase().startsWith(translatorId.toLowerCase()),
        orElse: () => "",
      );
      if (speechToTextId == "" || textToSpeechId == "") continue;
      result.add(
        Language(
            name: (speechToTextMap[speechToTextId] ?? "Unknown").split(" (").first,
            translatorId: translatorId,
            speechToTextId: speechToTextId,
            textToSpeechId: textToSpeechId),
      );
    }
    result.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return result;
  }

  static Future<Map<String, String>> getSpeechToTextMap() async {
    final SpeechToTextDataSource speech = SpeechToTextDataSource.instance;
    List<LocaleName> locales = await speech.getLocales();

    Map<String, String> result = {};
    for (LocaleName locale in locales) {
      result[locale.localeId] = locale.name;
    }
    return result;
  }

  static Future<List<String>> getTextToSpeechIds() async {
    final TextToSpeechDataSource tts = TextToSpeechDataSource.instance;
    final result = await tts.getLanguages();
    return result;
  }

  static Future<List<String>> getGoogleTranslatorIds() async {
    List<String> result = [];
    for (String id in _googleTranslatorLanguages.keys) {
      result.add(id);
    }
    return result;
  }

  static Future<List<String>> getDeepLTranslatorIds() async {
    List<String> result = [];
    for (String id in _deepLTranslatorLanguages.keys) {
      result.add(id);
    }
    return result;
  }

  static const Map<String, String> _googleTranslatorLanguages = {
    'auto': 'Automatic',
    'af': 'Afrikaans',
    'sq': 'Albanian',
    'am': 'Amharic',
    'ar': 'Arabic',
    'hy': 'Armenian',
    'az': 'Azerbaijani',
    'eu': 'Basque',
    'be': 'Belarusian',
    'bn': 'Bengali',
    'bs': 'Bosnian',
    'bg': 'Bulgarian',
    'ca': 'Catalan',
    'ceb': 'Cebuano',
    'ny': 'Chichewa',
    'zh-cn': 'Chinese Simplified',
    'zh-tw': 'Chinese Traditional',
    'co': 'Corsican',
    'hr': 'Croatian',
    'cs': 'Czech',
    'da': 'Danish',
    'nl': 'Dutch',
    'en': 'English',
    'eo': 'Esperanto',
    'et': 'Estonian',
    'tl': 'Filipino',
    'fi': 'Finnish',
    'fr': 'French',
    'fy': 'Frisian',
    'gl': 'Galician',
    'ka': 'Georgian',
    'de': 'German',
    'el': 'Greek',
    'gu': 'Gujarati',
    'ht': 'Haitian Creole',
    'ha': 'Hausa',
    'haw': 'Hawaiian',
    'iw': 'Hebrew',
    'hi': 'Hindi',
    'hmn': 'Hmong',
    'hu': 'Hungarian',
    'is': 'Icelandic',
    'ig': 'Igbo',
    'id': 'Indonesian',
    'ga': 'Irish',
    'it': 'Italian',
    'ja': 'Japanese',
    'jw': 'Javanese',
    'kn': 'Kannada',
    'kk': 'Kazakh',
    'km': 'Khmer',
    'ko': 'Korean',
    'ku': 'Kurdish (Kurmanji)',
    'ky': 'Kyrgyz',
    'lo': 'Lao',
    'la': 'Latin',
    'lv': 'Latvian',
    'lt': 'Lithuanian',
    'lb': 'Luxembourgish',
    'mk': 'Macedonian',
    'mg': 'Malagasy',
    'ms': 'Malay',
    'ml': 'Malayalam',
    'mt': 'Maltese',
    'mi': 'Maori',
    'mr': 'Marathi',
    'mn': 'Mongolian',
    'my': 'Myanmar (Burmese)',
    'ne': 'Nepali',
    'no': 'Norwegian',
    'ps': 'Pashto',
    'fa': 'Persian',
    'pl': 'Polish',
    'pt': 'Portuguese',
    'pa': 'Punjabi',
    'ro': 'Romanian',
    'ru': 'Russian',
    'sm': 'Samoan',
    'gd': 'Scots Gaelic',
    'sr': 'Serbian',
    'st': 'Sesotho',
    'sn': 'Shona',
    'sd': 'Sindhi',
    'si': 'Sinhala',
    'sk': 'Slovak',
    'sl': 'Slovenian',
    'so': 'Somali',
    'es': 'Spanish',
    'su': 'Sundanese',
    'sw': 'Swahili',
    'sv': 'Swedish',
    'tg': 'Tajik',
    'ta': 'Tamil',
    'te': 'Telugu',
    'th': 'Thai',
    'tr': 'Turkish',
    'uk': 'Ukrainian',
    'ur': 'Urdu',
    'uz': 'Uzbek',
    'ug': 'Uyghur',
    'vi': 'Vietnamese',
    'cy': 'Welsh',
    'xh': 'Xhosa',
    'yi': 'Yiddish',
    'yo': 'Yoruba',
    'zu': 'Zulu'
  };

  static const Map<String, String> _deepLTranslatorLanguages = {
    "BG": "Bulgarian",
    "CS": "Czech",
    "DA": "Danish",
    "DE": "German",
    "EL": "Greek",
    "EN": "English (unspecified variant for backward compatibility; please select EN-GB or EN-US instead)",
    "EN-GB": "English (British)",
    "EN-US": "English (American)",
    "ES": "Spanish",
    "ET": "Estonian",
    "FI": "Finnish",
    "FR": "French",
    "HU": "Hungarian",
    "ID": "Indonesian",
    "IT": "Italian",
    "JA": "Japanese",
    "KO": "Korean",
    "LT": "Lithuanian",
    "LV": "Latvian",
    "NB": "Norwegian (Bokmål)",
    "NL": "Dutch",
    "PL": "Polish",
    "PT": "Portuguese (unspecified variant for backward compatibility; please select PT-BR or PT-PT instead)",
    "PT-BR": "Portuguese (Brazilian)",
    "PT-PT": "Portuguese (all Portuguese varieties excluding Brazilian Portuguese)",
    "RO": "Romanian",
    "RU": "Russian",
    "SK": "Slovak",
    "SL": "Slovenian",
    "SV": "Swedish",
    "TR": "Turkish",
    "UK": "Ukrainian",
    "ZH": "Chinese (simplified)"
  };
}
