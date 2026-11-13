// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'wait_for_data_state.dart';

class WaitForDataStateMapper extends ClassMapperBase<WaitForDataState> {
  WaitForDataStateMapper._();

  static WaitForDataStateMapper? _instance;
  static WaitForDataStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WaitForDataStateMapper._());
      WaitForDataIdleMapper.ensureInitialized();
      WaitForDataBusyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WaitForDataState';

  @override
  final MappableFields<WaitForDataState> fields = const {};

  static WaitForDataState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('WaitForDataState');
  }

  @override
  final Function instantiate = _instantiate;

  static WaitForDataState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WaitForDataState>(map);
  }

  static WaitForDataState fromJson(String json) {
    return ensureInitialized().decodeJson<WaitForDataState>(json);
  }
}

mixin WaitForDataStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  WaitForDataStateCopyWith<WaitForDataState, WaitForDataState, WaitForDataState>
  get copyWith;
}

abstract class WaitForDataStateCopyWith<$R, $In extends WaitForDataState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  WaitForDataStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class WaitForDataIdleMapper extends ClassMapperBase<WaitForDataIdle> {
  WaitForDataIdleMapper._();

  static WaitForDataIdleMapper? _instance;
  static WaitForDataIdleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WaitForDataIdleMapper._());
      WaitForDataStateMapper.ensureInitialized();
      AccountConflictMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WaitForDataIdle';

  static AccountConflict? _$accountConflict(WaitForDataIdle v) =>
      v.accountConflict;
  static const Field<WaitForDataIdle, AccountConflict> _f$accountConflict =
      Field('accountConflict', _$accountConflict);
  static AppError? _$error(WaitForDataIdle v) => v.error;
  static const Field<WaitForDataIdle, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<WaitForDataIdle> fields = const {
    #accountConflict: _f$accountConflict,
    #error: _f$error,
  };

  static WaitForDataIdle _instantiate(DecodingData data) {
    return WaitForDataIdle(
      accountConflict: data.dec(_f$accountConflict),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WaitForDataIdle fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WaitForDataIdle>(map);
  }

  static WaitForDataIdle fromJson(String json) {
    return ensureInitialized().decodeJson<WaitForDataIdle>(json);
  }
}

mixin WaitForDataIdleMappable {
  String toJson() {
    return WaitForDataIdleMapper.ensureInitialized()
        .encodeJson<WaitForDataIdle>(this as WaitForDataIdle);
  }

  Map<String, dynamic> toMap() {
    return WaitForDataIdleMapper.ensureInitialized().encodeMap<WaitForDataIdle>(
      this as WaitForDataIdle,
    );
  }

  WaitForDataIdleCopyWith<WaitForDataIdle, WaitForDataIdle, WaitForDataIdle>
  get copyWith =>
      _WaitForDataIdleCopyWithImpl<WaitForDataIdle, WaitForDataIdle>(
        this as WaitForDataIdle,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WaitForDataIdleMapper.ensureInitialized().stringifyValue(
      this as WaitForDataIdle,
    );
  }

  @override
  bool operator ==(Object other) {
    return WaitForDataIdleMapper.ensureInitialized().equalsValue(
      this as WaitForDataIdle,
      other,
    );
  }

  @override
  int get hashCode {
    return WaitForDataIdleMapper.ensureInitialized().hashValue(
      this as WaitForDataIdle,
    );
  }
}

extension WaitForDataIdleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WaitForDataIdle, $Out> {
  WaitForDataIdleCopyWith<$R, WaitForDataIdle, $Out> get $asWaitForDataIdle =>
      $base.as((v, t, t2) => _WaitForDataIdleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WaitForDataIdleCopyWith<$R, $In extends WaitForDataIdle, $Out>
    implements WaitForDataStateCopyWith<$R, $In, $Out> {
  AccountConflictCopyWith<$R, AccountConflict, AccountConflict>?
  get accountConflict;
  @override
  $R call({AccountConflict? accountConflict, AppError? error});
  WaitForDataIdleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WaitForDataIdleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WaitForDataIdle, $Out>
    implements WaitForDataIdleCopyWith<$R, WaitForDataIdle, $Out> {
  _WaitForDataIdleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WaitForDataIdle> $mapper =
      WaitForDataIdleMapper.ensureInitialized();
  @override
  AccountConflictCopyWith<$R, AccountConflict, AccountConflict>?
  get accountConflict =>
      $value.accountConflict?.copyWith.$chain((v) => call(accountConflict: v));
  @override
  $R call({Object? accountConflict = $none, Object? error = $none}) => $apply(
    FieldCopyWithData({
      if (accountConflict != $none) #accountConflict: accountConflict,
      if (error != $none) #error: error,
    }),
  );
  @override
  WaitForDataIdle $make(CopyWithData data) => WaitForDataIdle(
    accountConflict: data.get(#accountConflict, or: $value.accountConflict),
    error: data.get(#error, or: $value.error),
  );

  @override
  WaitForDataIdleCopyWith<$R2, WaitForDataIdle, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WaitForDataIdleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WaitForDataBusyMapper extends ClassMapperBase<WaitForDataBusy> {
  WaitForDataBusyMapper._();

  static WaitForDataBusyMapper? _instance;
  static WaitForDataBusyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WaitForDataBusyMapper._());
      WaitForDataStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WaitForDataBusy';

  @override
  final MappableFields<WaitForDataBusy> fields = const {};

  static WaitForDataBusy _instantiate(DecodingData data) {
    return WaitForDataBusy();
  }

  @override
  final Function instantiate = _instantiate;

  static WaitForDataBusy fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WaitForDataBusy>(map);
  }

  static WaitForDataBusy fromJson(String json) {
    return ensureInitialized().decodeJson<WaitForDataBusy>(json);
  }
}

mixin WaitForDataBusyMappable {
  String toJson() {
    return WaitForDataBusyMapper.ensureInitialized()
        .encodeJson<WaitForDataBusy>(this as WaitForDataBusy);
  }

  Map<String, dynamic> toMap() {
    return WaitForDataBusyMapper.ensureInitialized().encodeMap<WaitForDataBusy>(
      this as WaitForDataBusy,
    );
  }

  WaitForDataBusyCopyWith<WaitForDataBusy, WaitForDataBusy, WaitForDataBusy>
  get copyWith =>
      _WaitForDataBusyCopyWithImpl<WaitForDataBusy, WaitForDataBusy>(
        this as WaitForDataBusy,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WaitForDataBusyMapper.ensureInitialized().stringifyValue(
      this as WaitForDataBusy,
    );
  }

  @override
  bool operator ==(Object other) {
    return WaitForDataBusyMapper.ensureInitialized().equalsValue(
      this as WaitForDataBusy,
      other,
    );
  }

  @override
  int get hashCode {
    return WaitForDataBusyMapper.ensureInitialized().hashValue(
      this as WaitForDataBusy,
    );
  }
}

extension WaitForDataBusyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WaitForDataBusy, $Out> {
  WaitForDataBusyCopyWith<$R, WaitForDataBusy, $Out> get $asWaitForDataBusy =>
      $base.as((v, t, t2) => _WaitForDataBusyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WaitForDataBusyCopyWith<$R, $In extends WaitForDataBusy, $Out>
    implements WaitForDataStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  WaitForDataBusyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WaitForDataBusyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WaitForDataBusy, $Out>
    implements WaitForDataBusyCopyWith<$R, WaitForDataBusy, $Out> {
  _WaitForDataBusyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WaitForDataBusy> $mapper =
      WaitForDataBusyMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  WaitForDataBusy $make(CopyWithData data) => WaitForDataBusy();

  @override
  WaitForDataBusyCopyWith<$R2, WaitForDataBusy, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WaitForDataBusyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

