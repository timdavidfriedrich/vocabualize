import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/practise/services/answer.dart';
import 'package:vocabualize/features/practise/services/date_calculator.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class Vocabulary {
  String source = "";
  String target = "";
  List<String> tags = [];
  double level = 0;
  bool isNovice = true;
  //int noviceInterval = Provider.of<SettingsProvider>(Keys.context, listen: false).initialNoviceInterval; // minutes
  int interval = Provider.of<SettingsProvider>(Keys.context, listen: false).initialNoviceInterval; // minutes
  double ease = Provider.of<SettingsProvider>(Keys.context, listen: false).initialEase;
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
    isNovice = json['isNovice'];
    //noviceInterval = json['noviceInterval'];
    interval = json['interval'];
    ease = json['ease'];
    creationDate = DateTime.fromMillisecondsSinceEpoch(json['creationDate']);
    nextDate = DateTime.fromMillisecondsSinceEpoch(json['nextDate']);
  }

  Map<String, dynamic> toJson() => {
        'source': source,
        'target': target,
        'tags': tags,
        'level': level,
        'isNovice': isNovice,
        //'noviceInterval': noviceInterval,
        'interval': interval,
        'ease': ease,
        'creationDate': creationDate.millisecondsSinceEpoch,
        'nextDate': nextDate.millisecondsSinceEpoch,
      };

  bool get isNotNovice => !isNovice;
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

  Future<void> answer(Answer answer) async {
    nextDate = DateCalculator.nextDate(this, answer);
    await Provider.of<VocabularyProvider>(Keys.context, listen: false).save();
  }

  Future<void> reset() async {
    level = 0;
    isNovice = true;
    //noviceInterval = Provider.of<SettingsProvider>(Keys.context, listen: false).initialNoviceInterval; // minutes
    interval = Provider.of<SettingsProvider>(Keys.context, listen: false).initialInterval; // minutes
    nextDate = DateTime.now();
    await Provider.of<VocabularyProvider>(Keys.context, listen: false).save();
  }

  @override
  String toString() {
    return "$source: \n\t'target': $target, \n\t'tags': $tags, \n\t'level': $level, \n\t'isNovice': $isNovice, " /*\n\t'noviceInterval': $noviceInterval*/ ", \n\t'interval': $interval, \n\t'ease': $ease, \n\t'creationDate': $creationDate, \n\t'nextDate': $nextDate";
  }
}
