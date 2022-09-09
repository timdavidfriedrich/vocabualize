import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/utils/logging.dart';

class VocProv extends ChangeNotifier {
  late SharedPreferences _prefs;

  List<Vocabulary> _vocabularyList = [];

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
    _prefs = await SharedPreferences.getInstance();
    _vocabularyList.add(vocabulary);
    await _prefs.setString("vocabularyList", json.encode(_vocabularyList));
    notifyListeners();
  }

  Future<void> removeFromVocabularyList(Vocabulary vocabulary) async {
    _prefs = await SharedPreferences.getInstance();
    _vocabularyList.remove(vocabulary);
    await _prefs.setString("vocabularyList", json.encode(_vocabularyList));
    notifyListeners();
  }

  Future<void> clearVocabularyList() async {
    _prefs = await SharedPreferences.getInstance();
    _vocabularyList.clear();
    await _prefs.setString("vocabularyList", json.encode(_vocabularyList));
    notifyListeners();
  }

  List<Vocabulary> getVocabularyList() => _vocabularyList;
  List<Vocabulary> getAllToPractise() {
    List<Vocabulary> result = [];
    try {
      result = _vocabularyList.where((voc) => voc.getNextDate().isBefore(DateTime.now())).toList();
    } catch (e) {
      printError(e);
    }
    return result;
  }

  Vocabulary getFirstToPractise() => getAllToPractise().first;
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
    nextDate = DateTime.fromMillisecondsSinceEpoch(json['nextDate']);
  }

  Map<String, dynamic> toJson() => {
        'source': source,
        'target': target,
        'tags': tags,
        'level': level,
        'nextDate': nextDate.millisecondsSinceEpoch,
      };

  @override
  String toString() => "$source: \"$target\" $tags";

  String getSource() => source;
  String getTarget() => target;
  List<String> getTags() => tags;
  int getLevel() => level;
  Color getLevelColor() {
    switch (level) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  DateTime getNextDate() => nextDate;
  DateTime getCreationDate() => nextDate;

  void setSource(String source) => this.source = source;
  void setTarget(String target) => this.target = target;
  void setTags(List<String> tags) => this.tags = tags;
  void addToTags(String tag) => tags.add(tag);
  void removeFromTags(String tag) => tags.remove(tag);
  void removeIndexFromTags(int index) => tags.removeAt(index);
  void setLevel(int level) => this.level = level;
  void setNextDate(DateTime nextDate) => this.nextDate = nextDate;

  // Add algorithm to calculate nextDate
  void addToNextDay(Duration duration) {
    printWarning(nextDate);
    DateTime newDate = nextDate.add(duration);
    nextDate = newDate;
    printHint(nextDate);
  }

  void answerEasy() {
    if (level < 3) setLevel(level + 1);
    addToNextDay(const Duration(minutes: 69));
  }

  void answerMedium() => addToNextDay(Duration(days: 2));
  void answerHard() => addToNextDay(Duration(days: 1));
}
