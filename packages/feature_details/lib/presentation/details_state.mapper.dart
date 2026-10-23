// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'details_state.dart';

class DetailsStateMapper extends ClassMapperBase<DetailsState> {
  DetailsStateMapper._();

  static DetailsStateMapper? _instance;
  static DetailsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsStateMapper._());
      DetailsEditingMapper.ensureInitialized();
      DetailsSavingMapper.ensureInitialized();
      DetailsSavedMapper.ensureInitialized();
      DetailsFailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsState';

  @override
  final MappableFields<DetailsState> fields = const {};

  static DetailsState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('DetailsState');
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsState>(map);
  }

  static DetailsState fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsState>(json);
  }
}

mixin DetailsStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  DetailsStateCopyWith<DetailsState, DetailsState, DetailsState> get copyWith;
}

abstract class DetailsStateCopyWith<$R, $In extends DetailsState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  DetailsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class DetailsEditingMapper extends ClassMapperBase<DetailsEditing> {
  DetailsEditingMapper._();

  static DetailsEditingMapper? _instance;
  static DetailsEditingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsEditingMapper._());
      DetailsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsEditing';

  @override
  final MappableFields<DetailsEditing> fields = const {};

  static DetailsEditing _instantiate(DecodingData data) {
    return DetailsEditing();
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsEditing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsEditing>(map);
  }

  static DetailsEditing fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsEditing>(json);
  }
}

mixin DetailsEditingMappable {
  String toJson() {
    return DetailsEditingMapper.ensureInitialized().encodeJson<DetailsEditing>(
      this as DetailsEditing,
    );
  }

  Map<String, dynamic> toMap() {
    return DetailsEditingMapper.ensureInitialized().encodeMap<DetailsEditing>(
      this as DetailsEditing,
    );
  }

  DetailsEditingCopyWith<DetailsEditing, DetailsEditing, DetailsEditing>
  get copyWith => _DetailsEditingCopyWithImpl<DetailsEditing, DetailsEditing>(
    this as DetailsEditing,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DetailsEditingMapper.ensureInitialized().stringifyValue(
      this as DetailsEditing,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsEditingMapper.ensureInitialized().equalsValue(
      this as DetailsEditing,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsEditingMapper.ensureInitialized().hashValue(
      this as DetailsEditing,
    );
  }
}

extension DetailsEditingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsEditing, $Out> {
  DetailsEditingCopyWith<$R, DetailsEditing, $Out> get $asDetailsEditing =>
      $base.as((v, t, t2) => _DetailsEditingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsEditingCopyWith<$R, $In extends DetailsEditing, $Out>
    implements DetailsStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  DetailsEditingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DetailsEditingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsEditing, $Out>
    implements DetailsEditingCopyWith<$R, DetailsEditing, $Out> {
  _DetailsEditingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsEditing> $mapper =
      DetailsEditingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DetailsEditing $make(CopyWithData data) => DetailsEditing();

  @override
  DetailsEditingCopyWith<$R2, DetailsEditing, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsEditingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsSavingMapper extends ClassMapperBase<DetailsSaving> {
  DetailsSavingMapper._();

  static DetailsSavingMapper? _instance;
  static DetailsSavingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsSavingMapper._());
      DetailsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsSaving';

  @override
  final MappableFields<DetailsSaving> fields = const {};

  static DetailsSaving _instantiate(DecodingData data) {
    return DetailsSaving();
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsSaving fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsSaving>(map);
  }

  static DetailsSaving fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsSaving>(json);
  }
}

mixin DetailsSavingMappable {
  String toJson() {
    return DetailsSavingMapper.ensureInitialized().encodeJson<DetailsSaving>(
      this as DetailsSaving,
    );
  }

  Map<String, dynamic> toMap() {
    return DetailsSavingMapper.ensureInitialized().encodeMap<DetailsSaving>(
      this as DetailsSaving,
    );
  }

  DetailsSavingCopyWith<DetailsSaving, DetailsSaving, DetailsSaving>
  get copyWith => _DetailsSavingCopyWithImpl<DetailsSaving, DetailsSaving>(
    this as DetailsSaving,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DetailsSavingMapper.ensureInitialized().stringifyValue(
      this as DetailsSaving,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsSavingMapper.ensureInitialized().equalsValue(
      this as DetailsSaving,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsSavingMapper.ensureInitialized().hashValue(
      this as DetailsSaving,
    );
  }
}

extension DetailsSavingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsSaving, $Out> {
  DetailsSavingCopyWith<$R, DetailsSaving, $Out> get $asDetailsSaving =>
      $base.as((v, t, t2) => _DetailsSavingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsSavingCopyWith<$R, $In extends DetailsSaving, $Out>
    implements DetailsStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  DetailsSavingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DetailsSavingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsSaving, $Out>
    implements DetailsSavingCopyWith<$R, DetailsSaving, $Out> {
  _DetailsSavingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsSaving> $mapper =
      DetailsSavingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DetailsSaving $make(CopyWithData data) => DetailsSaving();

  @override
  DetailsSavingCopyWith<$R2, DetailsSaving, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsSavingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsSavedMapper extends ClassMapperBase<DetailsSaved> {
  DetailsSavedMapper._();

  static DetailsSavedMapper? _instance;
  static DetailsSavedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsSavedMapper._());
      DetailsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsSaved';

  @override
  final MappableFields<DetailsSaved> fields = const {};

  static DetailsSaved _instantiate(DecodingData data) {
    return DetailsSaved();
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsSaved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsSaved>(map);
  }

  static DetailsSaved fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsSaved>(json);
  }
}

mixin DetailsSavedMappable {
  String toJson() {
    return DetailsSavedMapper.ensureInitialized().encodeJson<DetailsSaved>(
      this as DetailsSaved,
    );
  }

  Map<String, dynamic> toMap() {
    return DetailsSavedMapper.ensureInitialized().encodeMap<DetailsSaved>(
      this as DetailsSaved,
    );
  }

  DetailsSavedCopyWith<DetailsSaved, DetailsSaved, DetailsSaved> get copyWith =>
      _DetailsSavedCopyWithImpl<DetailsSaved, DetailsSaved>(
        this as DetailsSaved,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DetailsSavedMapper.ensureInitialized().stringifyValue(
      this as DetailsSaved,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsSavedMapper.ensureInitialized().equalsValue(
      this as DetailsSaved,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsSavedMapper.ensureInitialized().hashValue(
      this as DetailsSaved,
    );
  }
}

extension DetailsSavedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsSaved, $Out> {
  DetailsSavedCopyWith<$R, DetailsSaved, $Out> get $asDetailsSaved =>
      $base.as((v, t, t2) => _DetailsSavedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsSavedCopyWith<$R, $In extends DetailsSaved, $Out>
    implements DetailsStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  DetailsSavedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DetailsSavedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsSaved, $Out>
    implements DetailsSavedCopyWith<$R, DetailsSaved, $Out> {
  _DetailsSavedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsSaved> $mapper =
      DetailsSavedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DetailsSaved $make(CopyWithData data) => DetailsSaved();

  @override
  DetailsSavedCopyWith<$R2, DetailsSaved, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsSavedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsFailureMapper extends ClassMapperBase<DetailsFailure> {
  DetailsFailureMapper._();

  static DetailsFailureMapper? _instance;
  static DetailsFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsFailureMapper._());
      DetailsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsFailure';

  static AppError _$error(DetailsFailure v) => v.error;
  static const Field<DetailsFailure, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<DetailsFailure> fields = const {#error: _f$error};

  static DetailsFailure _instantiate(DecodingData data) {
    return DetailsFailure(error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsFailure>(map);
  }

  static DetailsFailure fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsFailure>(json);
  }
}

mixin DetailsFailureMappable {
  String toJson() {
    return DetailsFailureMapper.ensureInitialized().encodeJson<DetailsFailure>(
      this as DetailsFailure,
    );
  }

  Map<String, dynamic> toMap() {
    return DetailsFailureMapper.ensureInitialized().encodeMap<DetailsFailure>(
      this as DetailsFailure,
    );
  }

  DetailsFailureCopyWith<DetailsFailure, DetailsFailure, DetailsFailure>
  get copyWith => _DetailsFailureCopyWithImpl<DetailsFailure, DetailsFailure>(
    this as DetailsFailure,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DetailsFailureMapper.ensureInitialized().stringifyValue(
      this as DetailsFailure,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsFailureMapper.ensureInitialized().equalsValue(
      this as DetailsFailure,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsFailureMapper.ensureInitialized().hashValue(
      this as DetailsFailure,
    );
  }
}

extension DetailsFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsFailure, $Out> {
  DetailsFailureCopyWith<$R, DetailsFailure, $Out> get $asDetailsFailure =>
      $base.as((v, t, t2) => _DetailsFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsFailureCopyWith<$R, $In extends DetailsFailure, $Out>
    implements DetailsStateCopyWith<$R, $In, $Out> {
  @override
  $R call({AppError? error});
  DetailsFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DetailsFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsFailure, $Out>
    implements DetailsFailureCopyWith<$R, DetailsFailure, $Out> {
  _DetailsFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsFailure> $mapper =
      DetailsFailureMapper.ensureInitialized();
  @override
  $R call({AppError? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  DetailsFailure $make(CopyWithData data) =>
      DetailsFailure(error: data.get(#error, or: $value.error));

  @override
  DetailsFailureCopyWith<$R2, DetailsFailure, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

