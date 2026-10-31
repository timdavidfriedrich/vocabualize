// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'learned_language_state.dart';

class LearnedLanguageStateMapper extends ClassMapperBase<LearnedLanguageState> {
  LearnedLanguageStateMapper._();

  static LearnedLanguageStateMapper? _instance;
  static LearnedLanguageStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LearnedLanguageStateMapper._());
      LearnedLanguageLoadingMapper.ensureInitialized();
      LearnedLanguageLoadedMapper.ensureInitialized();
      LearnedLanguageClosedMapper.ensureInitialized();
      LearnedLanguageFailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LearnedLanguageState';

  @override
  final MappableFields<LearnedLanguageState> fields = const {};

  static LearnedLanguageState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('LearnedLanguageState');
  }

  @override
  final Function instantiate = _instantiate;

  static LearnedLanguageState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LearnedLanguageState>(map);
  }

  static LearnedLanguageState fromJson(String json) {
    return ensureInitialized().decodeJson<LearnedLanguageState>(json);
  }
}

mixin LearnedLanguageStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  LearnedLanguageStateCopyWith<
    LearnedLanguageState,
    LearnedLanguageState,
    LearnedLanguageState
  >
  get copyWith;
}

abstract class LearnedLanguageStateCopyWith<
  $R,
  $In extends LearnedLanguageState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  LearnedLanguageStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class LearnedLanguageLoadingMapper
    extends ClassMapperBase<LearnedLanguageLoading> {
  LearnedLanguageLoadingMapper._();

  static LearnedLanguageLoadingMapper? _instance;
  static LearnedLanguageLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LearnedLanguageLoadingMapper._());
      LearnedLanguageStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LearnedLanguageLoading';

  @override
  final MappableFields<LearnedLanguageLoading> fields = const {};

  static LearnedLanguageLoading _instantiate(DecodingData data) {
    return LearnedLanguageLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static LearnedLanguageLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LearnedLanguageLoading>(map);
  }

  static LearnedLanguageLoading fromJson(String json) {
    return ensureInitialized().decodeJson<LearnedLanguageLoading>(json);
  }
}

mixin LearnedLanguageLoadingMappable {
  String toJson() {
    return LearnedLanguageLoadingMapper.ensureInitialized()
        .encodeJson<LearnedLanguageLoading>(this as LearnedLanguageLoading);
  }

  Map<String, dynamic> toMap() {
    return LearnedLanguageLoadingMapper.ensureInitialized()
        .encodeMap<LearnedLanguageLoading>(this as LearnedLanguageLoading);
  }

  LearnedLanguageLoadingCopyWith<
    LearnedLanguageLoading,
    LearnedLanguageLoading,
    LearnedLanguageLoading
  >
  get copyWith =>
      _LearnedLanguageLoadingCopyWithImpl<
        LearnedLanguageLoading,
        LearnedLanguageLoading
      >(this as LearnedLanguageLoading, $identity, $identity);
  @override
  String toString() {
    return LearnedLanguageLoadingMapper.ensureInitialized().stringifyValue(
      this as LearnedLanguageLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return LearnedLanguageLoadingMapper.ensureInitialized().equalsValue(
      this as LearnedLanguageLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return LearnedLanguageLoadingMapper.ensureInitialized().hashValue(
      this as LearnedLanguageLoading,
    );
  }
}

extension LearnedLanguageLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LearnedLanguageLoading, $Out> {
  LearnedLanguageLoadingCopyWith<$R, LearnedLanguageLoading, $Out>
  get $asLearnedLanguageLoading => $base.as(
    (v, t, t2) => _LearnedLanguageLoadingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LearnedLanguageLoadingCopyWith<
  $R,
  $In extends LearnedLanguageLoading,
  $Out
>
    implements LearnedLanguageStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LearnedLanguageLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LearnedLanguageLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LearnedLanguageLoading, $Out>
    implements
        LearnedLanguageLoadingCopyWith<$R, LearnedLanguageLoading, $Out> {
  _LearnedLanguageLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LearnedLanguageLoading> $mapper =
      LearnedLanguageLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LearnedLanguageLoading $make(CopyWithData data) => LearnedLanguageLoading();

  @override
  LearnedLanguageLoadingCopyWith<$R2, LearnedLanguageLoading, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LearnedLanguageLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LearnedLanguageLoadedMapper
    extends ClassMapperBase<LearnedLanguageLoaded> {
  LearnedLanguageLoadedMapper._();

  static LearnedLanguageLoadedMapper? _instance;
  static LearnedLanguageLoadedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LearnedLanguageLoadedMapper._());
      LearnedLanguageStateMapper.ensureInitialized();
      LanguageSetupMapper.ensureInitialized();
      LearnedLanguageMapper.ensureInitialized();
      LanguageCoverageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LearnedLanguageLoaded';

  static LanguageSetup _$setup(LearnedLanguageLoaded v) => v.setup;
  static const Field<LearnedLanguageLoaded, LanguageSetup> _f$setup = Field(
    'setup',
    _$setup,
  );
  static LearnedLanguage _$learned(LearnedLanguageLoaded v) => v.learned;
  static const Field<LearnedLanguageLoaded, LearnedLanguage> _f$learned = Field(
    'learned',
    _$learned,
  );
  static LanguageCoverage? _$coverage(LearnedLanguageLoaded v) => v.coverage;
  static const Field<LearnedLanguageLoaded, LanguageCoverage> _f$coverage =
      Field('coverage', _$coverage);
  static bool _$isBusy(LearnedLanguageLoaded v) => v.isBusy;
  static const Field<LearnedLanguageLoaded, bool> _f$isBusy = Field(
    'isBusy',
    _$isBusy,
  );
  static AppError? _$error(LearnedLanguageLoaded v) => v.error;
  static const Field<LearnedLanguageLoaded, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<LearnedLanguageLoaded> fields = const {
    #setup: _f$setup,
    #learned: _f$learned,
    #coverage: _f$coverage,
    #isBusy: _f$isBusy,
    #error: _f$error,
  };

  static LearnedLanguageLoaded _instantiate(DecodingData data) {
    return LearnedLanguageLoaded(
      setup: data.dec(_f$setup),
      learned: data.dec(_f$learned),
      coverage: data.dec(_f$coverage),
      isBusy: data.dec(_f$isBusy),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LearnedLanguageLoaded fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LearnedLanguageLoaded>(map);
  }

  static LearnedLanguageLoaded fromJson(String json) {
    return ensureInitialized().decodeJson<LearnedLanguageLoaded>(json);
  }
}

mixin LearnedLanguageLoadedMappable {
  String toJson() {
    return LearnedLanguageLoadedMapper.ensureInitialized()
        .encodeJson<LearnedLanguageLoaded>(this as LearnedLanguageLoaded);
  }

  Map<String, dynamic> toMap() {
    return LearnedLanguageLoadedMapper.ensureInitialized()
        .encodeMap<LearnedLanguageLoaded>(this as LearnedLanguageLoaded);
  }

  LearnedLanguageLoadedCopyWith<
    LearnedLanguageLoaded,
    LearnedLanguageLoaded,
    LearnedLanguageLoaded
  >
  get copyWith =>
      _LearnedLanguageLoadedCopyWithImpl<
        LearnedLanguageLoaded,
        LearnedLanguageLoaded
      >(this as LearnedLanguageLoaded, $identity, $identity);
  @override
  String toString() {
    return LearnedLanguageLoadedMapper.ensureInitialized().stringifyValue(
      this as LearnedLanguageLoaded,
    );
  }

  @override
  bool operator ==(Object other) {
    return LearnedLanguageLoadedMapper.ensureInitialized().equalsValue(
      this as LearnedLanguageLoaded,
      other,
    );
  }

  @override
  int get hashCode {
    return LearnedLanguageLoadedMapper.ensureInitialized().hashValue(
      this as LearnedLanguageLoaded,
    );
  }
}

extension LearnedLanguageLoadedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LearnedLanguageLoaded, $Out> {
  LearnedLanguageLoadedCopyWith<$R, LearnedLanguageLoaded, $Out>
  get $asLearnedLanguageLoaded => $base.as(
    (v, t, t2) => _LearnedLanguageLoadedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LearnedLanguageLoadedCopyWith<
  $R,
  $In extends LearnedLanguageLoaded,
  $Out
>
    implements LearnedLanguageStateCopyWith<$R, $In, $Out> {
  LanguageSetupCopyWith<$R, LanguageSetup, LanguageSetup> get setup;
  LearnedLanguageCopyWith<$R, LearnedLanguage, LearnedLanguage> get learned;
  LanguageCoverageCopyWith<$R, LanguageCoverage, LanguageCoverage>?
  get coverage;
  @override
  $R call({
    LanguageSetup? setup,
    LearnedLanguage? learned,
    LanguageCoverage? coverage,
    bool? isBusy,
    AppError? error,
  });
  LearnedLanguageLoadedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LearnedLanguageLoadedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LearnedLanguageLoaded, $Out>
    implements LearnedLanguageLoadedCopyWith<$R, LearnedLanguageLoaded, $Out> {
  _LearnedLanguageLoadedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LearnedLanguageLoaded> $mapper =
      LearnedLanguageLoadedMapper.ensureInitialized();
  @override
  LanguageSetupCopyWith<$R, LanguageSetup, LanguageSetup> get setup =>
      $value.setup.copyWith.$chain((v) => call(setup: v));
  @override
  LearnedLanguageCopyWith<$R, LearnedLanguage, LearnedLanguage> get learned =>
      $value.learned.copyWith.$chain((v) => call(learned: v));
  @override
  LanguageCoverageCopyWith<$R, LanguageCoverage, LanguageCoverage>?
  get coverage => $value.coverage?.copyWith.$chain((v) => call(coverage: v));
  @override
  $R call({
    LanguageSetup? setup,
    LearnedLanguage? learned,
    Object? coverage = $none,
    bool? isBusy,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (setup != null) #setup: setup,
      if (learned != null) #learned: learned,
      if (coverage != $none) #coverage: coverage,
      if (isBusy != null) #isBusy: isBusy,
      if (error != $none) #error: error,
    }),
  );
  @override
  LearnedLanguageLoaded $make(CopyWithData data) => LearnedLanguageLoaded(
    setup: data.get(#setup, or: $value.setup),
    learned: data.get(#learned, or: $value.learned),
    coverage: data.get(#coverage, or: $value.coverage),
    isBusy: data.get(#isBusy, or: $value.isBusy),
    error: data.get(#error, or: $value.error),
  );

  @override
  LearnedLanguageLoadedCopyWith<$R2, LearnedLanguageLoaded, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LearnedLanguageLoadedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LearnedLanguageClosedMapper
    extends ClassMapperBase<LearnedLanguageClosed> {
  LearnedLanguageClosedMapper._();

  static LearnedLanguageClosedMapper? _instance;
  static LearnedLanguageClosedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LearnedLanguageClosedMapper._());
      LearnedLanguageStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LearnedLanguageClosed';

  @override
  final MappableFields<LearnedLanguageClosed> fields = const {};

  static LearnedLanguageClosed _instantiate(DecodingData data) {
    return LearnedLanguageClosed();
  }

  @override
  final Function instantiate = _instantiate;

  static LearnedLanguageClosed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LearnedLanguageClosed>(map);
  }

  static LearnedLanguageClosed fromJson(String json) {
    return ensureInitialized().decodeJson<LearnedLanguageClosed>(json);
  }
}

mixin LearnedLanguageClosedMappable {
  String toJson() {
    return LearnedLanguageClosedMapper.ensureInitialized()
        .encodeJson<LearnedLanguageClosed>(this as LearnedLanguageClosed);
  }

  Map<String, dynamic> toMap() {
    return LearnedLanguageClosedMapper.ensureInitialized()
        .encodeMap<LearnedLanguageClosed>(this as LearnedLanguageClosed);
  }

  LearnedLanguageClosedCopyWith<
    LearnedLanguageClosed,
    LearnedLanguageClosed,
    LearnedLanguageClosed
  >
  get copyWith =>
      _LearnedLanguageClosedCopyWithImpl<
        LearnedLanguageClosed,
        LearnedLanguageClosed
      >(this as LearnedLanguageClosed, $identity, $identity);
  @override
  String toString() {
    return LearnedLanguageClosedMapper.ensureInitialized().stringifyValue(
      this as LearnedLanguageClosed,
    );
  }

  @override
  bool operator ==(Object other) {
    return LearnedLanguageClosedMapper.ensureInitialized().equalsValue(
      this as LearnedLanguageClosed,
      other,
    );
  }

  @override
  int get hashCode {
    return LearnedLanguageClosedMapper.ensureInitialized().hashValue(
      this as LearnedLanguageClosed,
    );
  }
}

extension LearnedLanguageClosedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LearnedLanguageClosed, $Out> {
  LearnedLanguageClosedCopyWith<$R, LearnedLanguageClosed, $Out>
  get $asLearnedLanguageClosed => $base.as(
    (v, t, t2) => _LearnedLanguageClosedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LearnedLanguageClosedCopyWith<
  $R,
  $In extends LearnedLanguageClosed,
  $Out
>
    implements LearnedLanguageStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LearnedLanguageClosedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LearnedLanguageClosedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LearnedLanguageClosed, $Out>
    implements LearnedLanguageClosedCopyWith<$R, LearnedLanguageClosed, $Out> {
  _LearnedLanguageClosedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LearnedLanguageClosed> $mapper =
      LearnedLanguageClosedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LearnedLanguageClosed $make(CopyWithData data) => LearnedLanguageClosed();

  @override
  LearnedLanguageClosedCopyWith<$R2, LearnedLanguageClosed, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LearnedLanguageClosedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LearnedLanguageFailureMapper
    extends ClassMapperBase<LearnedLanguageFailure> {
  LearnedLanguageFailureMapper._();

  static LearnedLanguageFailureMapper? _instance;
  static LearnedLanguageFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LearnedLanguageFailureMapper._());
      LearnedLanguageStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LearnedLanguageFailure';

  static AppError _$error(LearnedLanguageFailure v) => v.error;
  static const Field<LearnedLanguageFailure, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<LearnedLanguageFailure> fields = const {
    #error: _f$error,
  };

  static LearnedLanguageFailure _instantiate(DecodingData data) {
    return LearnedLanguageFailure(error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static LearnedLanguageFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LearnedLanguageFailure>(map);
  }

  static LearnedLanguageFailure fromJson(String json) {
    return ensureInitialized().decodeJson<LearnedLanguageFailure>(json);
  }
}

mixin LearnedLanguageFailureMappable {
  String toJson() {
    return LearnedLanguageFailureMapper.ensureInitialized()
        .encodeJson<LearnedLanguageFailure>(this as LearnedLanguageFailure);
  }

  Map<String, dynamic> toMap() {
    return LearnedLanguageFailureMapper.ensureInitialized()
        .encodeMap<LearnedLanguageFailure>(this as LearnedLanguageFailure);
  }

  LearnedLanguageFailureCopyWith<
    LearnedLanguageFailure,
    LearnedLanguageFailure,
    LearnedLanguageFailure
  >
  get copyWith =>
      _LearnedLanguageFailureCopyWithImpl<
        LearnedLanguageFailure,
        LearnedLanguageFailure
      >(this as LearnedLanguageFailure, $identity, $identity);
  @override
  String toString() {
    return LearnedLanguageFailureMapper.ensureInitialized().stringifyValue(
      this as LearnedLanguageFailure,
    );
  }

  @override
  bool operator ==(Object other) {
    return LearnedLanguageFailureMapper.ensureInitialized().equalsValue(
      this as LearnedLanguageFailure,
      other,
    );
  }

  @override
  int get hashCode {
    return LearnedLanguageFailureMapper.ensureInitialized().hashValue(
      this as LearnedLanguageFailure,
    );
  }
}

extension LearnedLanguageFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LearnedLanguageFailure, $Out> {
  LearnedLanguageFailureCopyWith<$R, LearnedLanguageFailure, $Out>
  get $asLearnedLanguageFailure => $base.as(
    (v, t, t2) => _LearnedLanguageFailureCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LearnedLanguageFailureCopyWith<
  $R,
  $In extends LearnedLanguageFailure,
  $Out
>
    implements LearnedLanguageStateCopyWith<$R, $In, $Out> {
  @override
  $R call({AppError? error});
  LearnedLanguageFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LearnedLanguageFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LearnedLanguageFailure, $Out>
    implements
        LearnedLanguageFailureCopyWith<$R, LearnedLanguageFailure, $Out> {
  _LearnedLanguageFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LearnedLanguageFailure> $mapper =
      LearnedLanguageFailureMapper.ensureInitialized();
  @override
  $R call({AppError? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  LearnedLanguageFailure $make(CopyWithData data) =>
      LearnedLanguageFailure(error: data.get(#error, or: $value.error));

  @override
  LearnedLanguageFailureCopyWith<$R2, LearnedLanguageFailure, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LearnedLanguageFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

