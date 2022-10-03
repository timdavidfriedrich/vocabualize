import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:vocabualize/features/core/services/language.dart';
import 'package:vocabualize/features/record/services/speech.dart';

class Languages {
  static Future<Language?> findLanguage({String? translatorId, String? speechToTextId, String? textToSpeechId}) async {
    Language? result;
    List<Language> languages = await getLangauges();
    for (Language language in languages) {
      if (translatorId != null && language.translatorId != translatorId) continue;
      if (speechToTextId != null && language.translatorId != speechToTextId) continue;
      if (textToSpeechId != null && language.translatorId != textToSpeechId) continue;
      result = language;
    }
    return result;
  }

  static Future<List<Language>> getLangauges() async {
    List<Language> result = [];
    List<String> translatorIds = await getTranslatorIds();
    List<String> speechToTextIds = await getSpeechToTextIds();
    List<String> textToSpeechIds = await getTextToSpeechIds();
    for (String translatorId in translatorIds) {
      String speechToTextId = speechToTextIds.firstWhere((id) => id.toLowerCase().startsWith(translatorId), orElse: () => "");
      String textToSpeechId = textToSpeechIds.firstWhere((id) => id.toLowerCase().startsWith(translatorId), orElse: () => "");
      if (speechToTextId == "" || textToSpeechId == "") continue;
      result.add(
        Language(
            name: _translatorLanguages[translatorId] ?? "Unknown",
            translatorId: translatorId,
            speechToTextId: speechToTextId,
            textToSpeechId: textToSpeechId),
      );
    }
    return result;
  }

  static Future<List<String>> getSpeechToTextIds() async {
    final Speech speech = Speech.instance;
    List<LocaleName> locales = await speech.getLocales();

    List<String> result = [];
    for (LocaleName locale in locales) {
      result.add(locale.localeId);
    }
    return result;
  }

  static Future<List<String>> getTextToSpeechIds() async {
    final TextToSpeech tts = TextToSpeech();
    final result = await tts.getLanguages();
    return result;
  }

  static Future<List<String>> getTranslatorIds() async {
    List<String> result = [];
    for (String id in _translatorLanguages.keys) {
      result.add(id);
    }
    return result;
  }

  static const Map<String, String> _translatorLanguages = {
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
}
