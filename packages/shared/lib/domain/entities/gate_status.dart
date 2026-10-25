import 'package:dart_mappable/dart_mappable.dart';

part 'gate_status.mapper.dart';

@MappableClass()
sealed class GateStatus with GateStatusMappable {
  const GateStatus();
}

@MappableClass()
class const GateOpen() extends GateStatus with GateOpenMappable;

@MappableClass()
class const GateUpdateRequired() extends GateStatus with GateUpdateRequiredMappable;

@MappableClass()
class const GateClockWrong() extends GateStatus with GateClockWrongMappable;

@MappableClass()
class const GateMaintenance({
  required final String? message,
}) extends GateStatus with GateMaintenanceMappable;
