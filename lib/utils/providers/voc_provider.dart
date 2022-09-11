import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/config/themes/level_colors.dart';
import 'package:vocabualize/utils/logging.dart';

class VocProv extends ChangeNotifier {
  late SharedPreferences _prefs;

  List<Vocabulary> vocabularyList = [];

  Vocabulary get firstToPractise => allToPractise.first;

  List<Vocabulary> get allToPractise {
    List<Vocabulary> result = [];
    try {
      result = vocabularyList.where((voc) => voc.nextDate.isBefore(DateTime.now())).toList();
    } catch (e) {
      printError(e);
    }
    return result;
  }

  Future<void> saveVocabularyList() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("vocabularyList", json.encode(vocabularyList));
  }

  Future<void> initVocabularyList() async {
    _prefs = await SharedPreferences.getInstance();
    String vocabularyListJSON = _prefs.getString("vocabularyList") ?? "";
    if (vocabularyListJSON != "") {
      for (dynamic voc in json.decode(vocabularyListJSON)) {
        vocabularyList.add(Vocabulary.fromJson(voc));
      }
    } else {
      vocabularyList = [Vocabulary(source: "source", target: "target")];
    }
    notifyListeners();
  }

  Future<void> addToVocabularyList(Vocabulary vocabulary) async {
    vocabularyList.add(vocabulary);
    await saveVocabularyList();
    notifyListeners();
  }

  Future<void> removeFromVocabularyList(Vocabulary vocabulary) async {
    vocabularyList.remove(vocabulary);
    await saveVocabularyList();
    notifyListeners();
  }

  Future<void> clearVocabularyList() async {
    vocabularyList.clear();
    await saveVocabularyList();
    notifyListeners();
  }

  // void anserEasy(Vocabulary vocabulary) {
  //   if (getVocabularyList().firstWhere((voc) => voc == vocabulary).getLevel < 3) {
  //     getVocabularyList().firstWhere((voc) => voc == vocabulary).setLevel =
  //         getVocabularyList().firstWhere((voc) => voc == vocabulary).getLevel + 1;
  //   }
  //   getVocabularyList().firstWhere((voc) => voc == vocabulary).addToNextDay(const Duration(minutes: 69));
  // }
}

class Vocabulary {
  String source = "";
  String target = "";
  List<String> tags = [];
  int level = 0;
  DateTime creationDate = DateTime.now();
  DateTime nextDate = DateTime.now();

  Vocabulary({required this.source, required this.target, tags}) : tags = tags ?? [];

  Vocabulary.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    target = json['target'];
    for (dynamic voc in json["tags"]) {
      tags.add(voc.toString());
    }
    level = json['level'];
    creationDate = DateTime.fromMillisecondsSinceEpoch(json['creationDate']);
    nextDate = DateTime.fromMillisecondsSinceEpoch(json['nextDate']);
  }

  Map<String, dynamic> toJson() => {
        'source': source,
        'target': target,
        'tags': tags,
        'level': level,
        'creationDate': creationDate.millisecondsSinceEpoch,
        'nextDate': nextDate.millisecondsSinceEpoch,
      };

  Color get levelColor {
    switch (level) {
      case 0:
        return newColor;
      case 1:
        return hardColor;
      case 2:
        return okayColor;
      case 3:
        return easyColor;
      default:
        return newColor;
    }
  }

  void addTag(String tag) => tags.add(tag);
  void removeTag(String tag) => tags.remove(tag);

  // Add algorithm to calculate nextDate
  void addToNextDay(Duration duration) {
    DateTime newDate = nextDate.add(duration);
    nextDate = newDate;
  }

  void answerEasy() {
    if (level < 3) level++;
    addToNextDay(const Duration(minutes: 69));
  }

  void answerOkay() => addToNextDay(const Duration(days: 2));
  void answerHard() => addToNextDay(const Duration(days: 1));

  @override
  String toString() {
    return "$source: \n\t'target': \n\t\t$target, \n\t'tags': \n\t\t$tags, \n\t'level': \n\t\t$level, \n\t'creationDate': \n\t\t$creationDate, \n\t'nextDate': \n\t\t$nextDate";
  }
}
