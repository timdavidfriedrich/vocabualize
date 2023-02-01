import 'dart:async';
import 'dart:convert';

import 'package:vocabualize/constants/common_imports.dart';
import 'package:log/log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/features/core/services/format.dart';
import 'package:vocabualize/features/core/services/language.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class VocabularyProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

  final List<Vocabulary> _vocabularyList = [];

  bool contains(Vocabulary vocabulary) {
    return _vocabularyList.any((voc) => voc.creationDate.microsecondsSinceEpoch == vocabulary.creationDate.microsecondsSinceEpoch);
  }

  dynamic searchListForSource(String source) {
    bool containsSource = _vocabularyList.any((voc) => Format.normalize(voc.source) == Format.normalize(source));
    if (containsSource) {
      return _vocabularyList.firstWhere((voc) => Format.normalize(voc.source) == Format.normalize(source));
    } else {
      return null;
    }
  }

  List<Vocabulary> get vocabularyList => _vocabularyList;

  List<Vocabulary> get allToPractise {
    List<Vocabulary> result = [];
    try {
      result = _vocabularyList.where((voc) => voc.nextDate.isBefore(DateTime.now())).toList();
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
    return _vocabularyList
        .where((voc) => voc.creationDate.isAfter(DateTime.now().subtract(const Duration(days: daysIncluded))))
        .toList()
        .reversed
        .take(maxItems)
        .toList();
  }

  List<Vocabulary> get createdToday {
    return _vocabularyList.where(
      (voc) {
        DateTime now = DateTime.now();
        DateTime creationDate = voc.creationDate;
        return DateTime(creationDate.year, creationDate.month, creationDate.day) == DateTime(now.year, now.month, now.day);
      },
    ).toList();
  }

  List<String> get allTags {
    List<String> result = [];
    for (var vocabulary in _vocabularyList) {
      for (var tag in vocabulary.tags) {
        if (!result.contains(tag)) result.add(tag);
      }
    }
    return result;
  }

  List<Vocabulary> getVocabulariesByTag(String tag) {
    List<Vocabulary> result = [];
    try {
      result = _vocabularyList.where((vocabulary) => vocabulary.tags.contains(tag)).toList();
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
    if (_vocabularyList.isEmpty) return result;
    Language firstVocabularySourceLanguage = _vocabularyList.first.sourceLanguage;
    Language firstVocabularyTargetLanguage = _vocabularyList.first.targetLanguage;
    for (Vocabulary vocabulary in _vocabularyList) {
      if (vocabulary.sourceLanguage != firstVocabularySourceLanguage) return true;
      if (vocabulary.targetLanguage != firstVocabularyTargetLanguage) return true;
    }
    return result;
  }

  Future<void> save() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("vocabularyList", json.encode(_vocabularyList));
    notifyListeners();
  }

  Future<void> init() async {
    _vocabularyList.clear();
    _prefs = await SharedPreferences.getInstance();
    String vocabularyListJSON = _prefs.getString("vocabularyList") ?? "";
    if (vocabularyListJSON != "") {
      for (dynamic voc in json.decode(vocabularyListJSON)) {
        _vocabularyList.add(Vocabulary.fromJson(voc));
      }
    }
    notifyListeners();
  }

  Future<void> add(Vocabulary vocabulary) async {
    _vocabularyList.add(vocabulary);
    await save();
    notifyListeners();
  }

  Future<void> remove(Vocabulary vocabulary) async {
    _vocabularyList.remove(vocabulary);
    await save();
    notifyListeners();
  }

  Future<void> clear() async {
    _vocabularyList.clear();
    await save();
    notifyListeners();
  }
}
