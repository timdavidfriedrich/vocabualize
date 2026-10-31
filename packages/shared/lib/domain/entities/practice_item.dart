import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary.dart';

part 'practice_item.mapper.dart';

@MappableClass()
class const PracticeItem({
  required final Vocabulary vocabulary,
  required final Language language,
}) with PracticeItemMappable;
