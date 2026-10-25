// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'collection_state.dart';

class CollectionStateMapper extends ClassMapperBase<CollectionState> {
  CollectionStateMapper._();

  static CollectionStateMapper? _instance;
  static CollectionStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CollectionStateMapper._());
      CollectionLoadingMapper.ensureInitialized();
      CollectionLoadedMapper.ensureInitialized();
      CollectionClosedMapper.ensureInitialized();
      CollectionFailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CollectionState';

  @override
  final MappableFields<CollectionState> fields = const {};

  static CollectionState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('CollectionState');
  }

  @override
  final Function instantiate = _instantiate;

  static CollectionState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CollectionState>(map);
  }

  static CollectionState fromJson(String json) {
    return ensureInitialized().decodeJson<CollectionState>(json);
  }
}

mixin CollectionStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  CollectionStateCopyWith<CollectionState, CollectionState, CollectionState>
  get copyWith;
}

abstract class CollectionStateCopyWith<$R, $In extends CollectionState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  CollectionStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class CollectionLoadingMapper extends ClassMapperBase<CollectionLoading> {
  CollectionLoadingMapper._();

  static CollectionLoadingMapper? _instance;
  static CollectionLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CollectionLoadingMapper._());
      CollectionStateMapper.ensureInitialized();
      TagMapper.ensureInitialized();
      VocabularyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CollectionLoading';

  static Tag? _$tag(CollectionLoading v) => v.tag;
  static const Field<CollectionLoading, Tag> _f$tag = Field('tag', _$tag);
  static int? _$dueCount(CollectionLoading v) => v.dueCount;
  static const Field<CollectionLoading, int> _f$dueCount = Field(
    'dueCount',
    _$dueCount,
  );
  static List<Vocabulary>? _$vocabularies(CollectionLoading v) =>
      v.vocabularies;
  static const Field<CollectionLoading, List<Vocabulary>> _f$vocabularies =
      Field('vocabularies', _$vocabularies);
  static List<Tag>? _$tags(CollectionLoading v) => v.tags;
  static const Field<CollectionLoading, List<Tag>> _f$tags = Field(
    'tags',
    _$tags,
  );
  static int _$feedLimit(CollectionLoading v) => v.feedLimit;
  static const Field<CollectionLoading, int> _f$feedLimit = Field(
    'feedLimit',
    _$feedLimit,
  );

  @override
  final MappableFields<CollectionLoading> fields = const {
    #tag: _f$tag,
    #dueCount: _f$dueCount,
    #vocabularies: _f$vocabularies,
    #tags: _f$tags,
    #feedLimit: _f$feedLimit,
  };

  static CollectionLoading _instantiate(DecodingData data) {
    return CollectionLoading(
      tag: data.dec(_f$tag),
      dueCount: data.dec(_f$dueCount),
      vocabularies: data.dec(_f$vocabularies),
      tags: data.dec(_f$tags),
      feedLimit: data.dec(_f$feedLimit),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CollectionLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CollectionLoading>(map);
  }

  static CollectionLoading fromJson(String json) {
    return ensureInitialized().decodeJson<CollectionLoading>(json);
  }
}

mixin CollectionLoadingMappable {
  String toJson() {
    return CollectionLoadingMapper.ensureInitialized()
        .encodeJson<CollectionLoading>(this as CollectionLoading);
  }

  Map<String, dynamic> toMap() {
    return CollectionLoadingMapper.ensureInitialized()
        .encodeMap<CollectionLoading>(this as CollectionLoading);
  }

  CollectionLoadingCopyWith<
    CollectionLoading,
    CollectionLoading,
    CollectionLoading
  >
  get copyWith =>
      _CollectionLoadingCopyWithImpl<CollectionLoading, CollectionLoading>(
        this as CollectionLoading,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CollectionLoadingMapper.ensureInitialized().stringifyValue(
      this as CollectionLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return CollectionLoadingMapper.ensureInitialized().equalsValue(
      this as CollectionLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return CollectionLoadingMapper.ensureInitialized().hashValue(
      this as CollectionLoading,
    );
  }
}

extension CollectionLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CollectionLoading, $Out> {
  CollectionLoadingCopyWith<$R, CollectionLoading, $Out>
  get $asCollectionLoading => $base.as(
    (v, t, t2) => _CollectionLoadingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CollectionLoadingCopyWith<
  $R,
  $In extends CollectionLoading,
  $Out
>
    implements CollectionStateCopyWith<$R, $In, $Out> {
  TagCopyWith<$R, Tag, Tag>? get tag;
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>?
  get vocabularies;
  ListCopyWith<$R, Tag, TagCopyWith<$R, Tag, Tag>>? get tags;
  @override
  $R call({
    Tag? tag,
    int? dueCount,
    List<Vocabulary>? vocabularies,
    List<Tag>? tags,
    int? feedLimit,
  });
  CollectionLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CollectionLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CollectionLoading, $Out>
    implements CollectionLoadingCopyWith<$R, CollectionLoading, $Out> {
  _CollectionLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CollectionLoading> $mapper =
      CollectionLoadingMapper.ensureInitialized();
  @override
  TagCopyWith<$R, Tag, Tag>? get tag =>
      $value.tag?.copyWith.$chain((v) => call(tag: v));
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
  ListCopyWith<$R, Tag, TagCopyWith<$R, Tag, Tag>>? get tags =>
      $value.tags != null
      ? ListCopyWith(
          $value.tags!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(tags: v),
        )
      : null;
  @override
  $R call({
    Object? tag = $none,
    Object? dueCount = $none,
    Object? vocabularies = $none,
    Object? tags = $none,
    int? feedLimit,
  }) => $apply(
    FieldCopyWithData({
      if (tag != $none) #tag: tag,
      if (dueCount != $none) #dueCount: dueCount,
      if (vocabularies != $none) #vocabularies: vocabularies,
      if (tags != $none) #tags: tags,
      if (feedLimit != null) #feedLimit: feedLimit,
    }),
  );
  @override
  CollectionLoading $make(CopyWithData data) => CollectionLoading(
    tag: data.get(#tag, or: $value.tag),
    dueCount: data.get(#dueCount, or: $value.dueCount),
    vocabularies: data.get(#vocabularies, or: $value.vocabularies),
    tags: data.get(#tags, or: $value.tags),
    feedLimit: data.get(#feedLimit, or: $value.feedLimit),
  );

  @override
  CollectionLoadingCopyWith<$R2, CollectionLoading, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CollectionLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CollectionLoadedMapper extends ClassMapperBase<CollectionLoaded> {
  CollectionLoadedMapper._();

  static CollectionLoadedMapper? _instance;
  static CollectionLoadedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CollectionLoadedMapper._());
      CollectionStateMapper.ensureInitialized();
      TagMapper.ensureInitialized();
      VocabularyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CollectionLoaded';

  static Tag _$tag(CollectionLoaded v) => v.tag;
  static const Field<CollectionLoaded, Tag> _f$tag = Field('tag', _$tag);
  static int _$dueCount(CollectionLoaded v) => v.dueCount;
  static const Field<CollectionLoaded, int> _f$dueCount = Field(
    'dueCount',
    _$dueCount,
  );
  static List<Vocabulary> _$vocabularies(CollectionLoaded v) => v.vocabularies;
  static const Field<CollectionLoaded, List<Vocabulary>> _f$vocabularies =
      Field('vocabularies', _$vocabularies);
  static List<Tag> _$tags(CollectionLoaded v) => v.tags;
  static const Field<CollectionLoaded, List<Tag>> _f$tags = Field(
    'tags',
    _$tags,
  );
  static int _$feedLimit(CollectionLoaded v) => v.feedLimit;
  static const Field<CollectionLoaded, int> _f$feedLimit = Field(
    'feedLimit',
    _$feedLimit,
  );
  static AppError? _$error(CollectionLoaded v) => v.error;
  static const Field<CollectionLoaded, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<CollectionLoaded> fields = const {
    #tag: _f$tag,
    #dueCount: _f$dueCount,
    #vocabularies: _f$vocabularies,
    #tags: _f$tags,
    #feedLimit: _f$feedLimit,
    #error: _f$error,
  };

  static CollectionLoaded _instantiate(DecodingData data) {
    return CollectionLoaded(
      tag: data.dec(_f$tag),
      dueCount: data.dec(_f$dueCount),
      vocabularies: data.dec(_f$vocabularies),
      tags: data.dec(_f$tags),
      feedLimit: data.dec(_f$feedLimit),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CollectionLoaded fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CollectionLoaded>(map);
  }

  static CollectionLoaded fromJson(String json) {
    return ensureInitialized().decodeJson<CollectionLoaded>(json);
  }
}

mixin CollectionLoadedMappable {
  String toJson() {
    return CollectionLoadedMapper.ensureInitialized()
        .encodeJson<CollectionLoaded>(this as CollectionLoaded);
  }

  Map<String, dynamic> toMap() {
    return CollectionLoadedMapper.ensureInitialized()
        .encodeMap<CollectionLoaded>(this as CollectionLoaded);
  }

  CollectionLoadedCopyWith<CollectionLoaded, CollectionLoaded, CollectionLoaded>
  get copyWith =>
      _CollectionLoadedCopyWithImpl<CollectionLoaded, CollectionLoaded>(
        this as CollectionLoaded,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CollectionLoadedMapper.ensureInitialized().stringifyValue(
      this as CollectionLoaded,
    );
  }

  @override
  bool operator ==(Object other) {
    return CollectionLoadedMapper.ensureInitialized().equalsValue(
      this as CollectionLoaded,
      other,
    );
  }

  @override
  int get hashCode {
    return CollectionLoadedMapper.ensureInitialized().hashValue(
      this as CollectionLoaded,
    );
  }
}

extension CollectionLoadedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CollectionLoaded, $Out> {
  CollectionLoadedCopyWith<$R, CollectionLoaded, $Out>
  get $asCollectionLoaded =>
      $base.as((v, t, t2) => _CollectionLoadedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CollectionLoadedCopyWith<$R, $In extends CollectionLoaded, $Out>
    implements CollectionStateCopyWith<$R, $In, $Out> {
  TagCopyWith<$R, Tag, Tag> get tag;
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>
  get vocabularies;
  ListCopyWith<$R, Tag, TagCopyWith<$R, Tag, Tag>> get tags;
  @override
  $R call({
    Tag? tag,
    int? dueCount,
    List<Vocabulary>? vocabularies,
    List<Tag>? tags,
    int? feedLimit,
    AppError? error,
  });
  CollectionLoadedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CollectionLoadedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CollectionLoaded, $Out>
    implements CollectionLoadedCopyWith<$R, CollectionLoaded, $Out> {
  _CollectionLoadedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CollectionLoaded> $mapper =
      CollectionLoadedMapper.ensureInitialized();
  @override
  TagCopyWith<$R, Tag, Tag> get tag =>
      $value.tag.copyWith.$chain((v) => call(tag: v));
  @override
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>
  get vocabularies => ListCopyWith(
    $value.vocabularies,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(vocabularies: v),
  );
  @override
  ListCopyWith<$R, Tag, TagCopyWith<$R, Tag, Tag>> get tags => ListCopyWith(
    $value.tags,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(tags: v),
  );
  @override
  $R call({
    Tag? tag,
    int? dueCount,
    List<Vocabulary>? vocabularies,
    List<Tag>? tags,
    int? feedLimit,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (tag != null) #tag: tag,
      if (dueCount != null) #dueCount: dueCount,
      if (vocabularies != null) #vocabularies: vocabularies,
      if (tags != null) #tags: tags,
      if (feedLimit != null) #feedLimit: feedLimit,
      if (error != $none) #error: error,
    }),
  );
  @override
  CollectionLoaded $make(CopyWithData data) => CollectionLoaded(
    tag: data.get(#tag, or: $value.tag),
    dueCount: data.get(#dueCount, or: $value.dueCount),
    vocabularies: data.get(#vocabularies, or: $value.vocabularies),
    tags: data.get(#tags, or: $value.tags),
    feedLimit: data.get(#feedLimit, or: $value.feedLimit),
    error: data.get(#error, or: $value.error),
  );

  @override
  CollectionLoadedCopyWith<$R2, CollectionLoaded, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CollectionLoadedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CollectionClosedMapper extends ClassMapperBase<CollectionClosed> {
  CollectionClosedMapper._();

  static CollectionClosedMapper? _instance;
  static CollectionClosedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CollectionClosedMapper._());
      CollectionStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CollectionClosed';

  @override
  final MappableFields<CollectionClosed> fields = const {};

  static CollectionClosed _instantiate(DecodingData data) {
    return CollectionClosed();
  }

  @override
  final Function instantiate = _instantiate;

  static CollectionClosed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CollectionClosed>(map);
  }

  static CollectionClosed fromJson(String json) {
    return ensureInitialized().decodeJson<CollectionClosed>(json);
  }
}

mixin CollectionClosedMappable {
  String toJson() {
    return CollectionClosedMapper.ensureInitialized()
        .encodeJson<CollectionClosed>(this as CollectionClosed);
  }

  Map<String, dynamic> toMap() {
    return CollectionClosedMapper.ensureInitialized()
        .encodeMap<CollectionClosed>(this as CollectionClosed);
  }

  CollectionClosedCopyWith<CollectionClosed, CollectionClosed, CollectionClosed>
  get copyWith =>
      _CollectionClosedCopyWithImpl<CollectionClosed, CollectionClosed>(
        this as CollectionClosed,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CollectionClosedMapper.ensureInitialized().stringifyValue(
      this as CollectionClosed,
    );
  }

  @override
  bool operator ==(Object other) {
    return CollectionClosedMapper.ensureInitialized().equalsValue(
      this as CollectionClosed,
      other,
    );
  }

  @override
  int get hashCode {
    return CollectionClosedMapper.ensureInitialized().hashValue(
      this as CollectionClosed,
    );
  }
}

extension CollectionClosedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CollectionClosed, $Out> {
  CollectionClosedCopyWith<$R, CollectionClosed, $Out>
  get $asCollectionClosed =>
      $base.as((v, t, t2) => _CollectionClosedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CollectionClosedCopyWith<$R, $In extends CollectionClosed, $Out>
    implements CollectionStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  CollectionClosedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CollectionClosedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CollectionClosed, $Out>
    implements CollectionClosedCopyWith<$R, CollectionClosed, $Out> {
  _CollectionClosedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CollectionClosed> $mapper =
      CollectionClosedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  CollectionClosed $make(CopyWithData data) => CollectionClosed();

  @override
  CollectionClosedCopyWith<$R2, CollectionClosed, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CollectionClosedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CollectionFailureMapper extends ClassMapperBase<CollectionFailure> {
  CollectionFailureMapper._();

  static CollectionFailureMapper? _instance;
  static CollectionFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CollectionFailureMapper._());
      CollectionStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CollectionFailure';

  static AppError _$error(CollectionFailure v) => v.error;
  static const Field<CollectionFailure, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<CollectionFailure> fields = const {#error: _f$error};

  static CollectionFailure _instantiate(DecodingData data) {
    return CollectionFailure(error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static CollectionFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CollectionFailure>(map);
  }

  static CollectionFailure fromJson(String json) {
    return ensureInitialized().decodeJson<CollectionFailure>(json);
  }
}

mixin CollectionFailureMappable {
  String toJson() {
    return CollectionFailureMapper.ensureInitialized()
        .encodeJson<CollectionFailure>(this as CollectionFailure);
  }

  Map<String, dynamic> toMap() {
    return CollectionFailureMapper.ensureInitialized()
        .encodeMap<CollectionFailure>(this as CollectionFailure);
  }

  CollectionFailureCopyWith<
    CollectionFailure,
    CollectionFailure,
    CollectionFailure
  >
  get copyWith =>
      _CollectionFailureCopyWithImpl<CollectionFailure, CollectionFailure>(
        this as CollectionFailure,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CollectionFailureMapper.ensureInitialized().stringifyValue(
      this as CollectionFailure,
    );
  }

  @override
  bool operator ==(Object other) {
    return CollectionFailureMapper.ensureInitialized().equalsValue(
      this as CollectionFailure,
      other,
    );
  }

  @override
  int get hashCode {
    return CollectionFailureMapper.ensureInitialized().hashValue(
      this as CollectionFailure,
    );
  }
}

extension CollectionFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CollectionFailure, $Out> {
  CollectionFailureCopyWith<$R, CollectionFailure, $Out>
  get $asCollectionFailure => $base.as(
    (v, t, t2) => _CollectionFailureCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CollectionFailureCopyWith<
  $R,
  $In extends CollectionFailure,
  $Out
>
    implements CollectionStateCopyWith<$R, $In, $Out> {
  @override
  $R call({AppError? error});
  CollectionFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CollectionFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CollectionFailure, $Out>
    implements CollectionFailureCopyWith<$R, CollectionFailure, $Out> {
  _CollectionFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CollectionFailure> $mapper =
      CollectionFailureMapper.ensureInitialized();
  @override
  $R call({AppError? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  CollectionFailure $make(CopyWithData data) =>
      CollectionFailure(error: data.get(#error, or: $value.error));

  @override
  CollectionFailureCopyWith<$R2, CollectionFailure, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CollectionFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

