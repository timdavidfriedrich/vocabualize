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
    if (!await _prefs.setString(
        "vocabularyList", json.encode(_vocabularyList))) {
      printError("addToVocabularyList");
    }
    notifyListeners();
  }

  Future<void> removeFromVocabularyList(Vocabulary vocabulary) async {
    _prefs = await SharedPreferences.getInstance();
    _vocabularyList.remove(vocabulary);
    if (!await _prefs.setString(
        "vocabularyList", json.encode(_vocabularyList))) {
      printError("removeFromVocabularyList");
    }
    notifyListeners();
  }

  Future<void> clearVocabularyList() async {
    _prefs = await SharedPreferences.getInstance();
    _vocabularyList.clear();
    if (!await _prefs.setString(
        "vocabularyList", json.encode(_vocabularyList))) {
      printError("clearVocabularyList");
    }
    notifyListeners();
  }

  List<Vocabulary> getVocabularyList() => _vocabularyList;
}

class Vocabulary {
  String source = "";
  String target = "";
  List<String> tags = [];

  Vocabulary({required this.source, required this.target, tags})
      : tags = tags ?? [];

  Vocabulary.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    target = json['target'];
    for (dynamic voc in json["tags"]) {
      // TODO: tags aktivieren, irgendwie sind die doppelt?
      tags.add(voc.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        'source': source,
        'target': target,
        'tags': tags,
      };

  @override
  String toString() => "$source: \"$target\" $tags";

  String getSource() => source;
  String getTarget() => target;
  List<String> getTags() => tags;

  void setSource(String source) => this.source = source;
  void setTarget(String target) => this.target = target;
  void setTags(List<String> tags) => this.tags = tags;
  void addToTags(String tag) => tags.add(tag);
  void removeFromTags(String tag) => tags.remove(tag);
  void removeIndexFromTags(int index) => tags.removeAt(index);
}
