import 'package:dart_mappable/dart_mappable.dart';

part 'data_readiness.mapper.dart';

enum DataUnavailableReason {
  offline,
  serverUnreachable,
  signInRequired,
  updateRequired,
  clockWrong,
  syncFailed,
}

@MappableClass()
sealed class DataReadiness with DataReadinessMappable {
  const DataReadiness();
}

@MappableClass()
class const DataReady() extends DataReadiness with DataReadyMappable;

@MappableClass()
class const DataDownloading() extends DataReadiness with DataDownloadingMappable;

@MappableClass()
class const DataUnavailable({
  required final DataUnavailableReason reason,
}) extends DataReadiness with DataUnavailableMappable;
