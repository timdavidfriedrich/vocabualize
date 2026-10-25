import 'package:dart_mappable/dart_mappable.dart';

part 'tag.mapper.dart';

@MappableClass()
class const Tag({
  required final String id,
  required final String name,
  required final DateTime createdAt,
}) with TagMappable;
