import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_item.dart';

part 'practice_card.mapper.dart';

@MappableClass()
class const PracticeCard({
  required final PracticeItem item,
  required final Language prompt,
  required final bool isIntro,
}) with PracticeCardMappable;
