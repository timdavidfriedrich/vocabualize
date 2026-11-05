import 'package:dart_mappable/dart_mappable.dart';

part 'local_tag_extras.mapper.dart';

@MappableClass()
class const LocalTagExtras({
  required final String? emoji,
}) with LocalTagExtrasMappable;
