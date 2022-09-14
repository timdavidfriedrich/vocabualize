import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/core/providers/voc_provider.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class Vocabulary {
  String source = "";
  String target = "";
  List<String> tags = [];
  double level = 0;
  bool isNovice = true;
  int noviceInterval = Provider.of<SettingsProv>(Keys.context.context).initialNoviceInterval; // minutes
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