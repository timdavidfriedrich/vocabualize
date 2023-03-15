import 'dart:convert';

import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class AppUser {
  static final AppUser _instance = AppUser();
  static AppUser get instance => _instance;

  String? name = "Unknown";

  Future<void> signOut() async {
    // TODO: Add settings clear
    name = "Unknown";
    Provider.of<VocabularyProvider>(Global.context, listen: false).signOut();
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        // TODO: Add settings toJson()
        'vocabularyList': json.encode(Provider.of<VocabularyProvider>(Global.context, listen: false).vocabularyList),
      };

  // ! TODO: COMBINE WITH VOCABULARY PROVIDER (SharedPreferences + Firestore)
  loadFromJson(Map<String, dynamic> jsonMap) {
    if (jsonMap.isEmpty) return;

    name = jsonMap['name'] ?? name;
    // TODO: Add settings   fromJson(..)

    Provider.of<VocabularyProvider>(Global.context, listen: false).clear();
    for (dynamic voc in json.decode(jsonMap['vocabularyList'])) {
      Provider.of<VocabularyProvider>(Global.context, listen: false).add(Vocabulary.fromJson(voc));
    }
  }
}
