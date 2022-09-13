import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/utils/logging.dart';
import 'package:vocabualize/utils/providers/settings_provider.dart';

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

  List<Vocabulary> get createdToday {
    return vocabularyList.where(
      (voc) {
        DateTime now = DateTime.now();
        DateTime creationDate = voc.creationDate;
        return DateTime(creationDate.year, creationDate.month, creationDate.day) == DateTime(now.year, now.month, now.day);
      },
    ).toList();
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
}

class Vocabulary {
  String source = "";
  String target = "";
  List<String> tags = [];
  double level = 0;
  bool isNovice = true;
  int noviceInterval = Provider.of<SettingsProv>(Keys.context).initialNoviceInterval; // minutes
  int interval = Provider.of<SettingsProv>(Keys.context).initialInterval; // minutes
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
    if (level >= 2) {
      return LevelPalette.expert;
    } else if (level >= 1) {
      return LevelPalette.advanced;
    } else if (level > 0) {
      return LevelPalette.beginner;
    } else {
      return LevelPalette.novice;
    }
  }

  void addTag(String tag) => tags.add(tag);
  void removeTag(String tag) => tags.remove(tag);

  void addToNextDay(Duration duration) {
    DateTime newDate = DateTime.now().add(duration);
    nextDate = newDate;
  }

  /// TODO: Add algorithm to calculate nextDate
  Future<void> answer(Answer difficulty) async {
    switch (difficulty) {
      case Answer.easy:
        if (level < 3) level += Provider.of<SettingsProv>(Keys.context, listen: false).easyLevelFactor;
        addToNextDay(const Duration(minutes: 15));
        break;
      case Answer.good:
        if (level < 3) level += Provider.of<SettingsProv>(Keys.context, listen: false).goodLevelFactor;
        addToNextDay(const Duration(minutes: 10));
        break;
      case Answer.hard:
        if (level < 3) level += Provider.of<SettingsProv>(Keys.context, listen: false).hardLevelFactor;
        addToNextDay(const Duration(minutes: 5));
        break;
      default:

        /// RESET
        if (level < 3) level += Provider.of<SettingsProv>(Keys.context, listen: false).hardLevelFactor;
        addToNextDay(const Duration(minutes: 5));
    }
    await Provider.of<VocProv>(Keys.context, listen: false).saveVocabularyList();
  }

  @override
  String toString() {
    return "$source: \n\t'target': \n\t\t$target, \n\t'tags': \n\t\t$tags, \n\t'level': \n\t\t$level, \n\t'creationDate': \n\t\t$creationDate, \n\t'nextDate': \n\t\t$nextDate";
  }
}

enum Answer { forgot, easy, good, hard }
