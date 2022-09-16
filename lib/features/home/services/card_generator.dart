import 'package:provider/provider.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class CardGenerator {
  static String get info {
    List<Vocabulary> vocabularyList = Provider.of<VocabularyProvider>(Keys.context, listen: false).vocabularyList;
    List<Vocabulary> createdToday = Provider.of<VocabularyProvider>(Keys.context, listen: false).createdToday;

    if (vocabularyList.isEmpty) return "Why don't you add some new words? :)";
    if (createdToday.length >= 2) return "Wow, you already added ${createdToday.length} words today.";
    if (vocabularyList.length >= 10) return "Damn, you added ${vocabularyList.length} words in total.";
    if (vocabularyList.length == 1) return "Your collection contains ${vocabularyList.length} word.";
    return "Your collection contains ${vocabularyList.length} words.";
  }

  static String get prompt {
    List<Vocabulary> vocabularyList = Provider.of<VocabularyProvider>(Keys.context, listen: false).vocabularyList;

    if (vocabularyList.isEmpty) return "";
    return "Let's practise!";
  }
}
