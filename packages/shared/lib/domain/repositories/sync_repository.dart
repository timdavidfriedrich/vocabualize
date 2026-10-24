import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/data_readiness.dart';
import 'package:shared/domain/entities/sync_status.dart';

abstract class SyncRepository {
  Stream<AppResult<SyncStatus>> watchSyncStatus();

  Stream<AppResult<DataReadiness>> watchDataReadiness();

  AppResult<()> retryInitialSync();
}
