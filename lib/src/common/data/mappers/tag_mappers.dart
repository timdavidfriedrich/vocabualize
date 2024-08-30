import 'package:vocabualize/src/common/data/models/rdb_tag.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';

extension RdbTagMappers on RdbTag {
  Tag toTag() {
    return Tag(
      id: id,
      name: name,
    );
  }
}

extension TagMappers on Tag {
  RdbTag toRdbTag() {
    return RdbTag(
      id: id,
      name: name,
    );
  }
}
