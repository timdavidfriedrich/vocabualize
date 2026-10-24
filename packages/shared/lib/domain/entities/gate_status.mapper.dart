// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'gate_status.dart';

class GateStatusMapper extends ClassMapperBase<GateStatus> {
  GateStatusMapper._();

  static GateStatusMapper? _instance;
  static GateStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GateStatusMapper._());
      GateOpenMapper.ensureInitialized();
      GateUpdateRequiredMapper.ensureInitialized();
      GateMaintenanceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GateStatus';

  @override
  final MappableFields<GateStatus> fields = const {};

  static GateStatus _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('GateStatus');
  }

  @override
  final Function instantiate = _instantiate;

  static GateStatus fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GateStatus>(map);
  }

  static GateStatus fromJson(String json) {
    return ensureInitialized().decodeJson<GateStatus>(json);
  }
}

mixin GateStatusMappable {
  String toJson();
  Map<String, dynamic> toMap();
  GateStatusCopyWith<GateStatus, GateStatus, GateStatus> get copyWith;
}

abstract class GateStatusCopyWith<$R, $In extends GateStatus, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  GateStatusCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class GateOpenMapper extends ClassMapperBase<GateOpen> {
  GateOpenMapper._();

  static GateOpenMapper? _instance;
  static GateOpenMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GateOpenMapper._());
      GateStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GateOpen';

  @override
  final MappableFields<GateOpen> fields = const {};

  static GateOpen _instantiate(DecodingData data) {
    return GateOpen();
  }

  @override
  final Function instantiate = _instantiate;

  static GateOpen fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GateOpen>(map);
  }

  static GateOpen fromJson(String json) {
    return ensureInitialized().decodeJson<GateOpen>(json);
  }
}

mixin GateOpenMappable {
  String toJson() {
    return GateOpenMapper.ensureInitialized().encodeJson<GateOpen>(
      this as GateOpen,
    );
  }

  Map<String, dynamic> toMap() {
    return GateOpenMapper.ensureInitialized().encodeMap<GateOpen>(
      this as GateOpen,
    );
  }

  GateOpenCopyWith<GateOpen, GateOpen, GateOpen> get copyWith =>
      _GateOpenCopyWithImpl<GateOpen, GateOpen>(
        this as GateOpen,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GateOpenMapper.ensureInitialized().stringifyValue(this as GateOpen);
  }

  @override
  bool operator ==(Object other) {
    return GateOpenMapper.ensureInitialized().equalsValue(
      this as GateOpen,
      other,
    );
  }

  @override
  int get hashCode {
    return GateOpenMapper.ensureInitialized().hashValue(this as GateOpen);
  }
}

extension GateOpenValueCopy<$R, $Out> on ObjectCopyWith<$R, GateOpen, $Out> {
  GateOpenCopyWith<$R, GateOpen, $Out> get $asGateOpen =>
      $base.as((v, t, t2) => _GateOpenCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GateOpenCopyWith<$R, $In extends GateOpen, $Out>
    implements GateStatusCopyWith<$R, $In, $Out> {
  @override
  $R call();
  GateOpenCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GateOpenCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GateOpen, $Out>
    implements GateOpenCopyWith<$R, GateOpen, $Out> {
  _GateOpenCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GateOpen> $mapper =
      GateOpenMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  GateOpen $make(CopyWithData data) => GateOpen();

  @override
  GateOpenCopyWith<$R2, GateOpen, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GateOpenCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class GateUpdateRequiredMapper extends ClassMapperBase<GateUpdateRequired> {
  GateUpdateRequiredMapper._();

  static GateUpdateRequiredMapper? _instance;
  static GateUpdateRequiredMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GateUpdateRequiredMapper._());
      GateStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GateUpdateRequired';

  @override
  final MappableFields<GateUpdateRequired> fields = const {};

  static GateUpdateRequired _instantiate(DecodingData data) {
    return GateUpdateRequired();
  }

  @override
  final Function instantiate = _instantiate;

  static GateUpdateRequired fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GateUpdateRequired>(map);
  }

  static GateUpdateRequired fromJson(String json) {
    return ensureInitialized().decodeJson<GateUpdateRequired>(json);
  }
}

mixin GateUpdateRequiredMappable {
  String toJson() {
    return GateUpdateRequiredMapper.ensureInitialized()
        .encodeJson<GateUpdateRequired>(this as GateUpdateRequired);
  }

  Map<String, dynamic> toMap() {
    return GateUpdateRequiredMapper.ensureInitialized()
        .encodeMap<GateUpdateRequired>(this as GateUpdateRequired);
  }

  GateUpdateRequiredCopyWith<
    GateUpdateRequired,
    GateUpdateRequired,
    GateUpdateRequired
  >
  get copyWith =>
      _GateUpdateRequiredCopyWithImpl<GateUpdateRequired, GateUpdateRequired>(
        this as GateUpdateRequired,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GateUpdateRequiredMapper.ensureInitialized().stringifyValue(
      this as GateUpdateRequired,
    );
  }

  @override
  bool operator ==(Object other) {
    return GateUpdateRequiredMapper.ensureInitialized().equalsValue(
      this as GateUpdateRequired,
      other,
    );
  }

  @override
  int get hashCode {
    return GateUpdateRequiredMapper.ensureInitialized().hashValue(
      this as GateUpdateRequired,
    );
  }
}

extension GateUpdateRequiredValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GateUpdateRequired, $Out> {
  GateUpdateRequiredCopyWith<$R, GateUpdateRequired, $Out>
  get $asGateUpdateRequired => $base.as(
    (v, t, t2) => _GateUpdateRequiredCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GateUpdateRequiredCopyWith<
  $R,
  $In extends GateUpdateRequired,
  $Out
>
    implements GateStatusCopyWith<$R, $In, $Out> {
  @override
  $R call();
  GateUpdateRequiredCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GateUpdateRequiredCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GateUpdateRequired, $Out>
    implements GateUpdateRequiredCopyWith<$R, GateUpdateRequired, $Out> {
  _GateUpdateRequiredCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GateUpdateRequired> $mapper =
      GateUpdateRequiredMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  GateUpdateRequired $make(CopyWithData data) => GateUpdateRequired();

  @override
  GateUpdateRequiredCopyWith<$R2, GateUpdateRequired, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GateUpdateRequiredCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class GateMaintenanceMapper extends ClassMapperBase<GateMaintenance> {
  GateMaintenanceMapper._();

  static GateMaintenanceMapper? _instance;
  static GateMaintenanceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GateMaintenanceMapper._());
      GateStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GateMaintenance';

  static String? _$message(GateMaintenance v) => v.message;
  static const Field<GateMaintenance, String> _f$message = Field(
    'message',
    _$message,
  );

  @override
  final MappableFields<GateMaintenance> fields = const {#message: _f$message};

  static GateMaintenance _instantiate(DecodingData data) {
    return GateMaintenance(message: data.dec(_f$message));
  }

  @override
  final Function instantiate = _instantiate;

  static GateMaintenance fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GateMaintenance>(map);
  }

  static GateMaintenance fromJson(String json) {
    return ensureInitialized().decodeJson<GateMaintenance>(json);
  }
}

mixin GateMaintenanceMappable {
  String toJson() {
    return GateMaintenanceMapper.ensureInitialized()
        .encodeJson<GateMaintenance>(this as GateMaintenance);
  }

  Map<String, dynamic> toMap() {
    return GateMaintenanceMapper.ensureInitialized().encodeMap<GateMaintenance>(
      this as GateMaintenance,
    );
  }

  GateMaintenanceCopyWith<GateMaintenance, GateMaintenance, GateMaintenance>
  get copyWith =>
      _GateMaintenanceCopyWithImpl<GateMaintenance, GateMaintenance>(
        this as GateMaintenance,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GateMaintenanceMapper.ensureInitialized().stringifyValue(
      this as GateMaintenance,
    );
  }

  @override
  bool operator ==(Object other) {
    return GateMaintenanceMapper.ensureInitialized().equalsValue(
      this as GateMaintenance,
      other,
    );
  }

  @override
  int get hashCode {
    return GateMaintenanceMapper.ensureInitialized().hashValue(
      this as GateMaintenance,
    );
  }
}

extension GateMaintenanceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GateMaintenance, $Out> {
  GateMaintenanceCopyWith<$R, GateMaintenance, $Out> get $asGateMaintenance =>
      $base.as((v, t, t2) => _GateMaintenanceCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GateMaintenanceCopyWith<$R, $In extends GateMaintenance, $Out>
    implements GateStatusCopyWith<$R, $In, $Out> {
  @override
  $R call({String? message});
  GateMaintenanceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GateMaintenanceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GateMaintenance, $Out>
    implements GateMaintenanceCopyWith<$R, GateMaintenance, $Out> {
  _GateMaintenanceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GateMaintenance> $mapper =
      GateMaintenanceMapper.ensureInitialized();
  @override
  $R call({Object? message = $none}) =>
      $apply(FieldCopyWithData({if (message != $none) #message: message}));
  @override
  GateMaintenance $make(CopyWithData data) =>
      GateMaintenance(message: data.get(#message, or: $value.message));

  @override
  GateMaintenanceCopyWith<$R2, GateMaintenance, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GateMaintenanceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

