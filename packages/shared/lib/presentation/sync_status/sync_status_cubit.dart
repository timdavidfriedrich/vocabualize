import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/domain/repositories/sync_repository.dart';

@injectable
class SyncStatusCubit extends Cubit<SyncStatus> {
  SyncStatusCubit(this._syncRepository) : super(SyncStatus.disabled);

  final SyncRepository _syncRepository;
  StreamSubscription<AppResult<SyncStatus>>? _subscription;

  void start() {
    _subscription ??= _syncRepository.watchSyncStatus().listen((result) {
      if (result case Success(:final data)) emit(data);
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
