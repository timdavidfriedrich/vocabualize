import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:klog/klog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/data/data_sources/app_config_local_data_source.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _cacheFileName = "app_config.json";

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
      return switch (jsonDecode(await file.readAsString())) {
        final Map<String, dynamic> json => RemoteAppConfig.fromJson(json),
        _ => null,
      };
    } on Object catch (error) {
      Klog.warning("Config cache unreadable: ${error.runtimeType}");
      return null;
    }
  }

  Future<String> _cachePath() async =>
      "${(await getApplicationSupportDirectory()).path}/$_cacheFileName";
}
