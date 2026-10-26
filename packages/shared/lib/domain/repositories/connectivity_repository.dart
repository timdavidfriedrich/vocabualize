import 'package:core/error/app_result.dart';

abstract class ConnectivityRepository {
  Stream<AppResult<bool>> watchIsConnected();

  Future<AppResult<bool>> isConnected();
}
