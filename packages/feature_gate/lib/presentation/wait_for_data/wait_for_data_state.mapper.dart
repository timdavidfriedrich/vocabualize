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
    }
    return _instance!;
  }

  @override
  final String id = 'WaitForDataState';

  static bool _$isBusy(WaitForDataState v) => v.isBusy;
  static const Field<WaitForDataState, bool> _f$isBusy = Field(
    'isBusy',
    _$isBusy,
  );
  static AppError? _$error(WaitForDataState v) => v.error;
  static const Field<WaitForDataState, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<WaitForDataState> fields = const {
    #isBusy: _f$isBusy,
    #error: _f$error,
  };

  static WaitForDataState _instantiate(DecodingData data) {
    return WaitForDataState(
      isBusy: data.dec(_f$isBusy),
      error: data.dec(_f$error),
    );
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
  String toJson() {
    return WaitForDataStateMapper.ensureInitialized()
        .encodeJson<WaitForDataState>(this as WaitForDataState);
  }

  Map<String, dynamic> toMap() {
    return WaitForDataStateMapper.ensureInitialized()
        .encodeMap<WaitForDataState>(this as WaitForDataState);
  }

  WaitForDataStateCopyWith<WaitForDataState, WaitForDataState, WaitForDataState>
  get copyWith =>
      _WaitForDataStateCopyWithImpl<WaitForDataState, WaitForDataState>(
        this as WaitForDataState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WaitForDataStateMapper.ensureInitialized().stringifyValue(
      this as WaitForDataState,
    );
  }

  @override
  bool operator ==(Object other) {
    return WaitForDataStateMapper.ensureInitialized().equalsValue(
      this as WaitForDataState,
      other,
    );
  }

  @override
  int get hashCode {
    return WaitForDataStateMapper.ensureInitialized().hashValue(
      this as WaitForDataState,
    );
  }
}

extension WaitForDataStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WaitForDataState, $Out> {
  WaitForDataStateCopyWith<$R, WaitForDataState, $Out>
  get $asWaitForDataState =>
      $base.as((v, t, t2) => _WaitForDataStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WaitForDataStateCopyWith<$R, $In extends WaitForDataState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? isBusy, AppError? error});
  WaitForDataStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WaitForDataStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WaitForDataState, $Out>
    implements WaitForDataStateCopyWith<$R, WaitForDataState, $Out> {
  _WaitForDataStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WaitForDataState> $mapper =
      WaitForDataStateMapper.ensureInitialized();
  @override
  $R call({bool? isBusy, Object? error = $none}) => $apply(
    FieldCopyWithData({
      if (isBusy != null) #isBusy: isBusy,
      if (error != $none) #error: error,
    }),
  );
  @override
  WaitForDataState $make(CopyWithData data) => WaitForDataState(
    isBusy: data.get(#isBusy, or: $value.isBusy),
    error: data.get(#error, or: $value.error),
  );

  @override
  WaitForDataStateCopyWith<$R2, WaitForDataState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WaitForDataStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

