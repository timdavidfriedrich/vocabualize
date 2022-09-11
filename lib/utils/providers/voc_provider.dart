import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/config/themes/level_colors.dart';
import 'package:vocabualize/utils/logging.dart';

class VocProv extends ChangeNotifier {
  late SharedPreferences _prefs;

  List<Vocabulary> _vocabularyList = [];

  Future<void> saveVocabularyList() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("vocabularyList", json.encode(_vocabularyList));
  }

  Future<void> initVocabularyList() async {
    _prefs = await SharedPreferences.getInstance();
    String vocabularyListJSON = _prefs.getString("vocabularyList") ?? "";
    if (vocabularyListJSON != "") {
      for (dynamic voc in json.decode(vocabularyListJSON)) {
        _vocabularyList.add(Vocabulary.fromJson(voc));
      }
    } else {
      _vocabularyList = [Vocabulary(source: "source", target: "target")];
    }
    notifyListeners();
  }

  Future<void> addToVocabularyList(Vocabulary vocabulary) async {
    _vocabularyList.add(vocabulary);
    await saveVocabularyList();
    notifyListeners();
  }

  Future<void> removeFromVocabularyList(Vocabulary vocabulary) async {
    _vocabularyList.remove(vocabulary);
    await saveVocabularyList();
    notifyListeners();
  }

  Future<void> clearVocabularyList() async {
    _vocabularyList.clear();
    await saveVocabularyList();
    notifyListeners();
  }

  List<Vocabulary> get vocabularyList => _vocabularyList;
  List<Vocabulary> get allToPractise {
    List<Vocabulary> result = [];
    try {
      result = _vocabularyList.where((voc) => voc.getNextDate.isBefore(DateTime.now())).toList();
    } catch (e) {
      printError(e);
    }
    return result;
  }

  Vocabulary get firstToPractise => allToPractise.first;

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

  @override
  String toString() {
    return "$source: \n\t'target': \n\t\t$target, \n\t'tags': \n\t\t$tags, \n\t'level': \n\t\t$level, \n\t'creationDate': \n\t\t$creationDate, \n\t'nextDate': \n\t\t$nextDate";
  }

  String get getSource => source;
  String get getTarget => target;
  List<String> get getTags => tags;
  int get getLevel => level;
  DateTime get getCreationDate => nextDate;
  DateTime get getNextDate => nextDate;
  Color get getLevelColor {
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

  set setSource(String source) => this.source = source;
  set setTarget(String target) => this.target = target;
  set setTags(List<String> tags) => this.tags = tags;
  set addToTags(String tag) => tags.add(tag);
  set removeFromTags(String tag) => tags.remove(tag);
  set removeIndexFromTags(int index) => tags.removeAt(index);
  set setLevel(int level) => this.level = level;
  set setNextDate(DateTime nextDate) => this.nextDate = nextDate;

  // Add algorithm to calculate nextDate
  void addToNextDay(Duration duration) {
    DateTime newDate = nextDate.add(duration);
    nextDate = newDate;
  }

  void answerEasy() {
    if (level < 3) setLevel = level + 1;
    addToNextDay(const Duration(minutes: 69));
  }

  void answerOkay() => addToNextDay(const Duration(days: 2));
  void answerHard() => addToNextDay(const Duration(days: 1));
}
