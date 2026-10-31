// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'language_words_state.dart';

class LanguageWordsOptionMapper extends EnumMapper<LanguageWordsOption> {
  LanguageWordsOptionMapper._();

  static LanguageWordsOptionMapper? _instance;
  static LanguageWordsOptionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageWordsOptionMapper._());
    }
    return _instance!;
  }

  static LanguageWordsOption fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  LanguageWordsOption decode(dynamic value) {
    switch (value) {
      case r'all':
        return LanguageWordsOption.all;
      case r'choose':
        return LanguageWordsOption.choose;
      case r'none':
        return LanguageWordsOption.none;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(LanguageWordsOption self) {
    switch (self) {
      case LanguageWordsOption.all:
        return r'all';
      case LanguageWordsOption.choose:
        return r'choose';
      case LanguageWordsOption.none:
        return r'none';
    }
  }
}

extension LanguageWordsOptionMapperExtension on LanguageWordsOption {
  String toValue() {
    LanguageWordsOptionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<LanguageWordsOption>(this) as String;
  }
}

class LanguageWordsStateMapper extends ClassMapperBase<LanguageWordsState> {
  LanguageWordsStateMapper._();

  static LanguageWordsStateMapper? _instance;
  static LanguageWordsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageWordsStateMapper._());
      LanguageWordsLoadingMapper.ensureInitialized();
      LanguageWordsEditingMapper.ensureInitialized();
      LanguageWordsSavedMapper.ensureInitialized();
      LanguageWordsFailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageWordsState';

  @override
  final MappableFields<LanguageWordsState> fields = const {};

  static LanguageWordsState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('LanguageWordsState');
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageWordsState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageWordsState>(map);
  }

  static LanguageWordsState fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageWordsState>(json);
  }
}

mixin LanguageWordsStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  LanguageWordsStateCopyWith<
    LanguageWordsState,
    LanguageWordsState,
    LanguageWordsState
  >
  get copyWith;
}

abstract class LanguageWordsStateCopyWith<
  $R,
  $In extends LanguageWordsState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  LanguageWordsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class LanguageWordsLoadingMapper extends ClassMapperBase<LanguageWordsLoading> {
  LanguageWordsLoadingMapper._();

  static LanguageWordsLoadingMapper? _instance;
  static LanguageWordsLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageWordsLoadingMapper._());
      LanguageWordsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageWordsLoading';

  @override
  final MappableFields<LanguageWordsLoading> fields = const {};

  static LanguageWordsLoading _instantiate(DecodingData data) {
    return LanguageWordsLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageWordsLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageWordsLoading>(map);
  }

  static LanguageWordsLoading fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageWordsLoading>(json);
  }
}

mixin LanguageWordsLoadingMappable {
  String toJson() {
    return LanguageWordsLoadingMapper.ensureInitialized()
        .encodeJson<LanguageWordsLoading>(this as LanguageWordsLoading);
  }

  Map<String, dynamic> toMap() {
    return LanguageWordsLoadingMapper.ensureInitialized()
        .encodeMap<LanguageWordsLoading>(this as LanguageWordsLoading);
  }

  LanguageWordsLoadingCopyWith<
    LanguageWordsLoading,
    LanguageWordsLoading,
    LanguageWordsLoading
  >
  get copyWith =>
      _LanguageWordsLoadingCopyWithImpl<
        LanguageWordsLoading,
        LanguageWordsLoading
      >(this as LanguageWordsLoading, $identity, $identity);
  @override
  String toString() {
    return LanguageWordsLoadingMapper.ensureInitialized().stringifyValue(
      this as LanguageWordsLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageWordsLoadingMapper.ensureInitialized().equalsValue(
      this as LanguageWordsLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageWordsLoadingMapper.ensureInitialized().hashValue(
      this as LanguageWordsLoading,
    );
  }
}

extension LanguageWordsLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageWordsLoading, $Out> {
  LanguageWordsLoadingCopyWith<$R, LanguageWordsLoading, $Out>
  get $asLanguageWordsLoading => $base.as(
    (v, t, t2) => _LanguageWordsLoadingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageWordsLoadingCopyWith<
  $R,
  $In extends LanguageWordsLoading,
  $Out
>
    implements LanguageWordsStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LanguageWordsLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageWordsLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageWordsLoading, $Out>
    implements LanguageWordsLoadingCopyWith<$R, LanguageWordsLoading, $Out> {
  _LanguageWordsLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageWordsLoading> $mapper =
      LanguageWordsLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LanguageWordsLoading $make(CopyWithData data) => LanguageWordsLoading();

  @override
  LanguageWordsLoadingCopyWith<$R2, LanguageWordsLoading, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageWordsLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LanguageWordsEditingMapper extends ClassMapperBase<LanguageWordsEditing> {
  LanguageWordsEditingMapper._();

  static LanguageWordsEditingMapper? _instance;
  static LanguageWordsEditingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageWordsEditingMapper._());
      LanguageWordsStateMapper.ensureInitialized();
      LanguageCoverageMapper.ensureInitialized();
      LanguageWordsOptionMapper.ensureInitialized();
      NewWordLimitMapper.ensureInitialized();
      LanguageWordsPreviewMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageWordsEditing';

  static Language _$language(LanguageWordsEditing v) => v.language;
  static const Field<LanguageWordsEditing, Language> _f$language = Field(
    'language',
    _$language,
  );
  static bool _$isAdding(LanguageWordsEditing v) => v.isAdding;
  static const Field<LanguageWordsEditing, bool> _f$isAdding = Field(
    'isAdding',
    _$isAdding,
  );
  static LanguageCoverage _$coverage(LanguageWordsEditing v) => v.coverage;
  static const Field<LanguageWordsEditing, LanguageCoverage> _f$coverage =
      Field('coverage', _$coverage);
  static LanguageWordsOption _$option(LanguageWordsEditing v) => v.option;
  static const Field<LanguageWordsEditing, LanguageWordsOption> _f$option =
      Field('option', _$option);
  static Map<String, bool?> _$initialSelection(LanguageWordsEditing v) =>
      v.initialSelection;
  static const Field<LanguageWordsEditing, Map<String, bool?>>
  _f$initialSelection = Field('initialSelection', _$initialSelection);
  static Map<String, bool?> _$selection(LanguageWordsEditing v) => v.selection;
  static const Field<LanguageWordsEditing, Map<String, bool?>> _f$selection =
      Field('selection', _$selection);
  static bool? _$initialUntagged(LanguageWordsEditing v) => v.initialUntagged;
  static const Field<LanguageWordsEditing, bool> _f$initialUntagged = Field(
    'initialUntagged',
    _$initialUntagged,
  );
  static bool? _$untagged(LanguageWordsEditing v) => v.untagged;
  static const Field<LanguageWordsEditing, bool> _f$untagged = Field(
    'untagged',
    _$untagged,
  );
  static NewWordLimit _$newWords(LanguageWordsEditing v) => v.newWords;
  static const Field<LanguageWordsEditing, NewWordLimit> _f$newWords = Field(
    'newWords',
    _$newWords,
  );
  static LanguageWordsPreview? _$preview(LanguageWordsEditing v) => v.preview;
  static const Field<LanguageWordsEditing, LanguageWordsPreview> _f$preview =
      Field('preview', _$preview);
  static bool _$isSaving(LanguageWordsEditing v) => v.isSaving;
  static const Field<LanguageWordsEditing, bool> _f$isSaving = Field(
    'isSaving',
    _$isSaving,
  );
  static AppError? _$error(LanguageWordsEditing v) => v.error;
  static const Field<LanguageWordsEditing, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<LanguageWordsEditing> fields = const {
    #language: _f$language,
    #isAdding: _f$isAdding,
    #coverage: _f$coverage,
    #option: _f$option,
    #initialSelection: _f$initialSelection,
    #selection: _f$selection,
    #initialUntagged: _f$initialUntagged,
    #untagged: _f$untagged,
    #newWords: _f$newWords,
    #preview: _f$preview,
    #isSaving: _f$isSaving,
    #error: _f$error,
  };

  static LanguageWordsEditing _instantiate(DecodingData data) {
    return LanguageWordsEditing(
      language: data.dec(_f$language),
      isAdding: data.dec(_f$isAdding),
      coverage: data.dec(_f$coverage),
      option: data.dec(_f$option),
      initialSelection: data.dec(_f$initialSelection),
      selection: data.dec(_f$selection),
      initialUntagged: data.dec(_f$initialUntagged),
      untagged: data.dec(_f$untagged),
      newWords: data.dec(_f$newWords),
      preview: data.dec(_f$preview),
      isSaving: data.dec(_f$isSaving),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageWordsEditing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageWordsEditing>(map);
  }

  static LanguageWordsEditing fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageWordsEditing>(json);
  }
}

mixin LanguageWordsEditingMappable {
  String toJson() {
    return LanguageWordsEditingMapper.ensureInitialized()
        .encodeJson<LanguageWordsEditing>(this as LanguageWordsEditing);
  }

  Map<String, dynamic> toMap() {
    return LanguageWordsEditingMapper.ensureInitialized()
        .encodeMap<LanguageWordsEditing>(this as LanguageWordsEditing);
  }

  LanguageWordsEditingCopyWith<
    LanguageWordsEditing,
    LanguageWordsEditing,
    LanguageWordsEditing
  >
  get copyWith =>
      _LanguageWordsEditingCopyWithImpl<
        LanguageWordsEditing,
        LanguageWordsEditing
      >(this as LanguageWordsEditing, $identity, $identity);
  @override
  String toString() {
    return LanguageWordsEditingMapper.ensureInitialized().stringifyValue(
      this as LanguageWordsEditing,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageWordsEditingMapper.ensureInitialized().equalsValue(
      this as LanguageWordsEditing,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageWordsEditingMapper.ensureInitialized().hashValue(
      this as LanguageWordsEditing,
    );
  }
}

extension LanguageWordsEditingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageWordsEditing, $Out> {
  LanguageWordsEditingCopyWith<$R, LanguageWordsEditing, $Out>
  get $asLanguageWordsEditing => $base.as(
    (v, t, t2) => _LanguageWordsEditingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageWordsEditingCopyWith<
  $R,
  $In extends LanguageWordsEditing,
  $Out
>
    implements LanguageWordsStateCopyWith<$R, $In, $Out> {
  LanguageCoverageCopyWith<$R, LanguageCoverage, LanguageCoverage> get coverage;
  MapCopyWith<$R, String, bool?, ObjectCopyWith<$R, bool?, bool?>?>
  get initialSelection;
  MapCopyWith<$R, String, bool?, ObjectCopyWith<$R, bool?, bool?>?>
  get selection;
  NewWordLimitCopyWith<$R, NewWordLimit, NewWordLimit> get newWords;
  LanguageWordsPreviewCopyWith<$R, LanguageWordsPreview, LanguageWordsPreview>?
  get preview;
  @override
  $R call({
    Language? language,
    bool? isAdding,
    LanguageCoverage? coverage,
    LanguageWordsOption? option,
    Map<String, bool?>? initialSelection,
    Map<String, bool?>? selection,
    bool? initialUntagged,
    bool? untagged,
    NewWordLimit? newWords,
    LanguageWordsPreview? preview,
    bool? isSaving,
    AppError? error,
  });
  LanguageWordsEditingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageWordsEditingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageWordsEditing, $Out>
    implements LanguageWordsEditingCopyWith<$R, LanguageWordsEditing, $Out> {
  _LanguageWordsEditingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageWordsEditing> $mapper =
      LanguageWordsEditingMapper.ensureInitialized();
  @override
  LanguageCoverageCopyWith<$R, LanguageCoverage, LanguageCoverage>
  get coverage => $value.coverage.copyWith.$chain((v) => call(coverage: v));
  @override
  MapCopyWith<$R, String, bool?, ObjectCopyWith<$R, bool?, bool?>?>
  get initialSelection => MapCopyWith(
    $value.initialSelection,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(initialSelection: v),
  );
  @override
  MapCopyWith<$R, String, bool?, ObjectCopyWith<$R, bool?, bool?>?>
  get selection => MapCopyWith(
    $value.selection,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(selection: v),
  );
  @override
  NewWordLimitCopyWith<$R, NewWordLimit, NewWordLimit> get newWords =>
      $value.newWords.copyWith.$chain((v) => call(newWords: v));
  @override
  LanguageWordsPreviewCopyWith<$R, LanguageWordsPreview, LanguageWordsPreview>?
  get preview => $value.preview?.copyWith.$chain((v) => call(preview: v));
  @override
  $R call({
    Language? language,
    bool? isAdding,
    LanguageCoverage? coverage,
    LanguageWordsOption? option,
    Map<String, bool?>? initialSelection,
    Map<String, bool?>? selection,
    Object? initialUntagged = $none,
    Object? untagged = $none,
    NewWordLimit? newWords,
    Object? preview = $none,
    bool? isSaving,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (language != null) #language: language,
      if (isAdding != null) #isAdding: isAdding,
      if (coverage != null) #coverage: coverage,
      if (option != null) #option: option,
      if (initialSelection != null) #initialSelection: initialSelection,
      if (selection != null) #selection: selection,
      if (initialUntagged != $none) #initialUntagged: initialUntagged,
      if (untagged != $none) #untagged: untagged,
      if (newWords != null) #newWords: newWords,
      if (preview != $none) #preview: preview,
      if (isSaving != null) #isSaving: isSaving,
      if (error != $none) #error: error,
    }),
  );
  @override
  LanguageWordsEditing $make(CopyWithData data) => LanguageWordsEditing(
    language: data.get(#language, or: $value.language),
    isAdding: data.get(#isAdding, or: $value.isAdding),
    coverage: data.get(#coverage, or: $value.coverage),
    option: data.get(#option, or: $value.option),
    initialSelection: data.get(#initialSelection, or: $value.initialSelection),
    selection: data.get(#selection, or: $value.selection),
    initialUntagged: data.get(#initialUntagged, or: $value.initialUntagged),
    untagged: data.get(#untagged, or: $value.untagged),
    newWords: data.get(#newWords, or: $value.newWords),
    preview: data.get(#preview, or: $value.preview),
    isSaving: data.get(#isSaving, or: $value.isSaving),
    error: data.get(#error, or: $value.error),
  );

  @override
  LanguageWordsEditingCopyWith<$R2, LanguageWordsEditing, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageWordsEditingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LanguageWordsSavedMapper extends ClassMapperBase<LanguageWordsSaved> {
  LanguageWordsSavedMapper._();

  static LanguageWordsSavedMapper? _instance;
  static LanguageWordsSavedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageWordsSavedMapper._());
      LanguageWordsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageWordsSaved';

  @override
  final MappableFields<LanguageWordsSaved> fields = const {};

  static LanguageWordsSaved _instantiate(DecodingData data) {
    return LanguageWordsSaved();
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageWordsSaved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageWordsSaved>(map);
  }

  static LanguageWordsSaved fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageWordsSaved>(json);
  }
}

mixin LanguageWordsSavedMappable {
  String toJson() {
    return LanguageWordsSavedMapper.ensureInitialized()
        .encodeJson<LanguageWordsSaved>(this as LanguageWordsSaved);
  }

  Map<String, dynamic> toMap() {
    return LanguageWordsSavedMapper.ensureInitialized()
        .encodeMap<LanguageWordsSaved>(this as LanguageWordsSaved);
  }

  LanguageWordsSavedCopyWith<
    LanguageWordsSaved,
    LanguageWordsSaved,
    LanguageWordsSaved
  >
  get copyWith =>
      _LanguageWordsSavedCopyWithImpl<LanguageWordsSaved, LanguageWordsSaved>(
        this as LanguageWordsSaved,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LanguageWordsSavedMapper.ensureInitialized().stringifyValue(
      this as LanguageWordsSaved,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageWordsSavedMapper.ensureInitialized().equalsValue(
      this as LanguageWordsSaved,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageWordsSavedMapper.ensureInitialized().hashValue(
      this as LanguageWordsSaved,
    );
  }
}

extension LanguageWordsSavedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageWordsSaved, $Out> {
  LanguageWordsSavedCopyWith<$R, LanguageWordsSaved, $Out>
  get $asLanguageWordsSaved => $base.as(
    (v, t, t2) => _LanguageWordsSavedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageWordsSavedCopyWith<
  $R,
  $In extends LanguageWordsSaved,
  $Out
>
    implements LanguageWordsStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LanguageWordsSavedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageWordsSavedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageWordsSaved, $Out>
    implements LanguageWordsSavedCopyWith<$R, LanguageWordsSaved, $Out> {
  _LanguageWordsSavedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageWordsSaved> $mapper =
      LanguageWordsSavedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LanguageWordsSaved $make(CopyWithData data) => LanguageWordsSaved();

  @override
  LanguageWordsSavedCopyWith<$R2, LanguageWordsSaved, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanguageWordsSavedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LanguageWordsFailureMapper extends ClassMapperBase<LanguageWordsFailure> {
  LanguageWordsFailureMapper._();

  static LanguageWordsFailureMapper? _instance;
  static LanguageWordsFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageWordsFailureMapper._());
      LanguageWordsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageWordsFailure';

  static AppError _$error(LanguageWordsFailure v) => v.error;
  static const Field<LanguageWordsFailure, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<LanguageWordsFailure> fields = const {#error: _f$error};

  static LanguageWordsFailure _instantiate(DecodingData data) {
    return LanguageWordsFailure(error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageWordsFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageWordsFailure>(map);
  }

  static LanguageWordsFailure fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageWordsFailure>(json);
  }
}

mixin LanguageWordsFailureMappable {
  String toJson() {
    return LanguageWordsFailureMapper.ensureInitialized()
        .encodeJson<LanguageWordsFailure>(this as LanguageWordsFailure);
  }

  Map<String, dynamic> toMap() {
    return LanguageWordsFailureMapper.ensureInitialized()
        .encodeMap<LanguageWordsFailure>(this as LanguageWordsFailure);
  }

  LanguageWordsFailureCopyWith<
    LanguageWordsFailure,
    LanguageWordsFailure,
    LanguageWordsFailure
  >
  get copyWith =>
      _LanguageWordsFailureCopyWithImpl<
        LanguageWordsFailure,
        LanguageWordsFailure
      >(this as LanguageWordsFailure, $identity, $identity);
  @override
  String toString() {
    return LanguageWordsFailureMapper.ensureInitialized().stringifyValue(
      this as LanguageWordsFailure,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageWordsFailureMapper.ensureInitialized().equalsValue(
      this as LanguageWordsFailure,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageWordsFailureMapper.ensureInitialized().hashValue(
      this as LanguageWordsFailure,
    );
  }
}

extension LanguageWordsFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageWordsFailure, $Out> {
  LanguageWordsFailureCopyWith<$R, LanguageWordsFailure, $Out>
  get $asLanguageWordsFailure => $base.as(
    (v, t, t2) => _LanguageWordsFailureCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageWordsFailureCopyWith<
  $R,
  $In extends LanguageWordsFailure,
  $Out
>
    implements LanguageWordsStateCopyWith<$R, $In, $Out> {
  @override
  $R call({AppError? error});
  LanguageWordsFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageWordsFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageWordsFailure, $Out>
    implements LanguageWordsFailureCopyWith<$R, LanguageWordsFailure, $Out> {
  _LanguageWordsFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageWordsFailure> $mapper =
      LanguageWordsFailureMapper.ensureInitialized();
  @override
  $R call({AppError? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  LanguageWordsFailure $make(CopyWithData data) =>
      LanguageWordsFailure(error: data.get(#error, or: $value.error));

  @override
  LanguageWordsFailureCopyWith<$R2, LanguageWordsFailure, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageWordsFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

