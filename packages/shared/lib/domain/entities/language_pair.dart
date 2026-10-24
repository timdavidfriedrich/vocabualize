import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';

part 'language_pair.mapper.dart';

@MappableClass()
class const LanguagePair({
  required final Language source,
  required final Language target,
}) with LanguagePairMappable;
