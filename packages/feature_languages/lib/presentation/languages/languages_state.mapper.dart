// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'languages_state.dart';

class LanguagesStateMapper extends ClassMapperBase<LanguagesState> {
  LanguagesStateMapper._();

  static LanguagesStateMapper? _instance;
  static LanguagesStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguagesStateMapper._());
      LanguagesLoadingMapper.ensureInitialized();
      LanguagesLoadedMapper.ensureInitialized();
      LanguagesFailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguagesState';

  @override
  final MappableFields<LanguagesState> fields = const {};

  static LanguagesState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('LanguagesState');
  }

  @override
  final Function instantiate = _instantiate;

  static LanguagesState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguagesState>(map);
  }

  static LanguagesState fromJson(String json) {
    return ensureInitialized().decodeJson<LanguagesState>(json);
  }
}

mixin LanguagesStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  LanguagesStateCopyWith<LanguagesState, LanguagesState, LanguagesState>
  get copyWith;
}

abstract class LanguagesStateCopyWith<$R, $In extends LanguagesState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  LanguagesStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class LanguagesLoadingMapper extends ClassMapperBase<LanguagesLoading> {
  LanguagesLoadingMapper._();

  static LanguagesLoadingMapper? _instance;
  static LanguagesLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguagesLoadingMapper._());
      LanguagesStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguagesLoading';

  @override
  final MappableFields<LanguagesLoading> fields = const {};

  static LanguagesLoading _instantiate(DecodingData data) {
    return LanguagesLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static LanguagesLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguagesLoading>(map);
  }

  static LanguagesLoading fromJson(String json) {
    return ensureInitialized().decodeJson<LanguagesLoading>(json);
  }
}

mixin LanguagesLoadingMappable {
  String toJson() {
    return LanguagesLoadingMapper.ensureInitialized()
        .encodeJson<LanguagesLoading>(this as LanguagesLoading);
  }

  Map<String, dynamic> toMap() {
    return LanguagesLoadingMapper.ensureInitialized()
        .encodeMap<LanguagesLoading>(this as LanguagesLoading);
  }

  LanguagesLoadingCopyWith<LanguagesLoading, LanguagesLoading, LanguagesLoading>
  get copyWith =>
      _LanguagesLoadingCopyWithImpl<LanguagesLoading, LanguagesLoading>(
        this as LanguagesLoading,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LanguagesLoadingMapper.ensureInitialized().stringifyValue(
      this as LanguagesLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguagesLoadingMapper.ensureInitialized().equalsValue(
      this as LanguagesLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguagesLoadingMapper.ensureInitialized().hashValue(
      this as LanguagesLoading,
    );
  }
}

extension LanguagesLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguagesLoading, $Out> {
  LanguagesLoadingCopyWith<$R, LanguagesLoading, $Out>
  get $asLanguagesLoading =>
      $base.as((v, t, t2) => _LanguagesLoadingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LanguagesLoadingCopyWith<$R, $In extends LanguagesLoading, $Out>
    implements LanguagesStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LanguagesLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguagesLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguagesLoading, $Out>
    implements LanguagesLoadingCopyWith<$R, LanguagesLoading, $Out> {
  _LanguagesLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguagesLoading> $mapper =
      LanguagesLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LanguagesLoading $make(CopyWithData data) => LanguagesLoading();

  @override
  LanguagesLoadingCopyWith<$R2, LanguagesLoading, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanguagesLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LanguagesLoadedMapper extends ClassMapperBase<LanguagesLoaded> {
  LanguagesLoadedMapper._();

  static LanguagesLoadedMapper? _instance;
  static LanguagesLoadedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguagesLoadedMapper._());
      LanguagesStateMapper.ensureInitialized();
      LanguageSetupMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguagesLoaded';

  static LanguageSetup _$setup(LanguagesLoaded v) => v.setup;
  static const Field<LanguagesLoaded, LanguageSetup> _f$setup = Field(
    'setup',
    _$setup,
  );
  static Map<Language, int> _$wordCounts(LanguagesLoaded v) => v.wordCounts;
  static const Field<LanguagesLoaded, Map<Language, int>> _f$wordCounts = Field(
    'wordCounts',
    _$wordCounts,
  );
  static bool _$isBusy(LanguagesLoaded v) => v.isBusy;
  static const Field<LanguagesLoaded, bool> _f$isBusy = Field(
    'isBusy',
    _$isBusy,
  );
  static AppError? _$error(LanguagesLoaded v) => v.error;
  static const Field<LanguagesLoaded, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<LanguagesLoaded> fields = const {
    #setup: _f$setup,
    #wordCounts: _f$wordCounts,
    #isBusy: _f$isBusy,
    #error: _f$error,
  };

  static LanguagesLoaded _instantiate(DecodingData data) {
    return LanguagesLoaded(
      setup: data.dec(_f$setup),
      wordCounts: data.dec(_f$wordCounts),
      isBusy: data.dec(_f$isBusy),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguagesLoaded fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguagesLoaded>(map);
  }

  static LanguagesLoaded fromJson(String json) {
    return ensureInitialized().decodeJson<LanguagesLoaded>(json);
  }
}

mixin LanguagesLoadedMappable {
  String toJson() {
    return LanguagesLoadedMapper.ensureInitialized()
        .encodeJson<LanguagesLoaded>(this as LanguagesLoaded);
  }

  Map<String, dynamic> toMap() {
    return LanguagesLoadedMapper.ensureInitialized().encodeMap<LanguagesLoaded>(
      this as LanguagesLoaded,
    );
  }

  LanguagesLoadedCopyWith<LanguagesLoaded, LanguagesLoaded, LanguagesLoaded>
  get copyWith =>
      _LanguagesLoadedCopyWithImpl<LanguagesLoaded, LanguagesLoaded>(
        this as LanguagesLoaded,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LanguagesLoadedMapper.ensureInitialized().stringifyValue(
      this as LanguagesLoaded,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguagesLoadedMapper.ensureInitialized().equalsValue(
      this as LanguagesLoaded,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguagesLoadedMapper.ensureInitialized().hashValue(
      this as LanguagesLoaded,
    );
  }
}

extension LanguagesLoadedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguagesLoaded, $Out> {
  LanguagesLoadedCopyWith<$R, LanguagesLoaded, $Out> get $asLanguagesLoaded =>
      $base.as((v, t, t2) => _LanguagesLoadedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LanguagesLoadedCopyWith<$R, $In extends LanguagesLoaded, $Out>
    implements LanguagesStateCopyWith<$R, $In, $Out> {
  LanguageSetupCopyWith<$R, LanguageSetup, LanguageSetup> get setup;
  MapCopyWith<$R, Language, int, ObjectCopyWith<$R, int, int>> get wordCounts;
  @override
  $R call({
    LanguageSetup? setup,
    Map<Language, int>? wordCounts,
    bool? isBusy,
    AppError? error,
  });
  LanguagesLoadedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguagesLoadedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguagesLoaded, $Out>
    implements LanguagesLoadedCopyWith<$R, LanguagesLoaded, $Out> {
  _LanguagesLoadedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguagesLoaded> $mapper =
      LanguagesLoadedMapper.ensureInitialized();
  @override
  LanguageSetupCopyWith<$R, LanguageSetup, LanguageSetup> get setup =>
      $value.setup.copyWith.$chain((v) => call(setup: v));
  @override
  MapCopyWith<$R, Language, int, ObjectCopyWith<$R, int, int>> get wordCounts =>
      MapCopyWith(
        $value.wordCounts,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(wordCounts: v),
      );
  @override
  $R call({
    LanguageSetup? setup,
    Map<Language, int>? wordCounts,
    bool? isBusy,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (setup != null) #setup: setup,
      if (wordCounts != null) #wordCounts: wordCounts,
      if (isBusy != null) #isBusy: isBusy,
      if (error != $none) #error: error,
    }),
  );
  @override
  LanguagesLoaded $make(CopyWithData data) => LanguagesLoaded(
    setup: data.get(#setup, or: $value.setup),
    wordCounts: data.get(#wordCounts, or: $value.wordCounts),
    isBusy: data.get(#isBusy, or: $value.isBusy),
    error: data.get(#error, or: $value.error),
  );

  @override
  LanguagesLoadedCopyWith<$R2, LanguagesLoaded, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanguagesLoadedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LanguagesFailureMapper extends ClassMapperBase<LanguagesFailure> {
  LanguagesFailureMapper._();

  static LanguagesFailureMapper? _instance;
  static LanguagesFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguagesFailureMapper._());
      LanguagesStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguagesFailure';

  static AppError _$error(LanguagesFailure v) => v.error;
  static const Field<LanguagesFailure, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<LanguagesFailure> fields = const {#error: _f$error};

  static LanguagesFailure _instantiate(DecodingData data) {
    return LanguagesFailure(error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static LanguagesFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguagesFailure>(map);
  }

  static LanguagesFailure fromJson(String json) {
    return ensureInitialized().decodeJson<LanguagesFailure>(json);
  }
}

mixin LanguagesFailureMappable {
  String toJson() {
    return LanguagesFailureMapper.ensureInitialized()
        .encodeJson<LanguagesFailure>(this as LanguagesFailure);
  }

  Map<String, dynamic> toMap() {
    return LanguagesFailureMapper.ensureInitialized()
        .encodeMap<LanguagesFailure>(this as LanguagesFailure);
  }

  LanguagesFailureCopyWith<LanguagesFailure, LanguagesFailure, LanguagesFailure>
  get copyWith =>
      _LanguagesFailureCopyWithImpl<LanguagesFailure, LanguagesFailure>(
        this as LanguagesFailure,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LanguagesFailureMapper.ensureInitialized().stringifyValue(
      this as LanguagesFailure,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguagesFailureMapper.ensureInitialized().equalsValue(
      this as LanguagesFailure,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguagesFailureMapper.ensureInitialized().hashValue(
      this as LanguagesFailure,
    );
  }
}

extension LanguagesFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguagesFailure, $Out> {
  LanguagesFailureCopyWith<$R, LanguagesFailure, $Out>
  get $asLanguagesFailure =>
      $base.as((v, t, t2) => _LanguagesFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LanguagesFailureCopyWith<$R, $In extends LanguagesFailure, $Out>
    implements LanguagesStateCopyWith<$R, $In, $Out> {
  @override
  $R call({AppError? error});
  LanguagesFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguagesFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguagesFailure, $Out>
    implements LanguagesFailureCopyWith<$R, LanguagesFailure, $Out> {
  _LanguagesFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguagesFailure> $mapper =
      LanguagesFailureMapper.ensureInitialized();
  @override
  $R call({AppError? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  LanguagesFailure $make(CopyWithData data) =>
      LanguagesFailure(error: data.get(#error, or: $value.error));

  @override
  LanguagesFailureCopyWith<$R2, LanguagesFailure, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanguagesFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

