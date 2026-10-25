import 'package:shared/domain/entities/tag.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

extension LocalTagMappers on LocalTag {
  Tag toTag() => Tag(id: id.toString(), name: name, createdAt: createdAt.toUtc());
}
