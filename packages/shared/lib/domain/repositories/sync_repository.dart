import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/sync_status.dart';

abstract class SyncRepository {
  Stream<AppResult<SyncStatus>> watchSyncStatus();
}
