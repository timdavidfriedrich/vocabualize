import 'package:uuid/uuid.dart';

class Tag {
  final String id;
  String name;
  DateTime? created;
  DateTime? updated;

  Tag({required this.name, String? id}) : id = id ?? "tag--${const Uuid().v4()}";

  Tag.fromJson(Map<String, dynamic> json, {String? id, String? created, String? updated})
      : id = id ?? json['id'] ?? "empty_id",
        name = json['name'],
        created = created != null ? DateTime.parse(created) : null,
        updated = updated != null ? DateTime.parse(updated) : null;

  Tag.empty()
      : id = "tag--${const Uuid().v4()}",
        name = "empty_name";

  @override
  String toString() {
    return "{id: $id, name: $name, created: $created, updated: $updated}";
  }
}
