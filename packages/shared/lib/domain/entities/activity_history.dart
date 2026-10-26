import 'package:dart_mappable/dart_mappable.dart';

part 'activity_history.mapper.dart';

@MappableClass()
class const ActivityHistory({
  required final Set<DateTime> activeDays,
  required final DateTime today,
}) with ActivityHistoryMappable;
