import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _deviceIdFileName = "device_id";

abstract class DeviceDataSource {
  Future<UuidValue> readOrCreateDeviceId();

  Future<void> deleteDeviceId();
}

@LazySingleton(as: DeviceDataSource)
class DeviceDataSourceImpl() implements DeviceDataSource {
  UuidValue? _deviceId;
  Future<UuidValue>? _loadingDeviceId;

  @override
  Future<UuidValue> readOrCreateDeviceId() async {
    return _deviceId ??
        await (_loadingDeviceId ??= _readOrCreate().whenComplete(() => _loadingDeviceId = null));
  }

  @override
  Future<void> deleteDeviceId() async {
    _deviceId = null;
    final file = await _deviceIdFile();
    if (await file.exists()) await file.delete();
  }

  Future<UuidValue> _readOrCreate() async {
    final file = await _deviceIdFile();
    final deviceId = await _read(file) ?? await _create(file);
    _deviceId = deviceId;
    return deviceId;
  }

  Future<UuidValue?> _read(File file) async {
    if (!await file.exists()) return null;
    try {
      return UuidValue.withValidation((await file.readAsString()).trim());
    } on FormatException {
      return null;
    }
  }

  Future<UuidValue> _create(File file) async {
    final deviceId = const Uuid().v4obj();
    await file.writeAsString(deviceId.uuid, flush: true);
    return deviceId;
  }

  Future<File> _deviceIdFile() async =>
      File("${(await getApplicationSupportDirectory()).path}/$_deviceIdFileName");
}
