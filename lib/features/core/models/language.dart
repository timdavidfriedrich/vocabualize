import 'package:pocketbase/pocketbase.dart';
import 'package:uuid/uuid.dart';

class Language {
  final String id;
  String name;
  String translatorId;
  String speechToTextId;
  String textToSpeechId;
  DateTime? created;
  DateTime? updated;

  Language({id, required this.name, required this.translatorId, required this.speechToTextId, required this.textToSpeechId})
      : id = id ?? "language--${const Uuid().v4()}";

  Language.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "empty_id",
        name = json['name'],
        translatorId = json['translatorId'],
        speechToTextId = json['speechToTextId'],
        textToSpeechId = json['textToSpeechId'],
        created = json['created'] != null ? DateTime.parse(json['created']) : null,
        updated = json['updated'] != null ? DateTime.parse(json['updated']) : null;

  Language.fromRecord(RecordModel recordModel)
      : id = recordModel.id,
        name = recordModel.data['name'] ?? "",
        translatorId = recordModel.data['translatorId'] ?? "",
        speechToTextId = recordModel.data['speechToTextId'] ?? "",
        textToSpeechId = recordModel.data['textToSpeechId'] ?? "",
        created = DateTime.tryParse(recordModel.created),
        updated = DateTime.tryParse(recordModel.updated);

  /// TODO: apply device language for name (to have the correct language on init)
  /// => Maybe setting this at onboarding will be enough
  factory Language.defaultSource() => Language(name: "English", translatorId: "en", speechToTextId: "en_AU", textToSpeechId: "en-US");
  factory Language.defaultTarget() => Language(name: "Spanish", translatorId: "es", speechToTextId: "es_AR", textToSpeechId: "es-ES");

  @override
  // ignore: hash_and_equals
  bool operator ==(other) {
    if (other is! Language) return false;
    return name == other.name &&
        translatorId == other.translatorId &&
        speechToTextId == other.speechToTextId &&
        textToSpeechId == other.textToSpeechId;
  }

  @override
  String toString() {
    return "Language(id: $id, name: $name, translatorId: $translatorId, speechToTextId: $speechToTextId, "
        "textToSpeechId: $textToSpeechId, created: $created, updated: $updated)";
  }
}
