import 'package:vocabualize_client/vocabualize_client.dart';

abstract class DeviceDataSource {
  Future<UuidValue> readOrCreateDeviceId();

  Future<void> deleteDeviceId();
}
