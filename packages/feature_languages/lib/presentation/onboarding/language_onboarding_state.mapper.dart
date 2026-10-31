// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'language_onboarding_state.dart';

class LanguageOnboardingStateMapper
    extends ClassMapperBase<LanguageOnboardingState> {
  LanguageOnboardingStateMapper._();

  static LanguageOnboardingStateMapper? _instance;
  static LanguageOnboardingStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LanguageOnboardingStateMapper._(),
      );
      LanguageOnboardingLoadingMapper.ensureInitialized();
      LanguageOnboardingEditingMapper.ensureInitialized();
      LanguageOnboardingSavedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageOnboardingState';

  @override
  final MappableFields<LanguageOnboardingState> fields = const {};

  static LanguageOnboardingState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('LanguageOnboardingState');
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageOnboardingState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageOnboardingState>(map);
  }

  static LanguageOnboardingState fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageOnboardingState>(json);
  }
}

mixin LanguageOnboardingStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  LanguageOnboardingStateCopyWith<
    LanguageOnboardingState,
    LanguageOnboardingState,
    LanguageOnboardingState
  >
  get copyWith;
}

abstract class LanguageOnboardingStateCopyWith<
  $R,
  $In extends LanguageOnboardingState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  LanguageOnboardingStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class LanguageOnboardingLoadingMapper
    extends ClassMapperBase<LanguageOnboardingLoading> {
  LanguageOnboardingLoadingMapper._();

  static LanguageOnboardingLoadingMapper? _instance;
  static LanguageOnboardingLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LanguageOnboardingLoadingMapper._(),
      );
      LanguageOnboardingStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageOnboardingLoading';

  @override
  final MappableFields<LanguageOnboardingLoading> fields = const {};

  static LanguageOnboardingLoading _instantiate(DecodingData data) {
    return LanguageOnboardingLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageOnboardingLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageOnboardingLoading>(map);
  }

  static LanguageOnboardingLoading fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageOnboardingLoading>(json);
  }
}

mixin LanguageOnboardingLoadingMappable {
  String toJson() {
    return LanguageOnboardingLoadingMapper.ensureInitialized()
        .encodeJson<LanguageOnboardingLoading>(
          this as LanguageOnboardingLoading,
        );
  }

  Map<String, dynamic> toMap() {
    return LanguageOnboardingLoadingMapper.ensureInitialized()
        .encodeMap<LanguageOnboardingLoading>(
          this as LanguageOnboardingLoading,
        );
  }

  LanguageOnboardingLoadingCopyWith<
    LanguageOnboardingLoading,
    LanguageOnboardingLoading,
    LanguageOnboardingLoading
  >
  get copyWith =>
      _LanguageOnboardingLoadingCopyWithImpl<
        LanguageOnboardingLoading,
        LanguageOnboardingLoading
      >(this as LanguageOnboardingLoading, $identity, $identity);
  @override
  String toString() {
    return LanguageOnboardingLoadingMapper.ensureInitialized().stringifyValue(
      this as LanguageOnboardingLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageOnboardingLoadingMapper.ensureInitialized().equalsValue(
      this as LanguageOnboardingLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageOnboardingLoadingMapper.ensureInitialized().hashValue(
      this as LanguageOnboardingLoading,
    );
  }
}

extension LanguageOnboardingLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageOnboardingLoading, $Out> {
  LanguageOnboardingLoadingCopyWith<$R, LanguageOnboardingLoading, $Out>
  get $asLanguageOnboardingLoading => $base.as(
    (v, t, t2) => _LanguageOnboardingLoadingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageOnboardingLoadingCopyWith<
  $R,
  $In extends LanguageOnboardingLoading,
  $Out
>
    implements LanguageOnboardingStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LanguageOnboardingLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageOnboardingLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageOnboardingLoading, $Out>
    implements
        LanguageOnboardingLoadingCopyWith<$R, LanguageOnboardingLoading, $Out> {
  _LanguageOnboardingLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageOnboardingLoading> $mapper =
      LanguageOnboardingLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LanguageOnboardingLoading $make(CopyWithData data) =>
      LanguageOnboardingLoading();

  @override
  LanguageOnboardingLoadingCopyWith<$R2, LanguageOnboardingLoading, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageOnboardingLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LanguageOnboardingEditingMapper
    extends ClassMapperBase<LanguageOnboardingEditing> {
  LanguageOnboardingEditingMapper._();

  static LanguageOnboardingEditingMapper? _instance;
  static LanguageOnboardingEditingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LanguageOnboardingEditingMapper._(),
      );
      LanguageOnboardingStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageOnboardingEditing';

  static Language _$main(LanguageOnboardingEditing v) => v.main;
  static const Field<LanguageOnboardingEditing, Language> _f$main = Field(
    'main',
    _$main,
  );
  static List<Language> _$learned(LanguageOnboardingEditing v) => v.learned;
  static const Field<LanguageOnboardingEditing, List<Language>> _f$learned =
      Field('learned', _$learned);
  static bool _$isSaving(LanguageOnboardingEditing v) => v.isSaving;
  static const Field<LanguageOnboardingEditing, bool> _f$isSaving = Field(
    'isSaving',
    _$isSaving,
  );
  static AppError? _$error(LanguageOnboardingEditing v) => v.error;
  static const Field<LanguageOnboardingEditing, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<LanguageOnboardingEditing> fields = const {
    #main: _f$main,
    #learned: _f$learned,
    #isSaving: _f$isSaving,
    #error: _f$error,
  };

  static LanguageOnboardingEditing _instantiate(DecodingData data) {
    return LanguageOnboardingEditing(
      main: data.dec(_f$main),
      learned: data.dec(_f$learned),
      isSaving: data.dec(_f$isSaving),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageOnboardingEditing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageOnboardingEditing>(map);
  }

  static LanguageOnboardingEditing fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageOnboardingEditing>(json);
  }
}

mixin LanguageOnboardingEditingMappable {
  String toJson() {
    return LanguageOnboardingEditingMapper.ensureInitialized()
        .encodeJson<LanguageOnboardingEditing>(
          this as LanguageOnboardingEditing,
        );
  }

  Map<String, dynamic> toMap() {
    return LanguageOnboardingEditingMapper.ensureInitialized()
        .encodeMap<LanguageOnboardingEditing>(
          this as LanguageOnboardingEditing,
        );
  }

  LanguageOnboardingEditingCopyWith<
    LanguageOnboardingEditing,
    LanguageOnboardingEditing,
    LanguageOnboardingEditing
  >
  get copyWith =>
      _LanguageOnboardingEditingCopyWithImpl<
        LanguageOnboardingEditing,
        LanguageOnboardingEditing
      >(this as LanguageOnboardingEditing, $identity, $identity);
  @override
  String toString() {
    return LanguageOnboardingEditingMapper.ensureInitialized().stringifyValue(
      this as LanguageOnboardingEditing,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageOnboardingEditingMapper.ensureInitialized().equalsValue(
      this as LanguageOnboardingEditing,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageOnboardingEditingMapper.ensureInitialized().hashValue(
      this as LanguageOnboardingEditing,
    );
  }
}

extension LanguageOnboardingEditingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageOnboardingEditing, $Out> {
  LanguageOnboardingEditingCopyWith<$R, LanguageOnboardingEditing, $Out>
  get $asLanguageOnboardingEditing => $base.as(
    (v, t, t2) => _LanguageOnboardingEditingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageOnboardingEditingCopyWith<
  $R,
  $In extends LanguageOnboardingEditing,
  $Out
>
    implements LanguageOnboardingStateCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Language, ObjectCopyWith<$R, Language, Language>>
  get learned;
  @override
  $R call({
    Language? main,
    List<Language>? learned,
    bool? isSaving,
    AppError? error,
  });
  LanguageOnboardingEditingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageOnboardingEditingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageOnboardingEditing, $Out>
    implements
        LanguageOnboardingEditingCopyWith<$R, LanguageOnboardingEditing, $Out> {
  _LanguageOnboardingEditingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageOnboardingEditing> $mapper =
      LanguageOnboardingEditingMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Language, ObjectCopyWith<$R, Language, Language>>
  get learned => ListCopyWith(
    $value.learned,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(learned: v),
  );
  @override
  $R call({
    Language? main,
    List<Language>? learned,
    bool? isSaving,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (main != null) #main: main,
      if (learned != null) #learned: learned,
      if (isSaving != null) #isSaving: isSaving,
      if (error != $none) #error: error,
    }),
  );
  @override
  LanguageOnboardingEditing $make(CopyWithData data) =>
      LanguageOnboardingEditing(
        main: data.get(#main, or: $value.main),
        learned: data.get(#learned, or: $value.learned),
        isSaving: data.get(#isSaving, or: $value.isSaving),
        error: data.get(#error, or: $value.error),
      );

  @override
  LanguageOnboardingEditingCopyWith<$R2, LanguageOnboardingEditing, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageOnboardingEditingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LanguageOnboardingSavedMapper
    extends ClassMapperBase<LanguageOnboardingSaved> {
  LanguageOnboardingSavedMapper._();

  static LanguageOnboardingSavedMapper? _instance;
  static LanguageOnboardingSavedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LanguageOnboardingSavedMapper._(),
      );
      LanguageOnboardingStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageOnboardingSaved';

  @override
  final MappableFields<LanguageOnboardingSaved> fields = const {};

  static LanguageOnboardingSaved _instantiate(DecodingData data) {
    return LanguageOnboardingSaved();
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageOnboardingSaved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageOnboardingSaved>(map);
  }

  static LanguageOnboardingSaved fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageOnboardingSaved>(json);
  }
}

mixin LanguageOnboardingSavedMappable {
  String toJson() {
    return LanguageOnboardingSavedMapper.ensureInitialized()
        .encodeJson<LanguageOnboardingSaved>(this as LanguageOnboardingSaved);
  }

  Map<String, dynamic> toMap() {
    return LanguageOnboardingSavedMapper.ensureInitialized()
        .encodeMap<LanguageOnboardingSaved>(this as LanguageOnboardingSaved);
  }

  LanguageOnboardingSavedCopyWith<
    LanguageOnboardingSaved,
    LanguageOnboardingSaved,
    LanguageOnboardingSaved
  >
  get copyWith =>
      _LanguageOnboardingSavedCopyWithImpl<
        LanguageOnboardingSaved,
        LanguageOnboardingSaved
      >(this as LanguageOnboardingSaved, $identity, $identity);
  @override
  String toString() {
    return LanguageOnboardingSavedMapper.ensureInitialized().stringifyValue(
      this as LanguageOnboardingSaved,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageOnboardingSavedMapper.ensureInitialized().equalsValue(
      this as LanguageOnboardingSaved,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageOnboardingSavedMapper.ensureInitialized().hashValue(
      this as LanguageOnboardingSaved,
    );
  }
}

extension LanguageOnboardingSavedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageOnboardingSaved, $Out> {
  LanguageOnboardingSavedCopyWith<$R, LanguageOnboardingSaved, $Out>
  get $asLanguageOnboardingSaved => $base.as(
    (v, t, t2) => _LanguageOnboardingSavedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageOnboardingSavedCopyWith<
  $R,
  $In extends LanguageOnboardingSaved,
  $Out
>
    implements LanguageOnboardingStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LanguageOnboardingSavedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageOnboardingSavedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageOnboardingSaved, $Out>
    implements
        LanguageOnboardingSavedCopyWith<$R, LanguageOnboardingSaved, $Out> {
  _LanguageOnboardingSavedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageOnboardingSaved> $mapper =
      LanguageOnboardingSavedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LanguageOnboardingSaved $make(CopyWithData data) => LanguageOnboardingSaved();

  @override
  LanguageOnboardingSavedCopyWith<$R2, LanguageOnboardingSaved, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageOnboardingSavedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

