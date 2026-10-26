import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/activity_history.dart';

abstract class ActivityRepository {
  Stream<AppResult<ActivityHistory>> watchActivityHistory();
}
