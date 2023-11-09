import 'package:pocketbase/pocketbase.dart';
import 'package:uuid/uuid.dart';

class Tag {
  final String id;
  String name;
  DateTime? created;
  DateTime? updated;

  Tag({required this.name, String? id}) : id = id ?? "tag--${const Uuid().v4()}";

  Tag.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "empty_id",
        name = json['name'],
        created = DateTime.tryParse(json['created']),
        updated = DateTime.tryParse(json['updated']);

  Tag.fromRecord(RecordModel recordModel)
      : id = recordModel.id,
        name = recordModel.data['name'],
        created = DateTime.tryParse(recordModel.created),
        updated = DateTime.tryParse(recordModel.updated);

  Tag.empty()
      : id = "tag--${const Uuid().v4()}",
        name = "empty_name";

  @override
  String toString() {
    return "Tag(id: $id, name: $name, created: $created, updated: $updated)";
  }
}
