import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/domain/repositories/sync_repository.dart';

const _minimumSyncingDuration = Duration(milliseconds: 800);

@injectable
class SyncStatusCubit extends Cubit<SyncStatus> {
  SyncStatusCubit(this._syncRepository) : super(SyncStatus.disabled);

  final SyncRepository _syncRepository;
  final _syncingStopwatch = Stopwatch();
  StreamSubscription<AppResult<SyncStatus>>? _subscription;
  Timer? _syncingEndTimer;

  void start() {
    _subscription ??= _syncRepository.watchSyncStatus().listen((result) {
      if (result case Success(:final data)) _show(data);
    });
  }

  void _show(SyncStatus status) {
    _syncingEndTimer?.cancel();
    if (status == SyncStatus.syncing) {
      if (!_syncingStopwatch.isRunning) {
        _syncingStopwatch
          ..reset()
          ..start();
      }
      emit(status);
      return;
    }
    final remaining = _minimumSyncingDuration - _syncingStopwatch.elapsed;
    if (!_syncingStopwatch.isRunning || remaining <= Duration.zero) {
      _endSyncing(status);
    } else {
      _syncingEndTimer = Timer(remaining, () => _endSyncing(status));
    }
  }

  void _endSyncing(SyncStatus status) {
    _syncingStopwatch.stop();
    emit(status);
  }

  @override
  Future<void> close() async {
    _syncingEndTimer?.cancel();
    await _subscription?.cancel();
    return super.close();
  }
}
