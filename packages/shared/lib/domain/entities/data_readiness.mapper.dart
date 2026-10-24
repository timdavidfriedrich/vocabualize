// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'data_readiness.dart';

class DataReadinessMapper extends ClassMapperBase<DataReadiness> {
  DataReadinessMapper._();

  static DataReadinessMapper? _instance;
  static DataReadinessMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DataReadinessMapper._());
      DataReadyMapper.ensureInitialized();
      DataDownloadingMapper.ensureInitialized();
      DataUnavailableMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DataReadiness';

  @override
  final MappableFields<DataReadiness> fields = const {};

  static DataReadiness _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('DataReadiness');
  }

  @override
  final Function instantiate = _instantiate;

  static DataReadiness fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DataReadiness>(map);
  }

  static DataReadiness fromJson(String json) {
    return ensureInitialized().decodeJson<DataReadiness>(json);
  }
}

mixin DataReadinessMappable {
  String toJson();
  Map<String, dynamic> toMap();
  DataReadinessCopyWith<DataReadiness, DataReadiness, DataReadiness>
  get copyWith;
}

abstract class DataReadinessCopyWith<$R, $In extends DataReadiness, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  DataReadinessCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class DataReadyMapper extends ClassMapperBase<DataReady> {
  DataReadyMapper._();

  static DataReadyMapper? _instance;
  static DataReadyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DataReadyMapper._());
      DataReadinessMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DataReady';

  @override
  final MappableFields<DataReady> fields = const {};

  static DataReady _instantiate(DecodingData data) {
    return DataReady();
  }

  @override
  final Function instantiate = _instantiate;

  static DataReady fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DataReady>(map);
  }

  static DataReady fromJson(String json) {
    return ensureInitialized().decodeJson<DataReady>(json);
  }
}

mixin DataReadyMappable {
  String toJson() {
    return DataReadyMapper.ensureInitialized().encodeJson<DataReady>(
      this as DataReady,
    );
  }

  Map<String, dynamic> toMap() {
    return DataReadyMapper.ensureInitialized().encodeMap<DataReady>(
      this as DataReady,
    );
  }

  DataReadyCopyWith<DataReady, DataReady, DataReady> get copyWith =>
      _DataReadyCopyWithImpl<DataReady, DataReady>(
        this as DataReady,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DataReadyMapper.ensureInitialized().stringifyValue(
      this as DataReady,
    );
  }

  @override
  bool operator ==(Object other) {
    return DataReadyMapper.ensureInitialized().equalsValue(
      this as DataReady,
      other,
    );
  }

  @override
  int get hashCode {
    return DataReadyMapper.ensureInitialized().hashValue(this as DataReady);
  }
}

extension DataReadyValueCopy<$R, $Out> on ObjectCopyWith<$R, DataReady, $Out> {
  DataReadyCopyWith<$R, DataReady, $Out> get $asDataReady =>
      $base.as((v, t, t2) => _DataReadyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DataReadyCopyWith<$R, $In extends DataReady, $Out>
    implements DataReadinessCopyWith<$R, $In, $Out> {
  @override
  $R call();
  DataReadyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DataReadyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DataReady, $Out>
    implements DataReadyCopyWith<$R, DataReady, $Out> {
  _DataReadyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DataReady> $mapper =
      DataReadyMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DataReady $make(CopyWithData data) => DataReady();

  @override
  DataReadyCopyWith<$R2, DataReady, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DataReadyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DataDownloadingMapper extends ClassMapperBase<DataDownloading> {
  DataDownloadingMapper._();

  static DataDownloadingMapper? _instance;
  static DataDownloadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DataDownloadingMapper._());
      DataReadinessMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DataDownloading';

  @override
  final MappableFields<DataDownloading> fields = const {};

  static DataDownloading _instantiate(DecodingData data) {
    return DataDownloading();
  }

  @override
  final Function instantiate = _instantiate;

  static DataDownloading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DataDownloading>(map);
  }

  static DataDownloading fromJson(String json) {
    return ensureInitialized().decodeJson<DataDownloading>(json);
  }
}

mixin DataDownloadingMappable {
  String toJson() {
    return DataDownloadingMapper.ensureInitialized()
        .encodeJson<DataDownloading>(this as DataDownloading);
  }

  Map<String, dynamic> toMap() {
    return DataDownloadingMapper.ensureInitialized().encodeMap<DataDownloading>(
      this as DataDownloading,
    );
  }

  DataDownloadingCopyWith<DataDownloading, DataDownloading, DataDownloading>
  get copyWith =>
      _DataDownloadingCopyWithImpl<DataDownloading, DataDownloading>(
        this as DataDownloading,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DataDownloadingMapper.ensureInitialized().stringifyValue(
      this as DataDownloading,
    );
  }

  @override
  bool operator ==(Object other) {
    return DataDownloadingMapper.ensureInitialized().equalsValue(
      this as DataDownloading,
      other,
    );
  }

  @override
  int get hashCode {
    return DataDownloadingMapper.ensureInitialized().hashValue(
      this as DataDownloading,
    );
  }
}

extension DataDownloadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DataDownloading, $Out> {
  DataDownloadingCopyWith<$R, DataDownloading, $Out> get $asDataDownloading =>
      $base.as((v, t, t2) => _DataDownloadingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DataDownloadingCopyWith<$R, $In extends DataDownloading, $Out>
    implements DataReadinessCopyWith<$R, $In, $Out> {
  @override
  $R call();
  DataDownloadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DataDownloadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DataDownloading, $Out>
    implements DataDownloadingCopyWith<$R, DataDownloading, $Out> {
  _DataDownloadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DataDownloading> $mapper =
      DataDownloadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DataDownloading $make(CopyWithData data) => DataDownloading();

  @override
  DataDownloadingCopyWith<$R2, DataDownloading, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DataDownloadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DataUnavailableMapper extends ClassMapperBase<DataUnavailable> {
  DataUnavailableMapper._();

  static DataUnavailableMapper? _instance;
  static DataUnavailableMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DataUnavailableMapper._());
      DataReadinessMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DataUnavailable';

  static DataUnavailableReason _$reason(DataUnavailable v) => v.reason;
  static const Field<DataUnavailable, DataUnavailableReason> _f$reason = Field(
    'reason',
    _$reason,
  );

  @override
  final MappableFields<DataUnavailable> fields = const {#reason: _f$reason};

  static DataUnavailable _instantiate(DecodingData data) {
    return DataUnavailable(reason: data.dec(_f$reason));
  }

  @override
  final Function instantiate = _instantiate;

  static DataUnavailable fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DataUnavailable>(map);
  }

  static DataUnavailable fromJson(String json) {
    return ensureInitialized().decodeJson<DataUnavailable>(json);
  }
}

mixin DataUnavailableMappable {
  String toJson() {
    return DataUnavailableMapper.ensureInitialized()
        .encodeJson<DataUnavailable>(this as DataUnavailable);
  }

  Map<String, dynamic> toMap() {
    return DataUnavailableMapper.ensureInitialized().encodeMap<DataUnavailable>(
      this as DataUnavailable,
    );
  }

  DataUnavailableCopyWith<DataUnavailable, DataUnavailable, DataUnavailable>
  get copyWith =>
      _DataUnavailableCopyWithImpl<DataUnavailable, DataUnavailable>(
        this as DataUnavailable,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DataUnavailableMapper.ensureInitialized().stringifyValue(
      this as DataUnavailable,
    );
  }

  @override
  bool operator ==(Object other) {
    return DataUnavailableMapper.ensureInitialized().equalsValue(
      this as DataUnavailable,
      other,
    );
  }

  @override
  int get hashCode {
    return DataUnavailableMapper.ensureInitialized().hashValue(
      this as DataUnavailable,
    );
  }
}

extension DataUnavailableValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DataUnavailable, $Out> {
  DataUnavailableCopyWith<$R, DataUnavailable, $Out> get $asDataUnavailable =>
      $base.as((v, t, t2) => _DataUnavailableCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DataUnavailableCopyWith<$R, $In extends DataUnavailable, $Out>
    implements DataReadinessCopyWith<$R, $In, $Out> {
  @override
  $R call({DataUnavailableReason? reason});
  DataUnavailableCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DataUnavailableCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DataUnavailable, $Out>
    implements DataUnavailableCopyWith<$R, DataUnavailable, $Out> {
  _DataUnavailableCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DataUnavailable> $mapper =
      DataUnavailableMapper.ensureInitialized();
  @override
  $R call({DataUnavailableReason? reason}) =>
      $apply(FieldCopyWithData({if (reason != null) #reason: reason}));
  @override
  DataUnavailable $make(CopyWithData data) =>
      DataUnavailable(reason: data.get(#reason, or: $value.reason));

  @override
  DataUnavailableCopyWith<$R2, DataUnavailable, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DataUnavailableCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

