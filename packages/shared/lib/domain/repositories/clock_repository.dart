import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/clock_status.dart';

abstract class ClockRepository {
  Stream<AppResult<ClockStatus>> watchClockStatus();
}
