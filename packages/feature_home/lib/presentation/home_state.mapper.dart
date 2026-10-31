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
      LanguageSetupMapper.ensureInitialized();
      CustomPracticeSessionMapper.ensureInitialized();
      VocabularyOverviewMapper.ensureInitialized();
      VocabularyMapper.ensureInitialized();
      CollectionPreviewMapper.ensureInitialized();
      VocabularyFilterMapper.ensureInitialized();
      StreakMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeLoading';

  static LanguageSetup? _$setup(HomeLoading v) => v.setup;
  static const Field<HomeLoading, LanguageSetup> _f$setup = Field(
    'setup',
    _$setup,
  );
  static CustomPracticeSession? _$customSession(HomeLoading v) =>
      v.customSession;
  static const Field<HomeLoading, CustomPracticeSession> _f$customSession =
      Field('customSession', _$customSession);
  static int? _$allWordsCount(HomeLoading v) => v.allWordsCount;
  static const Field<HomeLoading, int> _f$allWordsCount = Field(
    'allWordsCount',
    _$allWordsCount,
  );
  static VocabularyOverview? _$overview(HomeLoading v) => v.overview;
  static const Field<HomeLoading, VocabularyOverview> _f$overview = Field(
    'overview',
    _$overview,
  );
  static List<Vocabulary>? _$recentVocabularies(HomeLoading v) =>
      v.recentVocabularies;
  static const Field<HomeLoading, List<Vocabulary>> _f$recentVocabularies =
      Field('recentVocabularies', _$recentVocabularies);
  static List<CollectionPreview>? _$collections(HomeLoading v) => v.collections;
  static const Field<HomeLoading, List<CollectionPreview>> _f$collections =
      Field('collections', _$collections);
  static List<Vocabulary>? _$vocabularies(HomeLoading v) => v.vocabularies;
  static const Field<HomeLoading, List<Vocabulary>> _f$vocabularies = Field(
    'vocabularies',
    _$vocabularies,
  );
  static int _$feedLimit(HomeLoading v) => v.feedLimit;
  static const Field<HomeLoading, int> _f$feedLimit = Field(
    'feedLimit',
    _$feedLimit,
  );
  static VocabularyFilter _$filter(HomeLoading v) => v.filter;
  static const Field<HomeLoading, VocabularyFilter> _f$filter = Field(
    'filter',
    _$filter,
  );
  static Streak? _$streak(HomeLoading v) => v.streak;
  static const Field<HomeLoading, Streak> _f$streak = Field('streak', _$streak);

  @override
  final MappableFields<HomeLoading> fields = const {
    #setup: _f$setup,
    #customSession: _f$customSession,
    #allWordsCount: _f$allWordsCount,
    #overview: _f$overview,
    #recentVocabularies: _f$recentVocabularies,
    #collections: _f$collections,
    #vocabularies: _f$vocabularies,
    #feedLimit: _f$feedLimit,
    #filter: _f$filter,
    #streak: _f$streak,
  };

  static HomeLoading _instantiate(DecodingData data) {
    return HomeLoading(
      setup: data.dec(_f$setup),
      customSession: data.dec(_f$customSession),
      allWordsCount: data.dec(_f$allWordsCount),
      overview: data.dec(_f$overview),
      recentVocabularies: data.dec(_f$recentVocabularies),
      collections: data.dec(_f$collections),
      vocabularies: data.dec(_f$vocabularies),
      feedLimit: data.dec(_f$feedLimit),
      filter: data.dec(_f$filter),
      streak: data.dec(_f$streak),
    );
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
  LanguageSetupCopyWith<$R, LanguageSetup, LanguageSetup>? get setup;
  CustomPracticeSessionCopyWith<
    $R,
    CustomPracticeSession,
    CustomPracticeSession
  >?
  get customSession;
  VocabularyOverviewCopyWith<$R, VocabularyOverview, VocabularyOverview>?
  get overview;
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>?
  get recentVocabularies;
  ListCopyWith<
    $R,
    CollectionPreview,
    CollectionPreviewCopyWith<$R, CollectionPreview, CollectionPreview>
  >?
  get collections;
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>?
  get vocabularies;
  VocabularyFilterCopyWith<$R, VocabularyFilter, VocabularyFilter> get filter;
  StreakCopyWith<$R, Streak, Streak>? get streak;
  @override
  $R call({
    LanguageSetup? setup,
    CustomPracticeSession? customSession,
    int? allWordsCount,
    VocabularyOverview? overview,
    List<Vocabulary>? recentVocabularies,
    List<CollectionPreview>? collections,
    List<Vocabulary>? vocabularies,
    int? feedLimit,
    VocabularyFilter? filter,
    Streak? streak,
  });
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
  LanguageSetupCopyWith<$R, LanguageSetup, LanguageSetup>? get setup =>
      $value.setup?.copyWith.$chain((v) => call(setup: v));
  @override
  CustomPracticeSessionCopyWith<
    $R,
    CustomPracticeSession,
    CustomPracticeSession
  >?
  get customSession =>
      $value.customSession?.copyWith.$chain((v) => call(customSession: v));
  @override
  VocabularyOverviewCopyWith<$R, VocabularyOverview, VocabularyOverview>?
  get overview => $value.overview?.copyWith.$chain((v) => call(overview: v));
  @override
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>?
  get recentVocabularies => $value.recentVocabularies != null
      ? ListCopyWith(
          $value.recentVocabularies!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(recentVocabularies: v),
        )
      : null;
  @override
  ListCopyWith<
    $R,
    CollectionPreview,
    CollectionPreviewCopyWith<$R, CollectionPreview, CollectionPreview>
  >?
  get collections => $value.collections != null
      ? ListCopyWith(
          $value.collections!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(collections: v),
        )
      : null;
  @override
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>?
  get vocabularies => $value.vocabularies != null
      ? ListCopyWith(
          $value.vocabularies!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(vocabularies: v),
        )
      : null;
  @override
  VocabularyFilterCopyWith<$R, VocabularyFilter, VocabularyFilter> get filter =>
      $value.filter.copyWith.$chain((v) => call(filter: v));
  @override
  StreakCopyWith<$R, Streak, Streak>? get streak =>
      $value.streak?.copyWith.$chain((v) => call(streak: v));
  @override
  $R call({
    Object? setup = $none,
    Object? customSession = $none,
    Object? allWordsCount = $none,
    Object? overview = $none,
    Object? recentVocabularies = $none,
    Object? collections = $none,
    Object? vocabularies = $none,
    int? feedLimit,
    VocabularyFilter? filter,
    Object? streak = $none,
  }) => $apply(
    FieldCopyWithData({
      if (setup != $none) #setup: setup,
      if (customSession != $none) #customSession: customSession,
      if (allWordsCount != $none) #allWordsCount: allWordsCount,
      if (overview != $none) #overview: overview,
      if (recentVocabularies != $none) #recentVocabularies: recentVocabularies,
      if (collections != $none) #collections: collections,
      if (vocabularies != $none) #vocabularies: vocabularies,
      if (feedLimit != null) #feedLimit: feedLimit,
      if (filter != null) #filter: filter,
      if (streak != $none) #streak: streak,
    }),
  );
  @override
  HomeLoading $make(CopyWithData data) => HomeLoading(
    setup: data.get(#setup, or: $value.setup),
    customSession: data.get(#customSession, or: $value.customSession),
    allWordsCount: data.get(#allWordsCount, or: $value.allWordsCount),
    overview: data.get(#overview, or: $value.overview),
    recentVocabularies: data.get(
      #recentVocabularies,
      or: $value.recentVocabularies,
    ),
    collections: data.get(#collections, or: $value.collections),
    vocabularies: data.get(#vocabularies, or: $value.vocabularies),
    feedLimit: data.get(#feedLimit, or: $value.feedLimit),
    filter: data.get(#filter, or: $value.filter),
    streak: data.get(#streak, or: $value.streak),
  );

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
      LanguageSetupMapper.ensureInitialized();
      CustomPracticeSessionMapper.ensureInitialized();
      VocabularyOverviewMapper.ensureInitialized();
      VocabularyMapper.ensureInitialized();
      CollectionPreviewMapper.ensureInitialized();
      VocabularyFilterMapper.ensureInitialized();
      StreakMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeLoaded';

  static LanguageSetup _$setup(HomeLoaded v) => v.setup;
  static const Field<HomeLoaded, LanguageSetup> _f$setup = Field(
    'setup',
    _$setup,
  );
  static CustomPracticeSession? _$customSession(HomeLoaded v) =>
      v.customSession;
  static const Field<HomeLoaded, CustomPracticeSession> _f$customSession =
      Field('customSession', _$customSession);
  static int _$allWordsCount(HomeLoaded v) => v.allWordsCount;
  static const Field<HomeLoaded, int> _f$allWordsCount = Field(
    'allWordsCount',
    _$allWordsCount,
  );
  static VocabularyOverview _$overview(HomeLoaded v) => v.overview;
  static const Field<HomeLoaded, VocabularyOverview> _f$overview = Field(
    'overview',
    _$overview,
  );
  static List<Vocabulary> _$recentVocabularies(HomeLoaded v) =>
      v.recentVocabularies;
  static const Field<HomeLoaded, List<Vocabulary>> _f$recentVocabularies =
      Field('recentVocabularies', _$recentVocabularies);
  static List<CollectionPreview> _$collections(HomeLoaded v) => v.collections;
  static const Field<HomeLoaded, List<CollectionPreview>> _f$collections =
      Field('collections', _$collections);
  static List<Vocabulary> _$vocabularies(HomeLoaded v) => v.vocabularies;
  static const Field<HomeLoaded, List<Vocabulary>> _f$vocabularies = Field(
    'vocabularies',
    _$vocabularies,
  );
  static int _$feedLimit(HomeLoaded v) => v.feedLimit;
  static const Field<HomeLoaded, int> _f$feedLimit = Field(
    'feedLimit',
    _$feedLimit,
  );
  static VocabularyFilter _$filter(HomeLoaded v) => v.filter;
  static const Field<HomeLoaded, VocabularyFilter> _f$filter = Field(
    'filter',
    _$filter,
  );
  static Streak? _$streak(HomeLoaded v) => v.streak;
  static const Field<HomeLoaded, Streak> _f$streak = Field('streak', _$streak);
  static AppError? _$error(HomeLoaded v) => v.error;
  static const Field<HomeLoaded, AppError> _f$error = Field('error', _$error);

  @override
  final MappableFields<HomeLoaded> fields = const {
    #setup: _f$setup,
    #customSession: _f$customSession,
    #allWordsCount: _f$allWordsCount,
    #overview: _f$overview,
    #recentVocabularies: _f$recentVocabularies,
    #collections: _f$collections,
    #vocabularies: _f$vocabularies,
    #feedLimit: _f$feedLimit,
    #filter: _f$filter,
    #streak: _f$streak,
    #error: _f$error,
  };

  static HomeLoaded _instantiate(DecodingData data) {
    return HomeLoaded(
      setup: data.dec(_f$setup),
      customSession: data.dec(_f$customSession),
      allWordsCount: data.dec(_f$allWordsCount),
      overview: data.dec(_f$overview),
      recentVocabularies: data.dec(_f$recentVocabularies),
      collections: data.dec(_f$collections),
      vocabularies: data.dec(_f$vocabularies),
      feedLimit: data.dec(_f$feedLimit),
      filter: data.dec(_f$filter),
      streak: data.dec(_f$streak),
      error: data.dec(_f$error),
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
  LanguageSetupCopyWith<$R, LanguageSetup, LanguageSetup> get setup;
  CustomPracticeSessionCopyWith<
    $R,
    CustomPracticeSession,
    CustomPracticeSession
  >?
  get customSession;
  VocabularyOverviewCopyWith<$R, VocabularyOverview, VocabularyOverview>
  get overview;
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>
  get recentVocabularies;
  ListCopyWith<
    $R,
    CollectionPreview,
    CollectionPreviewCopyWith<$R, CollectionPreview, CollectionPreview>
  >
  get collections;
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>
  get vocabularies;
  VocabularyFilterCopyWith<$R, VocabularyFilter, VocabularyFilter> get filter;
  StreakCopyWith<$R, Streak, Streak>? get streak;
  @override
  $R call({
    LanguageSetup? setup,
    CustomPracticeSession? customSession,
    int? allWordsCount,
    VocabularyOverview? overview,
    List<Vocabulary>? recentVocabularies,
    List<CollectionPreview>? collections,
    List<Vocabulary>? vocabularies,
    int? feedLimit,
    VocabularyFilter? filter,
    Streak? streak,
    AppError? error,
  });
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
  LanguageSetupCopyWith<$R, LanguageSetup, LanguageSetup> get setup =>
      $value.setup.copyWith.$chain((v) => call(setup: v));
  @override
  CustomPracticeSessionCopyWith<
    $R,
    CustomPracticeSession,
    CustomPracticeSession
  >?
  get customSession =>
      $value.customSession?.copyWith.$chain((v) => call(customSession: v));
  @override
  VocabularyOverviewCopyWith<$R, VocabularyOverview, VocabularyOverview>
  get overview => $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>
  get recentVocabularies => ListCopyWith(
    $value.recentVocabularies,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(recentVocabularies: v),
  );
  @override
  ListCopyWith<
    $R,
    CollectionPreview,
    CollectionPreviewCopyWith<$R, CollectionPreview, CollectionPreview>
  >
  get collections => ListCopyWith(
    $value.collections,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(collections: v),
  );
  @override
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>
  get vocabularies => ListCopyWith(
    $value.vocabularies,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(vocabularies: v),
  );
  @override
  VocabularyFilterCopyWith<$R, VocabularyFilter, VocabularyFilter> get filter =>
      $value.filter.copyWith.$chain((v) => call(filter: v));
  @override
  StreakCopyWith<$R, Streak, Streak>? get streak =>
      $value.streak?.copyWith.$chain((v) => call(streak: v));
  @override
  $R call({
    LanguageSetup? setup,
    Object? customSession = $none,
    int? allWordsCount,
    VocabularyOverview? overview,
    List<Vocabulary>? recentVocabularies,
    List<CollectionPreview>? collections,
    List<Vocabulary>? vocabularies,
    int? feedLimit,
    VocabularyFilter? filter,
    Object? streak = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (setup != null) #setup: setup,
      if (customSession != $none) #customSession: customSession,
      if (allWordsCount != null) #allWordsCount: allWordsCount,
      if (overview != null) #overview: overview,
      if (recentVocabularies != null) #recentVocabularies: recentVocabularies,
      if (collections != null) #collections: collections,
      if (vocabularies != null) #vocabularies: vocabularies,
      if (feedLimit != null) #feedLimit: feedLimit,
      if (filter != null) #filter: filter,
      if (streak != $none) #streak: streak,
      if (error != $none) #error: error,
    }),
  );
  @override
  HomeLoaded $make(CopyWithData data) => HomeLoaded(
    setup: data.get(#setup, or: $value.setup),
    customSession: data.get(#customSession, or: $value.customSession),
    allWordsCount: data.get(#allWordsCount, or: $value.allWordsCount),
    overview: data.get(#overview, or: $value.overview),
    recentVocabularies: data.get(
      #recentVocabularies,
      or: $value.recentVocabularies,
    ),
    collections: data.get(#collections, or: $value.collections),
    vocabularies: data.get(#vocabularies, or: $value.vocabularies),
    feedLimit: data.get(#feedLimit, or: $value.feedLimit),
    filter: data.get(#filter, or: $value.filter),
    streak: data.get(#streak, or: $value.streak),
    error: data.get(#error, or: $value.error),
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

