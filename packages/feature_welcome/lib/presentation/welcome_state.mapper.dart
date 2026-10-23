// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'welcome_state.dart';

class WelcomeStateMapper extends ClassMapperBase<WelcomeState> {
  WelcomeStateMapper._();

  static WelcomeStateMapper? _instance;
  static WelcomeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WelcomeStateMapper._());
      WelcomeIdleMapper.ensureInitialized();
      WelcomeBusyMapper.ensureInitialized();
      WelcomeFailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WelcomeState';

  @override
  final MappableFields<WelcomeState> fields = const {};

  static WelcomeState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('WelcomeState');
  }

  @override
  final Function instantiate = _instantiate;

  static WelcomeState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WelcomeState>(map);
  }

  static WelcomeState fromJson(String json) {
    return ensureInitialized().decodeJson<WelcomeState>(json);
  }
}

mixin WelcomeStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  WelcomeStateCopyWith<WelcomeState, WelcomeState, WelcomeState> get copyWith;
}

abstract class WelcomeStateCopyWith<$R, $In extends WelcomeState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  WelcomeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class WelcomeIdleMapper extends ClassMapperBase<WelcomeIdle> {
  WelcomeIdleMapper._();

  static WelcomeIdleMapper? _instance;
  static WelcomeIdleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WelcomeIdleMapper._());
      WelcomeStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WelcomeIdle';

  @override
  final MappableFields<WelcomeIdle> fields = const {};

  static WelcomeIdle _instantiate(DecodingData data) {
    return WelcomeIdle();
  }

  @override
  final Function instantiate = _instantiate;

  static WelcomeIdle fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WelcomeIdle>(map);
  }

  static WelcomeIdle fromJson(String json) {
    return ensureInitialized().decodeJson<WelcomeIdle>(json);
  }
}

mixin WelcomeIdleMappable {
  String toJson() {
    return WelcomeIdleMapper.ensureInitialized().encodeJson<WelcomeIdle>(
      this as WelcomeIdle,
    );
  }

  Map<String, dynamic> toMap() {
    return WelcomeIdleMapper.ensureInitialized().encodeMap<WelcomeIdle>(
      this as WelcomeIdle,
    );
  }

  WelcomeIdleCopyWith<WelcomeIdle, WelcomeIdle, WelcomeIdle> get copyWith =>
      _WelcomeIdleCopyWithImpl<WelcomeIdle, WelcomeIdle>(
        this as WelcomeIdle,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WelcomeIdleMapper.ensureInitialized().stringifyValue(
      this as WelcomeIdle,
    );
  }

  @override
  bool operator ==(Object other) {
    return WelcomeIdleMapper.ensureInitialized().equalsValue(
      this as WelcomeIdle,
      other,
    );
  }

  @override
  int get hashCode {
    return WelcomeIdleMapper.ensureInitialized().hashValue(this as WelcomeIdle);
  }
}

extension WelcomeIdleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WelcomeIdle, $Out> {
  WelcomeIdleCopyWith<$R, WelcomeIdle, $Out> get $asWelcomeIdle =>
      $base.as((v, t, t2) => _WelcomeIdleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WelcomeIdleCopyWith<$R, $In extends WelcomeIdle, $Out>
    implements WelcomeStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  WelcomeIdleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WelcomeIdleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WelcomeIdle, $Out>
    implements WelcomeIdleCopyWith<$R, WelcomeIdle, $Out> {
  _WelcomeIdleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WelcomeIdle> $mapper =
      WelcomeIdleMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  WelcomeIdle $make(CopyWithData data) => WelcomeIdle();

  @override
  WelcomeIdleCopyWith<$R2, WelcomeIdle, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WelcomeIdleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WelcomeBusyMapper extends ClassMapperBase<WelcomeBusy> {
  WelcomeBusyMapper._();

  static WelcomeBusyMapper? _instance;
  static WelcomeBusyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WelcomeBusyMapper._());
      WelcomeStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WelcomeBusy';

  @override
  final MappableFields<WelcomeBusy> fields = const {};

  static WelcomeBusy _instantiate(DecodingData data) {
    return WelcomeBusy();
  }

  @override
  final Function instantiate = _instantiate;

  static WelcomeBusy fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WelcomeBusy>(map);
  }

  static WelcomeBusy fromJson(String json) {
    return ensureInitialized().decodeJson<WelcomeBusy>(json);
  }
}

mixin WelcomeBusyMappable {
  String toJson() {
    return WelcomeBusyMapper.ensureInitialized().encodeJson<WelcomeBusy>(
      this as WelcomeBusy,
    );
  }

  Map<String, dynamic> toMap() {
    return WelcomeBusyMapper.ensureInitialized().encodeMap<WelcomeBusy>(
      this as WelcomeBusy,
    );
  }

  WelcomeBusyCopyWith<WelcomeBusy, WelcomeBusy, WelcomeBusy> get copyWith =>
      _WelcomeBusyCopyWithImpl<WelcomeBusy, WelcomeBusy>(
        this as WelcomeBusy,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WelcomeBusyMapper.ensureInitialized().stringifyValue(
      this as WelcomeBusy,
    );
  }

  @override
  bool operator ==(Object other) {
    return WelcomeBusyMapper.ensureInitialized().equalsValue(
      this as WelcomeBusy,
      other,
    );
  }

  @override
  int get hashCode {
    return WelcomeBusyMapper.ensureInitialized().hashValue(this as WelcomeBusy);
  }
}

extension WelcomeBusyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WelcomeBusy, $Out> {
  WelcomeBusyCopyWith<$R, WelcomeBusy, $Out> get $asWelcomeBusy =>
      $base.as((v, t, t2) => _WelcomeBusyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WelcomeBusyCopyWith<$R, $In extends WelcomeBusy, $Out>
    implements WelcomeStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  WelcomeBusyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WelcomeBusyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WelcomeBusy, $Out>
    implements WelcomeBusyCopyWith<$R, WelcomeBusy, $Out> {
  _WelcomeBusyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WelcomeBusy> $mapper =
      WelcomeBusyMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  WelcomeBusy $make(CopyWithData data) => WelcomeBusy();

  @override
  WelcomeBusyCopyWith<$R2, WelcomeBusy, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WelcomeBusyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WelcomeFailureMapper extends ClassMapperBase<WelcomeFailure> {
  WelcomeFailureMapper._();

  static WelcomeFailureMapper? _instance;
  static WelcomeFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WelcomeFailureMapper._());
      WelcomeStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WelcomeFailure';

  static AppError _$error(WelcomeFailure v) => v.error;
  static const Field<WelcomeFailure, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<WelcomeFailure> fields = const {#error: _f$error};

  static WelcomeFailure _instantiate(DecodingData data) {
    return WelcomeFailure(error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static WelcomeFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WelcomeFailure>(map);
  }

  static WelcomeFailure fromJson(String json) {
    return ensureInitialized().decodeJson<WelcomeFailure>(json);
  }
}

mixin WelcomeFailureMappable {
  String toJson() {
    return WelcomeFailureMapper.ensureInitialized().encodeJson<WelcomeFailure>(
      this as WelcomeFailure,
    );
  }

  Map<String, dynamic> toMap() {
    return WelcomeFailureMapper.ensureInitialized().encodeMap<WelcomeFailure>(
      this as WelcomeFailure,
    );
  }

  WelcomeFailureCopyWith<WelcomeFailure, WelcomeFailure, WelcomeFailure>
  get copyWith => _WelcomeFailureCopyWithImpl<WelcomeFailure, WelcomeFailure>(
    this as WelcomeFailure,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return WelcomeFailureMapper.ensureInitialized().stringifyValue(
      this as WelcomeFailure,
    );
  }

  @override
  bool operator ==(Object other) {
    return WelcomeFailureMapper.ensureInitialized().equalsValue(
      this as WelcomeFailure,
      other,
    );
  }

  @override
  int get hashCode {
    return WelcomeFailureMapper.ensureInitialized().hashValue(
      this as WelcomeFailure,
    );
  }
}

extension WelcomeFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WelcomeFailure, $Out> {
  WelcomeFailureCopyWith<$R, WelcomeFailure, $Out> get $asWelcomeFailure =>
      $base.as((v, t, t2) => _WelcomeFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WelcomeFailureCopyWith<$R, $In extends WelcomeFailure, $Out>
    implements WelcomeStateCopyWith<$R, $In, $Out> {
  @override
  $R call({AppError? error});
  WelcomeFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WelcomeFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WelcomeFailure, $Out>
    implements WelcomeFailureCopyWith<$R, WelcomeFailure, $Out> {
  _WelcomeFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WelcomeFailure> $mapper =
      WelcomeFailureMapper.ensureInitialized();
  @override
  $R call({AppError? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  WelcomeFailure $make(CopyWithData data) =>
      WelcomeFailure(error: data.get(#error, or: $value.error));

  @override
  WelcomeFailureCopyWith<$R2, WelcomeFailure, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WelcomeFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

