import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/data_sources/space_storage_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/models/local_custom_practice.dart';

abstract class CustomPracticeLocalDataSource {
  Stream<LocalCustomPractice?> watchCustomPractice();

  Future<LocalCustomPractice?> readCustomPractice();

  Future<void> saveCustomPractice(LocalCustomPractice practice);

  Future<void> deleteCustomPractice();
}

@LazySingleton(as: CustomPracticeLocalDataSource)
class CustomPracticeLocalDataSourceImpl(
  final DatabaseSessionDataSource _sessions,
  final SpaceStorageDataSource _storage,
) implements CustomPracticeLocalDataSource {
  final _changes = StreamController<void>.broadcast();

  @override
  Stream<LocalCustomPractice?> watchCustomPractice() {
    return _sessions.watchSession().switchMap(
      (session) => session == null ? Stream.value(null) : _watchCurrentSpace(),
    );
  }

  @override
  Future<LocalCustomPractice?> readCustomPractice() async {
    final space = _sessions.currentSpace;
    return space == null ? null : _storage.readCustomPractice(space);
  }

  @override
  Future<void> saveCustomPractice(LocalCustomPractice practice) async {
    final space = _sessions.currentSpace;
    if (space == null) throw StateError("No database is open.");
    await _storage.writeCustomPractice(space, practice);
    _changes.add(null);
  }

  @override
  Future<void> deleteCustomPractice() async {
    final space = _sessions.currentSpace;
    if (space == null) return;
    await _storage.deleteCustomPractice(space);
    _changes.add(null);
  }

  Stream<LocalCustomPractice?> _watchCurrentSpace() async* {
    yield await readCustomPractice();
    await for (final _ in _changes.stream) {
      yield await readCustomPractice();
    }
  }
}
