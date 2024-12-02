import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/src/common/data/models/rdb_tag.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';

extension RecordModelTagMappers on RecordModel {
  RdbTag toRdbTag() {
    return RdbTag(
      id: id,
      name: data['name'],
      created: data['created'],
      updated: data['updated'],
    );
  }
}

extension RdbTagMappers on RdbTag {
  Tag toTag() {
    return Tag(
      id: id,
      name: name,
    );
  }

  RecordModel toRecordModel() {
    return RecordModel(
      id: id,
      data: {
        'name': name,
      },
    );
  }
}

extension TagMappers on Tag {
  RdbTag toRdbTag() {
    return RdbTag(
      id: id ?? "",
      name: name,
    );
  }
}
