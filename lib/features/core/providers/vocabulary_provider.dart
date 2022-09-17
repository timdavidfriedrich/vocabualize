import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:log/log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class VocabularyProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

  List<Vocabulary> vocabularyList = [];

  bool contains(Vocabulary vocabulary) {
    return vocabularyList.any((voc) => voc.creationDate.microsecondsSinceEpoch == vocabulary.creationDate.microsecondsSinceEpoch);
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
    /// TODO: replace constants (7, 10)
    return vocabularyList
        .where((voc) => voc.creationDate.isAfter(DateTime.now().subtract(const Duration(days: 0))))
        .toList()
        .reversed
        .take(10)
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

  Future<void> save() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("vocabularyList", json.encode(vocabularyList));
    notifyListeners();
  }

  Future<void> init() async {
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
}
