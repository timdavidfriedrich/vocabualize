import 'package:dart_mappable/dart_mappable.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

part 'local_activity_day.mapper.dart';

@MappableClass()
class const LocalActivityDay({
  required final String localDate,
  required final UuidValue deviceId,
}) with LocalActivityDayMappable;
