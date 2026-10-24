// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'language_selection_state.dart';

class LanguageSelectionStateMapper
    extends ClassMapperBase<LanguageSelectionState> {
  LanguageSelectionStateMapper._();

  static LanguageSelectionStateMapper? _instance;
  static LanguageSelectionStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageSelectionStateMapper._());
      LanguageSelectionLoadingMapper.ensureInitialized();
      LanguageSelectionEditingMapper.ensureInitialized();
      LanguageSelectionSavedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageSelectionState';

  @override
  final MappableFields<LanguageSelectionState> fields = const {};

  static LanguageSelectionState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('LanguageSelectionState');
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageSelectionState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageSelectionState>(map);
  }

  static LanguageSelectionState fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageSelectionState>(json);
  }
}

mixin LanguageSelectionStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  LanguageSelectionStateCopyWith<
    LanguageSelectionState,
    LanguageSelectionState,
    LanguageSelectionState
  >
  get copyWith;
}

abstract class LanguageSelectionStateCopyWith<
  $R,
  $In extends LanguageSelectionState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  LanguageSelectionStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class LanguageSelectionLoadingMapper
    extends ClassMapperBase<LanguageSelectionLoading> {
  LanguageSelectionLoadingMapper._();

  static LanguageSelectionLoadingMapper? _instance;
  static LanguageSelectionLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LanguageSelectionLoadingMapper._(),
      );
      LanguageSelectionStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageSelectionLoading';

  @override
  final MappableFields<LanguageSelectionLoading> fields = const {};

  static LanguageSelectionLoading _instantiate(DecodingData data) {
    return LanguageSelectionLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageSelectionLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageSelectionLoading>(map);
  }

  static LanguageSelectionLoading fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageSelectionLoading>(json);
  }
}

mixin LanguageSelectionLoadingMappable {
  String toJson() {
    return LanguageSelectionLoadingMapper.ensureInitialized()
        .encodeJson<LanguageSelectionLoading>(this as LanguageSelectionLoading);
  }

  Map<String, dynamic> toMap() {
    return LanguageSelectionLoadingMapper.ensureInitialized()
        .encodeMap<LanguageSelectionLoading>(this as LanguageSelectionLoading);
  }

  LanguageSelectionLoadingCopyWith<
    LanguageSelectionLoading,
    LanguageSelectionLoading,
    LanguageSelectionLoading
  >
  get copyWith =>
      _LanguageSelectionLoadingCopyWithImpl<
        LanguageSelectionLoading,
        LanguageSelectionLoading
      >(this as LanguageSelectionLoading, $identity, $identity);
  @override
  String toString() {
    return LanguageSelectionLoadingMapper.ensureInitialized().stringifyValue(
      this as LanguageSelectionLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageSelectionLoadingMapper.ensureInitialized().equalsValue(
      this as LanguageSelectionLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageSelectionLoadingMapper.ensureInitialized().hashValue(
      this as LanguageSelectionLoading,
    );
  }
}

extension LanguageSelectionLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageSelectionLoading, $Out> {
  LanguageSelectionLoadingCopyWith<$R, LanguageSelectionLoading, $Out>
  get $asLanguageSelectionLoading => $base.as(
    (v, t, t2) => _LanguageSelectionLoadingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageSelectionLoadingCopyWith<
  $R,
  $In extends LanguageSelectionLoading,
  $Out
>
    implements LanguageSelectionStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LanguageSelectionLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageSelectionLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageSelectionLoading, $Out>
    implements
        LanguageSelectionLoadingCopyWith<$R, LanguageSelectionLoading, $Out> {
  _LanguageSelectionLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageSelectionLoading> $mapper =
      LanguageSelectionLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LanguageSelectionLoading $make(CopyWithData data) =>
      LanguageSelectionLoading();

  @override
  LanguageSelectionLoadingCopyWith<$R2, LanguageSelectionLoading, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageSelectionLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LanguageSelectionEditingMapper
    extends ClassMapperBase<LanguageSelectionEditing> {
  LanguageSelectionEditingMapper._();

  static LanguageSelectionEditingMapper? _instance;
  static LanguageSelectionEditingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LanguageSelectionEditingMapper._(),
      );
      LanguageSelectionStateMapper.ensureInitialized();
      LanguagePairMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageSelectionEditing';

  static LanguagePair _$pair(LanguageSelectionEditing v) => v.pair;
  static const Field<LanguageSelectionEditing, LanguagePair> _f$pair = Field(
    'pair',
    _$pair,
  );
  static bool _$isSaving(LanguageSelectionEditing v) => v.isSaving;
  static const Field<LanguageSelectionEditing, bool> _f$isSaving = Field(
    'isSaving',
    _$isSaving,
  );
  static AppError? _$error(LanguageSelectionEditing v) => v.error;
  static const Field<LanguageSelectionEditing, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<LanguageSelectionEditing> fields = const {
    #pair: _f$pair,
    #isSaving: _f$isSaving,
    #error: _f$error,
  };

  static LanguageSelectionEditing _instantiate(DecodingData data) {
    return LanguageSelectionEditing(
      pair: data.dec(_f$pair),
      isSaving: data.dec(_f$isSaving),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageSelectionEditing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageSelectionEditing>(map);
  }

  static LanguageSelectionEditing fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageSelectionEditing>(json);
  }
}

mixin LanguageSelectionEditingMappable {
  String toJson() {
    return LanguageSelectionEditingMapper.ensureInitialized()
        .encodeJson<LanguageSelectionEditing>(this as LanguageSelectionEditing);
  }

  Map<String, dynamic> toMap() {
    return LanguageSelectionEditingMapper.ensureInitialized()
        .encodeMap<LanguageSelectionEditing>(this as LanguageSelectionEditing);
  }

  LanguageSelectionEditingCopyWith<
    LanguageSelectionEditing,
    LanguageSelectionEditing,
    LanguageSelectionEditing
  >
  get copyWith =>
      _LanguageSelectionEditingCopyWithImpl<
        LanguageSelectionEditing,
        LanguageSelectionEditing
      >(this as LanguageSelectionEditing, $identity, $identity);
  @override
  String toString() {
    return LanguageSelectionEditingMapper.ensureInitialized().stringifyValue(
      this as LanguageSelectionEditing,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageSelectionEditingMapper.ensureInitialized().equalsValue(
      this as LanguageSelectionEditing,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageSelectionEditingMapper.ensureInitialized().hashValue(
      this as LanguageSelectionEditing,
    );
  }
}

extension LanguageSelectionEditingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageSelectionEditing, $Out> {
  LanguageSelectionEditingCopyWith<$R, LanguageSelectionEditing, $Out>
  get $asLanguageSelectionEditing => $base.as(
    (v, t, t2) => _LanguageSelectionEditingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageSelectionEditingCopyWith<
  $R,
  $In extends LanguageSelectionEditing,
  $Out
>
    implements LanguageSelectionStateCopyWith<$R, $In, $Out> {
  LanguagePairCopyWith<$R, LanguagePair, LanguagePair> get pair;
  @override
  $R call({LanguagePair? pair, bool? isSaving, AppError? error});
  LanguageSelectionEditingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageSelectionEditingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageSelectionEditing, $Out>
    implements
        LanguageSelectionEditingCopyWith<$R, LanguageSelectionEditing, $Out> {
  _LanguageSelectionEditingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageSelectionEditing> $mapper =
      LanguageSelectionEditingMapper.ensureInitialized();
  @override
  LanguagePairCopyWith<$R, LanguagePair, LanguagePair> get pair =>
      $value.pair.copyWith.$chain((v) => call(pair: v));
  @override
  $R call({LanguagePair? pair, bool? isSaving, Object? error = $none}) =>
      $apply(
        FieldCopyWithData({
          if (pair != null) #pair: pair,
          if (isSaving != null) #isSaving: isSaving,
          if (error != $none) #error: error,
        }),
      );
  @override
  LanguageSelectionEditing $make(CopyWithData data) => LanguageSelectionEditing(
    pair: data.get(#pair, or: $value.pair),
    isSaving: data.get(#isSaving, or: $value.isSaving),
    error: data.get(#error, or: $value.error),
  );

  @override
  LanguageSelectionEditingCopyWith<$R2, LanguageSelectionEditing, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageSelectionEditingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LanguageSelectionSavedMapper
    extends ClassMapperBase<LanguageSelectionSaved> {
  LanguageSelectionSavedMapper._();

  static LanguageSelectionSavedMapper? _instance;
  static LanguageSelectionSavedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageSelectionSavedMapper._());
      LanguageSelectionStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageSelectionSaved';

  @override
  final MappableFields<LanguageSelectionSaved> fields = const {};

  static LanguageSelectionSaved _instantiate(DecodingData data) {
    return LanguageSelectionSaved();
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageSelectionSaved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageSelectionSaved>(map);
  }

  static LanguageSelectionSaved fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageSelectionSaved>(json);
  }
}

mixin LanguageSelectionSavedMappable {
  String toJson() {
    return LanguageSelectionSavedMapper.ensureInitialized()
        .encodeJson<LanguageSelectionSaved>(this as LanguageSelectionSaved);
  }

  Map<String, dynamic> toMap() {
    return LanguageSelectionSavedMapper.ensureInitialized()
        .encodeMap<LanguageSelectionSaved>(this as LanguageSelectionSaved);
  }

  LanguageSelectionSavedCopyWith<
    LanguageSelectionSaved,
    LanguageSelectionSaved,
    LanguageSelectionSaved
  >
  get copyWith =>
      _LanguageSelectionSavedCopyWithImpl<
        LanguageSelectionSaved,
        LanguageSelectionSaved
      >(this as LanguageSelectionSaved, $identity, $identity);
  @override
  String toString() {
    return LanguageSelectionSavedMapper.ensureInitialized().stringifyValue(
      this as LanguageSelectionSaved,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageSelectionSavedMapper.ensureInitialized().equalsValue(
      this as LanguageSelectionSaved,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageSelectionSavedMapper.ensureInitialized().hashValue(
      this as LanguageSelectionSaved,
    );
  }
}

extension LanguageSelectionSavedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageSelectionSaved, $Out> {
  LanguageSelectionSavedCopyWith<$R, LanguageSelectionSaved, $Out>
  get $asLanguageSelectionSaved => $base.as(
    (v, t, t2) => _LanguageSelectionSavedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageSelectionSavedCopyWith<
  $R,
  $In extends LanguageSelectionSaved,
  $Out
>
    implements LanguageSelectionStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LanguageSelectionSavedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageSelectionSavedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageSelectionSaved, $Out>
    implements
        LanguageSelectionSavedCopyWith<$R, LanguageSelectionSaved, $Out> {
  _LanguageSelectionSavedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageSelectionSaved> $mapper =
      LanguageSelectionSavedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LanguageSelectionSaved $make(CopyWithData data) => LanguageSelectionSaved();

  @override
  LanguageSelectionSavedCopyWith<$R2, LanguageSelectionSaved, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageSelectionSavedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

