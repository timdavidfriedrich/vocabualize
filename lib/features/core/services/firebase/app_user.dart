import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';

class AppUser {
  String _name = "Unknown";

  AppUser({required String name}) : _name = name;

  Map<String, dynamic> toJson() => {
        'name': _name,
        'vocabularyList': json.encode(Provider.of<VocabularyProvider>(Global.context, listen: false).vocabularyList),
      };

  AppUser.fromJson(Map<String, dynamic> json) {
    _name = json['name'] ?? _name;
    Provider.of<VocabularyProvider>(Global.context, listen: false).vocabularyList = json['vocabularyList'] ?? [];
  }
}
