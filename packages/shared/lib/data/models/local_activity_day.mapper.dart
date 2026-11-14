// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_activity_day.dart';

class LocalActivityDayMapper extends ClassMapperBase<LocalActivityDay> {
  LocalActivityDayMapper._();

  static LocalActivityDayMapper? _instance;
  static LocalActivityDayMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalActivityDayMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalActivityDay';

  static String _$localDate(LocalActivityDay v) => v.localDate;
  static const Field<LocalActivityDay, String> _f$localDate = Field(
    'localDate',
    _$localDate,
  );
  static UuidValue _$deviceId(LocalActivityDay v) => v.deviceId;
  static const Field<LocalActivityDay, UuidValue> _f$deviceId = Field(
    'deviceId',
    _$deviceId,
  );

  @override
  final MappableFields<LocalActivityDay> fields = const {
    #localDate: _f$localDate,
    #deviceId: _f$deviceId,
  };

  static LocalActivityDay _instantiate(DecodingData data) {
    return LocalActivityDay(
      localDate: data.dec(_f$localDate),
      deviceId: data.dec(_f$deviceId),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalActivityDay fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalActivityDay>(map);
  }

  static LocalActivityDay fromJson(String json) {
    return ensureInitialized().decodeJson<LocalActivityDay>(json);
  }
}

mixin LocalActivityDayMappable {
  String toJson() {
    return LocalActivityDayMapper.ensureInitialized()
        .encodeJson<LocalActivityDay>(this as LocalActivityDay);
  }

  Map<String, dynamic> toMap() {
    return LocalActivityDayMapper.ensureInitialized()
        .encodeMap<LocalActivityDay>(this as LocalActivityDay);
  }

  LocalActivityDayCopyWith<LocalActivityDay, LocalActivityDay, LocalActivityDay>
  get copyWith =>
      _LocalActivityDayCopyWithImpl<LocalActivityDay, LocalActivityDay>(
        this as LocalActivityDay,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LocalActivityDayMapper.ensureInitialized().stringifyValue(
      this as LocalActivityDay,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalActivityDayMapper.ensureInitialized().equalsValue(
      this as LocalActivityDay,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalActivityDayMapper.ensureInitialized().hashValue(
      this as LocalActivityDay,
    );
  }
}

extension LocalActivityDayValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalActivityDay, $Out> {
  LocalActivityDayCopyWith<$R, LocalActivityDay, $Out>
  get $asLocalActivityDay =>
      $base.as((v, t, t2) => _LocalActivityDayCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocalActivityDayCopyWith<$R, $In extends LocalActivityDay, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? localDate, UuidValue? deviceId});
  LocalActivityDayCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalActivityDayCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalActivityDay, $Out>
    implements LocalActivityDayCopyWith<$R, LocalActivityDay, $Out> {
  _LocalActivityDayCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalActivityDay> $mapper =
      LocalActivityDayMapper.ensureInitialized();
  @override
  $R call({String? localDate, UuidValue? deviceId}) => $apply(
    FieldCopyWithData({
      if (localDate != null) #localDate: localDate,
      if (deviceId != null) #deviceId: deviceId,
    }),
  );
  @override
  LocalActivityDay $make(CopyWithData data) => LocalActivityDay(
    localDate: data.get(#localDate, or: $value.localDate),
    deviceId: data.get(#deviceId, or: $value.deviceId),
  );

  @override
  LocalActivityDayCopyWith<$R2, LocalActivityDay, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocalActivityDayCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

