import 'dart:convert';

import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';

class AppUser {
  static AppUser instance = AppUser();

  String id = "empty_id";
  String? name = "Unknown";
  bool verified = true; // TODO: Change default verified value to false
  DateTime? created;
  DateTime? updated;
  DateTime? lastLogin;

  Future<void> signOut() async {
    instance = AppUser();
    Provider.of<VocabularyProvider>(Global.context, listen: false).signOut();
  }

  void _reset() {
    id = "empty_id";
    name = "Unknown";
    verified = false;
    created = null;
    updated = null;
    lastLogin = null;
  }

  AppUser();

  AppUser.empty();

  AppUser.fromRecord(RecordModel? record) {
    if (record == null) {
      _reset();
      return;
    }
    final data = record.data;
    id = record.id;
    name = data['name'] ?? name;
    verified = data['verified'] ?? verified;
    created = DateTime.tryParse(record.created);
    updated = DateTime.tryParse(record.updated);
    lastLogin = DateTime.tryParse(data['lastLogin'] ?? "");
  }

  AppUser.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return;
    id = json['id'] ?? id;
    name = json['name'] ?? name;
    verified = json['verified'] ?? verified;
    created = DateTime.tryParse(json['created']);
    updated = DateTime.tryParse(json['updated']);
    lastLogin = DateTime.tryParse(json['lastLogin']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'verified': verified,
      'created': created?.toIso8601String(),
      'updated': updated?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'vocabularyList': json.encode(Provider.of<VocabularyProvider>(Global.context, listen: false).vocabularyList),
    };
  }

  String toRawJson() {
    return """
    {
      "id": "$id",
      "name": "$name",
      "verified": $verified,
      "created": "${created?.toIso8601String()}",
      "updated": "${updated?.toIso8601String()}",
      "lastLogin": "${lastLogin?.toIso8601String()}",
      "vocabularyList": "${json.encode(Provider.of<VocabularyProvider>(Global.context, listen: false).vocabularyList)}"
    }
    """;
  }

  @override
  String toString() {
    return "AppUser(id: $id, name: $name, verified: $verified, created: $created, updated: $updated, lastLogin: $lastLogin)";
  }

  @override
  // ignore: hash_and_equals
  operator ==(Object other) {
    if (other is AppUser) {
      return id == other.id;
    }
    return false;
  }
}
