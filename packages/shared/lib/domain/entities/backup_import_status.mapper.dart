// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'backup_import_status.dart';

class BackupImportStatusMapper extends ClassMapperBase<BackupImportStatus> {
  BackupImportStatusMapper._();

  static BackupImportStatusMapper? _instance;
  static BackupImportStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BackupImportStatusMapper._());
      BackupImportCancelledMapper.ensureInitialized();
      BackupImportRunningMapper.ensureInitialized();
      BackupImportCompletedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BackupImportStatus';

  @override
  final MappableFields<BackupImportStatus> fields = const {};

  static BackupImportStatus _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('BackupImportStatus');
  }

  @override
  final Function instantiate = _instantiate;

  static BackupImportStatus fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BackupImportStatus>(map);
  }

  static BackupImportStatus fromJson(String json) {
    return ensureInitialized().decodeJson<BackupImportStatus>(json);
  }
}

mixin BackupImportStatusMappable {
  String toJson();
  Map<String, dynamic> toMap();
  BackupImportStatusCopyWith<
    BackupImportStatus,
    BackupImportStatus,
    BackupImportStatus
  >
  get copyWith;
}

abstract class BackupImportStatusCopyWith<
  $R,
  $In extends BackupImportStatus,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  BackupImportStatusCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class BackupImportCancelledMapper
    extends ClassMapperBase<BackupImportCancelled> {
  BackupImportCancelledMapper._();

  static BackupImportCancelledMapper? _instance;
  static BackupImportCancelledMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BackupImportCancelledMapper._());
      BackupImportStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BackupImportCancelled';

  @override
  final MappableFields<BackupImportCancelled> fields = const {};

  static BackupImportCancelled _instantiate(DecodingData data) {
    return BackupImportCancelled();
  }

  @override
  final Function instantiate = _instantiate;

  static BackupImportCancelled fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BackupImportCancelled>(map);
  }

  static BackupImportCancelled fromJson(String json) {
    return ensureInitialized().decodeJson<BackupImportCancelled>(json);
  }
}

mixin BackupImportCancelledMappable {
  String toJson() {
    return BackupImportCancelledMapper.ensureInitialized()
        .encodeJson<BackupImportCancelled>(this as BackupImportCancelled);
  }

  Map<String, dynamic> toMap() {
    return BackupImportCancelledMapper.ensureInitialized()
        .encodeMap<BackupImportCancelled>(this as BackupImportCancelled);
  }

  BackupImportCancelledCopyWith<
    BackupImportCancelled,
    BackupImportCancelled,
    BackupImportCancelled
  >
  get copyWith =>
      _BackupImportCancelledCopyWithImpl<
        BackupImportCancelled,
        BackupImportCancelled
      >(this as BackupImportCancelled, $identity, $identity);
  @override
  String toString() {
    return BackupImportCancelledMapper.ensureInitialized().stringifyValue(
      this as BackupImportCancelled,
    );
  }

  @override
  bool operator ==(Object other) {
    return BackupImportCancelledMapper.ensureInitialized().equalsValue(
      this as BackupImportCancelled,
      other,
    );
  }

  @override
  int get hashCode {
    return BackupImportCancelledMapper.ensureInitialized().hashValue(
      this as BackupImportCancelled,
    );
  }
}

extension BackupImportCancelledValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BackupImportCancelled, $Out> {
  BackupImportCancelledCopyWith<$R, BackupImportCancelled, $Out>
  get $asBackupImportCancelled => $base.as(
    (v, t, t2) => _BackupImportCancelledCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BackupImportCancelledCopyWith<
  $R,
  $In extends BackupImportCancelled,
  $Out
>
    implements BackupImportStatusCopyWith<$R, $In, $Out> {
  @override
  $R call();
  BackupImportCancelledCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BackupImportCancelledCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BackupImportCancelled, $Out>
    implements BackupImportCancelledCopyWith<$R, BackupImportCancelled, $Out> {
  _BackupImportCancelledCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BackupImportCancelled> $mapper =
      BackupImportCancelledMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  BackupImportCancelled $make(CopyWithData data) => BackupImportCancelled();

  @override
  BackupImportCancelledCopyWith<$R2, BackupImportCancelled, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BackupImportCancelledCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BackupImportRunningMapper extends ClassMapperBase<BackupImportRunning> {
  BackupImportRunningMapper._();

  static BackupImportRunningMapper? _instance;
  static BackupImportRunningMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BackupImportRunningMapper._());
      BackupImportStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BackupImportRunning';

  static int _$processedImages(BackupImportRunning v) => v.processedImages;
  static const Field<BackupImportRunning, int> _f$processedImages = Field(
    'processedImages',
    _$processedImages,
  );
  static int _$totalImages(BackupImportRunning v) => v.totalImages;
  static const Field<BackupImportRunning, int> _f$totalImages = Field(
    'totalImages',
    _$totalImages,
  );

  @override
  final MappableFields<BackupImportRunning> fields = const {
    #processedImages: _f$processedImages,
    #totalImages: _f$totalImages,
  };

  static BackupImportRunning _instantiate(DecodingData data) {
    return BackupImportRunning(
      processedImages: data.dec(_f$processedImages),
      totalImages: data.dec(_f$totalImages),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BackupImportRunning fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BackupImportRunning>(map);
  }

  static BackupImportRunning fromJson(String json) {
    return ensureInitialized().decodeJson<BackupImportRunning>(json);
  }
}

mixin BackupImportRunningMappable {
  String toJson() {
    return BackupImportRunningMapper.ensureInitialized()
        .encodeJson<BackupImportRunning>(this as BackupImportRunning);
  }

  Map<String, dynamic> toMap() {
    return BackupImportRunningMapper.ensureInitialized()
        .encodeMap<BackupImportRunning>(this as BackupImportRunning);
  }

  BackupImportRunningCopyWith<
    BackupImportRunning,
    BackupImportRunning,
    BackupImportRunning
  >
  get copyWith =>
      _BackupImportRunningCopyWithImpl<
        BackupImportRunning,
        BackupImportRunning
      >(this as BackupImportRunning, $identity, $identity);
  @override
  String toString() {
    return BackupImportRunningMapper.ensureInitialized().stringifyValue(
      this as BackupImportRunning,
    );
  }

  @override
  bool operator ==(Object other) {
    return BackupImportRunningMapper.ensureInitialized().equalsValue(
      this as BackupImportRunning,
      other,
    );
  }

  @override
  int get hashCode {
    return BackupImportRunningMapper.ensureInitialized().hashValue(
      this as BackupImportRunning,
    );
  }
}

extension BackupImportRunningValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BackupImportRunning, $Out> {
  BackupImportRunningCopyWith<$R, BackupImportRunning, $Out>
  get $asBackupImportRunning => $base.as(
    (v, t, t2) => _BackupImportRunningCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BackupImportRunningCopyWith<
  $R,
  $In extends BackupImportRunning,
  $Out
>
    implements BackupImportStatusCopyWith<$R, $In, $Out> {
  @override
  $R call({int? processedImages, int? totalImages});
  BackupImportRunningCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BackupImportRunningCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BackupImportRunning, $Out>
    implements BackupImportRunningCopyWith<$R, BackupImportRunning, $Out> {
  _BackupImportRunningCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BackupImportRunning> $mapper =
      BackupImportRunningMapper.ensureInitialized();
  @override
  $R call({int? processedImages, int? totalImages}) => $apply(
    FieldCopyWithData({
      if (processedImages != null) #processedImages: processedImages,
      if (totalImages != null) #totalImages: totalImages,
    }),
  );
  @override
  BackupImportRunning $make(CopyWithData data) => BackupImportRunning(
    processedImages: data.get(#processedImages, or: $value.processedImages),
    totalImages: data.get(#totalImages, or: $value.totalImages),
  );

  @override
  BackupImportRunningCopyWith<$R2, BackupImportRunning, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BackupImportRunningCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BackupImportCompletedMapper
    extends ClassMapperBase<BackupImportCompleted> {
  BackupImportCompletedMapper._();

  static BackupImportCompletedMapper? _instance;
  static BackupImportCompletedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BackupImportCompletedMapper._());
      BackupImportStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BackupImportCompleted';

  static int _$importedCount(BackupImportCompleted v) => v.importedCount;
  static const Field<BackupImportCompleted, int> _f$importedCount = Field(
    'importedCount',
    _$importedCount,
  );

  @override
  final MappableFields<BackupImportCompleted> fields = const {
    #importedCount: _f$importedCount,
  };

  static BackupImportCompleted _instantiate(DecodingData data) {
    return BackupImportCompleted(importedCount: data.dec(_f$importedCount));
  }

  @override
  final Function instantiate = _instantiate;

  static BackupImportCompleted fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BackupImportCompleted>(map);
  }

  static BackupImportCompleted fromJson(String json) {
    return ensureInitialized().decodeJson<BackupImportCompleted>(json);
  }
}

mixin BackupImportCompletedMappable {
  String toJson() {
    return BackupImportCompletedMapper.ensureInitialized()
        .encodeJson<BackupImportCompleted>(this as BackupImportCompleted);
  }

  Map<String, dynamic> toMap() {
    return BackupImportCompletedMapper.ensureInitialized()
        .encodeMap<BackupImportCompleted>(this as BackupImportCompleted);
  }

  BackupImportCompletedCopyWith<
    BackupImportCompleted,
    BackupImportCompleted,
    BackupImportCompleted
  >
  get copyWith =>
      _BackupImportCompletedCopyWithImpl<
        BackupImportCompleted,
        BackupImportCompleted
      >(this as BackupImportCompleted, $identity, $identity);
  @override
  String toString() {
    return BackupImportCompletedMapper.ensureInitialized().stringifyValue(
      this as BackupImportCompleted,
    );
  }

  @override
  bool operator ==(Object other) {
    return BackupImportCompletedMapper.ensureInitialized().equalsValue(
      this as BackupImportCompleted,
      other,
    );
  }

  @override
  int get hashCode {
    return BackupImportCompletedMapper.ensureInitialized().hashValue(
      this as BackupImportCompleted,
    );
  }
}

extension BackupImportCompletedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BackupImportCompleted, $Out> {
  BackupImportCompletedCopyWith<$R, BackupImportCompleted, $Out>
  get $asBackupImportCompleted => $base.as(
    (v, t, t2) => _BackupImportCompletedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BackupImportCompletedCopyWith<
  $R,
  $In extends BackupImportCompleted,
  $Out
>
    implements BackupImportStatusCopyWith<$R, $In, $Out> {
  @override
  $R call({int? importedCount});
  BackupImportCompletedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BackupImportCompletedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BackupImportCompleted, $Out>
    implements BackupImportCompletedCopyWith<$R, BackupImportCompleted, $Out> {
  _BackupImportCompletedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BackupImportCompleted> $mapper =
      BackupImportCompletedMapper.ensureInitialized();
  @override
  $R call({int? importedCount}) => $apply(
    FieldCopyWithData({
      if (importedCount != null) #importedCount: importedCount,
    }),
  );
  @override
  BackupImportCompleted $make(CopyWithData data) => BackupImportCompleted(
    importedCount: data.get(#importedCount, or: $value.importedCount),
  );

  @override
  BackupImportCompletedCopyWith<$R2, BackupImportCompleted, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BackupImportCompletedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

