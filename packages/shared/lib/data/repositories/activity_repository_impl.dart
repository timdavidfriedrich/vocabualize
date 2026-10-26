import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/activity_local_data_source.dart';
import 'package:shared/data/data_sources/calendar_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/activity_mappers.dart';
import 'package:shared/domain/entities/activity_history.dart';
import 'package:shared/domain/repositories/activity_repository.dart';

@Injectable(as: ActivityRepository)
class const ActivityRepositoryImpl(
  final ActivityLocalDataSource _activityDataSource,
  final CalendarDataSource _calendarDataSource,
) implements ActivityRepository {
  @override
  Stream<AppResult<ActivityHistory>> watchActivityHistory() {
    return _activityDataSource
        .watchActivities()
        .combineLatest(
          _calendarDataSource.watchToday(),
          (activities, today) => activities.toActivityHistory(today: today),
        )
        .toAppResult();
  }
}
