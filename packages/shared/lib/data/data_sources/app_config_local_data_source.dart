import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _cacheFileName = "app_config.json";

abstract class AppConfigLocalDataSource {
  Stream<RemoteAppConfig?> watchCache();

  Future<void> writeCache(RemoteAppConfig config);
}

@LazySingleton(as: AppConfigLocalDataSource)
class AppConfigLocalDataSourceImpl() implements AppConfigLocalDataSource {
  final _changes = StreamController<RemoteAppConfig>.broadcast();

  @override
  Stream<RemoteAppConfig?> watchCache() async* {
    yield await _readCache();
    yield* _changes.stream;
  }

  @override
  Future<void> writeCache(RemoteAppConfig config) async {
    await File(await _cachePath()).writeAsString(jsonEncode(config.toJson()), flush: true);
    _changes.add(config);
  }

  Future<RemoteAppConfig?> _readCache() async {
    final file = File(await _cachePath());
    if (!await file.exists()) return null;
    try {
      return RemoteAppConfig.fromJson(jsonDecode(await file.readAsString()) as Map<String, dynamic>);
    } on FormatException {
      return null;
    }
  }

  Future<String> _cachePath() async =>
      "${(await getApplicationSupportDirectory()).path}/$_cacheFileName";
}
