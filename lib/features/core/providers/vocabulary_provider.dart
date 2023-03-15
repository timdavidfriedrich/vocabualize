import 'dart:async';
import 'dart:convert';

import 'package:vocabualize/constants/common_imports.dart';
import 'package:log/log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/features/core/services/firebase/cloud_service.dart';
import 'package:vocabualize/features/core/services/format.dart';
import 'package:vocabualize/features/core/services/language.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class VocabularyProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

  List<Vocabulary> vocabularyList = [];

  bool contains(Vocabulary vocabulary) {
    return vocabularyList.any((voc) => voc.creationDate.microsecondsSinceEpoch == vocabulary.creationDate.microsecondsSinceEpoch);
  }

  dynamic searchListForSource(String source) {
    bool containsSource = vocabularyList.any((voc) => Format.normalize(voc.source) == Format.normalize(source));
    if (containsSource) {
      return vocabularyList.firstWhere((voc) => Format.normalize(voc.source) == Format.normalize(source));
    } else {
      return null;
    }
  }

  List<Vocabulary> get allToPractise {
    List<Vocabulary> result = [];
    try {
      result = vocabularyList.where((voc) => voc.nextDate.isBefore(DateTime.now())).toList();
    } catch (e) {
      Log.error(e.toString());
    }
    return result;
  }

  Vocabulary get firstToPractise {
    return allToPractise.first;
  }

  List<Vocabulary> get lastest {
    const int daysIncluded = 7;
    const int maxItems = 10;
    return vocabularyList
        .where((voc) => voc.creationDate.isAfter(DateTime.now().subtract(const Duration(days: daysIncluded))))
        .toList()
        .reversed
        .take(maxItems)
        .toList();
  }

  List<Vocabulary> get createdToday {
    return vocabularyList.where(
      (voc) {
        DateTime now = DateTime.now();
        DateTime creationDate = voc.creationDate;
        return DateTime(creationDate.year, creationDate.month, creationDate.day) == DateTime(now.year, now.month, now.day);
      },
    ).toList();
  }

  List<String> get allTags {
    List<String> result = [];
    for (var vocabulary in vocabularyList) {
      for (var tag in vocabulary.tags) {
        if (!result.contains(tag)) result.add(tag);
      }
    }
    return result;
  }

  List<Vocabulary> getVocabulariesByTag(String tag) {
    List<Vocabulary> result = [];
    try {
      result = vocabularyList.where((vocabulary) => vocabulary.tags.contains(tag)).toList();
    } catch (e) {
      Log.error(e.toString());
    }
    return result;
  }

  List<Vocabulary> getAllToPractiseForTag(String tag) {
    List<Vocabulary> result = [];
    try {
      result = getVocabulariesByTag(tag).where((voc) => voc.nextDate.isBefore(DateTime.now())).toList();
    } catch (e) {
      Log.error(e.toString());
    }
    return result;
  }

  bool get isMultilingual {
    bool result = false;
    if (vocabularyList.isEmpty) return result;
    Language firstVocabularySourceLanguage = vocabularyList.first.sourceLanguage;
    Language firstVocabularyTargetLanguage = vocabularyList.first.targetLanguage;
    for (Vocabulary vocabulary in vocabularyList) {
      if (vocabulary.sourceLanguage != firstVocabularySourceLanguage) return true;
      if (vocabulary.targetLanguage != firstVocabularyTargetLanguage) return true;
    }
    return result;
  }

  Future<void> save() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("vocabularyList", json.encode(vocabularyList));
    await CloudService.saveUserData();
    notifyListeners();
  }

  Future<void> init() async {
    vocabularyList.clear();
    _prefs = await SharedPreferences.getInstance();
    String vocabularyListJSON = _prefs.getString("vocabularyList") ?? "";
    if (vocabularyListJSON != "") {
      for (dynamic voc in json.decode(vocabularyListJSON)) {
        vocabularyList.add(Vocabulary.fromJson(voc));
      }
    }
    notifyListeners();
  }

  Future<void> add(Vocabulary vocabulary) async {
    vocabularyList.add(vocabulary);
    await save();
    notifyListeners();
  }

  Future<void> remove(Vocabulary vocabulary) async {
    vocabularyList.remove(vocabulary);
    await save();
    notifyListeners();
  }

  Future<void> clear() async {
    vocabularyList.clear();
    await save();
    notifyListeners();
  }

  Future<void> signOut() async {
    vocabularyList.clear();
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("vocabularyList", json.encode(vocabularyList));
    notifyListeners();
  }
}
