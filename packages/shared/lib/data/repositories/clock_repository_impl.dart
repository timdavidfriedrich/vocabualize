import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/clock_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/clock_mappers.dart';
import 'package:shared/domain/entities/clock_status.dart';
import 'package:shared/domain/repositories/clock_repository.dart';

@Injectable(as: ClockRepository)
class const ClockRepositoryImpl(
  final ClockDataSource _dataSource,
) implements ClockRepository {
  @override
  Stream<AppResult<ClockStatus>> watchClockStatus() {
    return _dataSource.watchState().map((state) => state.toClockStatus()).toAppResult();
  }
}
