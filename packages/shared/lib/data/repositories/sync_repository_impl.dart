import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/image_sync_data_source.dart';
import 'package:shared/data/data_sources/sync_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/sync_status_mappers.dart';
import 'package:shared/domain/entities/data_readiness.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/domain/repositories/sync_repository.dart';

@Injectable(as: SyncRepository)
class const SyncRepositoryImpl(
  final SyncDataSource _syncDataSource,
  final ImageSyncDataSource _imageSyncDataSource,
) implements SyncRepository {
  @override
  Stream<AppResult<SyncStatus>> watchSyncStatus() {
    final isTransferring = _syncDataSource.watchTransferring().combineLatest(
      _imageSyncDataSource.watchTransferring(),
      (isSyncingData, isSyncingImages) => isSyncingData || isSyncingImages,
    );
    return _syncDataSource
        .watchState()
        .combineLatest(
          isTransferring,
          (state, isTransferring) => state.toSyncStatus(isTransferring: isTransferring),
        )
        .distinct()
        .toAppResult();
  }

  @override
  Stream<AppResult<DataReadiness>> watchDataReadiness() {
    return _syncDataSource
        .watchReadiness()
        .map((readiness) => readiness.toDataReadiness())
        .toAppResult();
  }

  @override
  AppResult<()> retryInitialSync() {
    try {
      _syncDataSource.retryInitialSync();
      return const Success(());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }
}
