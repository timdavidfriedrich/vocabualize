import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/connectivity_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/domain/repositories/connectivity_repository.dart';

@Injectable(as: ConnectivityRepository)
class const ConnectivityRepositoryImpl(
  final ConnectivityDataSource _dataSource,
) implements ConnectivityRepository {
  @override
  Stream<AppResult<bool>> watchIsConnected() => _dataSource.watchIsConnected().toAppResult();

  @override
  Future<AppResult<bool>> isConnected() async {
    try {
      return Success(await _dataSource.watchIsConnected().first);
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }
}
