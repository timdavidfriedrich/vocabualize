// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'home_state.dart';

class HomeStateMapper extends ClassMapperBase<HomeState> {
  HomeStateMapper._();

  static HomeStateMapper? _instance;
  static HomeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeStateMapper._());
      HomeLoadingMapper.ensureInitialized();
      HomeLoadedMapper.ensureInitialized();
      HomeFailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeState';

  @override
  final MappableFields<HomeState> fields = const {};

  static HomeState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('HomeState');
  }

  @override
  final Function instantiate = _instantiate;

  static HomeState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeState>(map);
  }

  static HomeState fromJson(String json) {
    return ensureInitialized().decodeJson<HomeState>(json);
  }
}

mixin HomeStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  HomeStateCopyWith<HomeState, HomeState, HomeState> get copyWith;
}

abstract class HomeStateCopyWith<$R, $In extends HomeState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  HomeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class HomeLoadingMapper extends ClassMapperBase<HomeLoading> {
  HomeLoadingMapper._();

  static HomeLoadingMapper? _instance;
  static HomeLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeLoadingMapper._());
      HomeStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeLoading';

  @override
  final MappableFields<HomeLoading> fields = const {};

  static HomeLoading _instantiate(DecodingData data) {
    return HomeLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static HomeLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeLoading>(map);
  }

  static HomeLoading fromJson(String json) {
    return ensureInitialized().decodeJson<HomeLoading>(json);
  }
}

mixin HomeLoadingMappable {
  String toJson() {
    return HomeLoadingMapper.ensureInitialized().encodeJson<HomeLoading>(
      this as HomeLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return HomeLoadingMapper.ensureInitialized().encodeMap<HomeLoading>(
      this as HomeLoading,
    );
  }

  HomeLoadingCopyWith<HomeLoading, HomeLoading, HomeLoading> get copyWith =>
      _HomeLoadingCopyWithImpl<HomeLoading, HomeLoading>(
        this as HomeLoading,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HomeLoadingMapper.ensureInitialized().stringifyValue(
      this as HomeLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeLoadingMapper.ensureInitialized().equalsValue(
      this as HomeLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeLoadingMapper.ensureInitialized().hashValue(this as HomeLoading);
  }
}

extension HomeLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeLoading, $Out> {
  HomeLoadingCopyWith<$R, HomeLoading, $Out> get $asHomeLoading =>
      $base.as((v, t, t2) => _HomeLoadingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HomeLoadingCopyWith<$R, $In extends HomeLoading, $Out>
    implements HomeStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  HomeLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeLoading, $Out>
    implements HomeLoadingCopyWith<$R, HomeLoading, $Out> {
  _HomeLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeLoading> $mapper =
      HomeLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  HomeLoading $make(CopyWithData data) => HomeLoading();

  @override
  HomeLoadingCopyWith<$R2, HomeLoading, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HomeLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class HomeLoadedMapper extends ClassMapperBase<HomeLoaded> {
  HomeLoadedMapper._();

  static HomeLoadedMapper? _instance;
  static HomeLoadedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeLoadedMapper._());
      HomeStateMapper.ensureInitialized();
      VocabularyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeLoaded';

  static List<Vocabulary> _$vocabularies(HomeLoaded v) => v.vocabularies;
  static const Field<HomeLoaded, List<Vocabulary>> _f$vocabularies = Field(
    'vocabularies',
    _$vocabularies,
  );
  static int _$vocabularyCount(HomeLoaded v) => v.vocabularyCount;
  static const Field<HomeLoaded, int> _f$vocabularyCount = Field(
    'vocabularyCount',
    _$vocabularyCount,
  );

  @override
  final MappableFields<HomeLoaded> fields = const {
    #vocabularies: _f$vocabularies,
    #vocabularyCount: _f$vocabularyCount,
  };

  static HomeLoaded _instantiate(DecodingData data) {
    return HomeLoaded(
      vocabularies: data.dec(_f$vocabularies),
      vocabularyCount: data.dec(_f$vocabularyCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HomeLoaded fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeLoaded>(map);
  }

  static HomeLoaded fromJson(String json) {
    return ensureInitialized().decodeJson<HomeLoaded>(json);
  }
}

mixin HomeLoadedMappable {
  String toJson() {
    return HomeLoadedMapper.ensureInitialized().encodeJson<HomeLoaded>(
      this as HomeLoaded,
    );
  }

  Map<String, dynamic> toMap() {
    return HomeLoadedMapper.ensureInitialized().encodeMap<HomeLoaded>(
      this as HomeLoaded,
    );
  }

  HomeLoadedCopyWith<HomeLoaded, HomeLoaded, HomeLoaded> get copyWith =>
      _HomeLoadedCopyWithImpl<HomeLoaded, HomeLoaded>(
        this as HomeLoaded,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HomeLoadedMapper.ensureInitialized().stringifyValue(
      this as HomeLoaded,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeLoadedMapper.ensureInitialized().equalsValue(
      this as HomeLoaded,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeLoadedMapper.ensureInitialized().hashValue(this as HomeLoaded);
  }
}

extension HomeLoadedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeLoaded, $Out> {
  HomeLoadedCopyWith<$R, HomeLoaded, $Out> get $asHomeLoaded =>
      $base.as((v, t, t2) => _HomeLoadedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HomeLoadedCopyWith<$R, $In extends HomeLoaded, $Out>
    implements HomeStateCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>
  get vocabularies;
  @override
  $R call({List<Vocabulary>? vocabularies, int? vocabularyCount});
  HomeLoadedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeLoadedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeLoaded, $Out>
    implements HomeLoadedCopyWith<$R, HomeLoaded, $Out> {
  _HomeLoadedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeLoaded> $mapper =
      HomeLoadedMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>
  get vocabularies => ListCopyWith(
    $value.vocabularies,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(vocabularies: v),
  );
  @override
  $R call({List<Vocabulary>? vocabularies, int? vocabularyCount}) => $apply(
    FieldCopyWithData({
      if (vocabularies != null) #vocabularies: vocabularies,
      if (vocabularyCount != null) #vocabularyCount: vocabularyCount,
    }),
  );
  @override
  HomeLoaded $make(CopyWithData data) => HomeLoaded(
    vocabularies: data.get(#vocabularies, or: $value.vocabularies),
    vocabularyCount: data.get(#vocabularyCount, or: $value.vocabularyCount),
  );

  @override
  HomeLoadedCopyWith<$R2, HomeLoaded, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HomeLoadedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class HomeFailureMapper extends ClassMapperBase<HomeFailure> {
  HomeFailureMapper._();

  static HomeFailureMapper? _instance;
  static HomeFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeFailureMapper._());
      HomeStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeFailure';

  static AppError _$error(HomeFailure v) => v.error;
  static const Field<HomeFailure, AppError> _f$error = Field('error', _$error);

  @override
  final MappableFields<HomeFailure> fields = const {#error: _f$error};

  static HomeFailure _instantiate(DecodingData data) {
    return HomeFailure(error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static HomeFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeFailure>(map);
  }

  static HomeFailure fromJson(String json) {
    return ensureInitialized().decodeJson<HomeFailure>(json);
  }
}

mixin HomeFailureMappable {
  String toJson() {
    return HomeFailureMapper.ensureInitialized().encodeJson<HomeFailure>(
      this as HomeFailure,
    );
  }

  Map<String, dynamic> toMap() {
    return HomeFailureMapper.ensureInitialized().encodeMap<HomeFailure>(
      this as HomeFailure,
    );
  }

  HomeFailureCopyWith<HomeFailure, HomeFailure, HomeFailure> get copyWith =>
      _HomeFailureCopyWithImpl<HomeFailure, HomeFailure>(
        this as HomeFailure,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HomeFailureMapper.ensureInitialized().stringifyValue(
      this as HomeFailure,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeFailureMapper.ensureInitialized().equalsValue(
      this as HomeFailure,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeFailureMapper.ensureInitialized().hashValue(this as HomeFailure);
  }
}

extension HomeFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeFailure, $Out> {
  HomeFailureCopyWith<$R, HomeFailure, $Out> get $asHomeFailure =>
      $base.as((v, t, t2) => _HomeFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HomeFailureCopyWith<$R, $In extends HomeFailure, $Out>
    implements HomeStateCopyWith<$R, $In, $Out> {
  @override
  $R call({AppError? error});
  HomeFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeFailure, $Out>
    implements HomeFailureCopyWith<$R, HomeFailure, $Out> {
  _HomeFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeFailure> $mapper =
      HomeFailureMapper.ensureInitialized();
  @override
  $R call({AppError? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  HomeFailure $make(CopyWithData data) =>
      HomeFailure(error: data.get(#error, or: $value.error));

  @override
  HomeFailureCopyWith<$R2, HomeFailure, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HomeFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

