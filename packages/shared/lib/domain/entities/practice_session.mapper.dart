// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'practice_session.dart';

class PracticeWordsMapper extends EnumMapper<PracticeWords> {
  PracticeWordsMapper._();

  static PracticeWordsMapper? _instance;
  static PracticeWordsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PracticeWordsMapper._());
    }
    return _instance!;
  }

  static PracticeWords fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PracticeWords decode(dynamic value) {
    switch (value) {
      case r'due':
        return PracticeWords.due;
      case r'all':
        return PracticeWords.all;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PracticeWords self) {
    switch (self) {
      case PracticeWords.due:
        return r'due';
      case PracticeWords.all:
        return r'all';
    }
  }
}

extension PracticeWordsMapperExtension on PracticeWords {
  String toValue() {
    PracticeWordsMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PracticeWords>(this) as String;
  }
}

class PracticeNewWordsMapper extends EnumMapper<PracticeNewWords> {
  PracticeNewWordsMapper._();

  static PracticeNewWordsMapper? _instance;
  static PracticeNewWordsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PracticeNewWordsMapper._());
    }
    return _instance!;
  }

  static PracticeNewWords fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PracticeNewWords decode(dynamic value) {
    switch (value) {
      case r'none':
        return PracticeNewWords.none;
      case r'upToCap':
        return PracticeNewWords.upToCap;
      case r'allWaiting':
        return PracticeNewWords.allWaiting;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PracticeNewWords self) {
    switch (self) {
      case PracticeNewWords.none:
        return r'none';
      case PracticeNewWords.upToCap:
        return r'upToCap';
      case PracticeNewWords.allWaiting:
        return r'allWaiting';
    }
  }
}

extension PracticeNewWordsMapperExtension on PracticeNewWords {
  String toValue() {
    PracticeNewWordsMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PracticeNewWords>(this) as String;
  }
}

class PracticeItemKeyMapper extends ClassMapperBase<PracticeItemKey> {
  PracticeItemKeyMapper._();

  static PracticeItemKeyMapper? _instance;
  static PracticeItemKeyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PracticeItemKeyMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PracticeItemKey';

  static String _$vocabularyId(PracticeItemKey v) => v.vocabularyId;
  static const Field<PracticeItemKey, String> _f$vocabularyId = Field(
    'vocabularyId',
    _$vocabularyId,
  );
  static Language _$language(PracticeItemKey v) => v.language;
  static const Field<PracticeItemKey, Language> _f$language = Field(
    'language',
    _$language,
  );

  @override
  final MappableFields<PracticeItemKey> fields = const {
    #vocabularyId: _f$vocabularyId,
    #language: _f$language,
  };

  static PracticeItemKey _instantiate(DecodingData data) {
    return PracticeItemKey(
      vocabularyId: data.dec(_f$vocabularyId),
      language: data.dec(_f$language),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PracticeItemKey fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PracticeItemKey>(map);
  }

  static PracticeItemKey fromJson(String json) {
    return ensureInitialized().decodeJson<PracticeItemKey>(json);
  }
}

mixin PracticeItemKeyMappable {
  String toJson() {
    return PracticeItemKeyMapper.ensureInitialized()
        .encodeJson<PracticeItemKey>(this as PracticeItemKey);
  }

  Map<String, dynamic> toMap() {
    return PracticeItemKeyMapper.ensureInitialized().encodeMap<PracticeItemKey>(
      this as PracticeItemKey,
    );
  }

  PracticeItemKeyCopyWith<PracticeItemKey, PracticeItemKey, PracticeItemKey>
  get copyWith =>
      _PracticeItemKeyCopyWithImpl<PracticeItemKey, PracticeItemKey>(
        this as PracticeItemKey,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PracticeItemKeyMapper.ensureInitialized().stringifyValue(
      this as PracticeItemKey,
    );
  }

  @override
  bool operator ==(Object other) {
    return PracticeItemKeyMapper.ensureInitialized().equalsValue(
      this as PracticeItemKey,
      other,
    );
  }

  @override
  int get hashCode {
    return PracticeItemKeyMapper.ensureInitialized().hashValue(
      this as PracticeItemKey,
    );
  }
}

extension PracticeItemKeyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PracticeItemKey, $Out> {
  PracticeItemKeyCopyWith<$R, PracticeItemKey, $Out> get $asPracticeItemKey =>
      $base.as((v, t, t2) => _PracticeItemKeyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PracticeItemKeyCopyWith<$R, $In extends PracticeItemKey, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? vocabularyId, Language? language});
  PracticeItemKeyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PracticeItemKeyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PracticeItemKey, $Out>
    implements PracticeItemKeyCopyWith<$R, PracticeItemKey, $Out> {
  _PracticeItemKeyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PracticeItemKey> $mapper =
      PracticeItemKeyMapper.ensureInitialized();
  @override
  $R call({String? vocabularyId, Language? language}) => $apply(
    FieldCopyWithData({
      if (vocabularyId != null) #vocabularyId: vocabularyId,
      if (language != null) #language: language,
    }),
  );
  @override
  PracticeItemKey $make(CopyWithData data) => PracticeItemKey(
    vocabularyId: data.get(#vocabularyId, or: $value.vocabularyId),
    language: data.get(#language, or: $value.language),
  );

  @override
  PracticeItemKeyCopyWith<$R2, PracticeItemKey, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PracticeItemKeyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CustomPracticeFilterMapper extends ClassMapperBase<CustomPracticeFilter> {
  CustomPracticeFilterMapper._();

  static CustomPracticeFilterMapper? _instance;
  static CustomPracticeFilterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomPracticeFilterMapper._());
      PracticeWordsMapper.ensureInitialized();
      PracticeNewWordsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CustomPracticeFilter';

  static Set<Language> _$languages(CustomPracticeFilter v) => v.languages;
  static const Field<CustomPracticeFilter, Set<Language>> _f$languages = Field(
    'languages',
    _$languages,
  );
  static Set<String> _$tagIds(CustomPracticeFilter v) => v.tagIds;
  static const Field<CustomPracticeFilter, Set<String>> _f$tagIds = Field(
    'tagIds',
    _$tagIds,
  );
  static PracticeWords _$words(CustomPracticeFilter v) => v.words;
  static const Field<CustomPracticeFilter, PracticeWords> _f$words = Field(
    'words',
    _$words,
  );
  static PracticeNewWords _$newWords(CustomPracticeFilter v) => v.newWords;
  static const Field<CustomPracticeFilter, PracticeNewWords> _f$newWords =
      Field('newWords', _$newWords);

  @override
  final MappableFields<CustomPracticeFilter> fields = const {
    #languages: _f$languages,
    #tagIds: _f$tagIds,
    #words: _f$words,
    #newWords: _f$newWords,
  };

  static CustomPracticeFilter _instantiate(DecodingData data) {
    return CustomPracticeFilter(
      languages: data.dec(_f$languages),
      tagIds: data.dec(_f$tagIds),
      words: data.dec(_f$words),
      newWords: data.dec(_f$newWords),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CustomPracticeFilter fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomPracticeFilter>(map);
  }

  static CustomPracticeFilter fromJson(String json) {
    return ensureInitialized().decodeJson<CustomPracticeFilter>(json);
  }
}

mixin CustomPracticeFilterMappable {
  String toJson() {
    return CustomPracticeFilterMapper.ensureInitialized()
        .encodeJson<CustomPracticeFilter>(this as CustomPracticeFilter);
  }

  Map<String, dynamic> toMap() {
    return CustomPracticeFilterMapper.ensureInitialized()
        .encodeMap<CustomPracticeFilter>(this as CustomPracticeFilter);
  }

  CustomPracticeFilterCopyWith<
    CustomPracticeFilter,
    CustomPracticeFilter,
    CustomPracticeFilter
  >
  get copyWith =>
      _CustomPracticeFilterCopyWithImpl<
        CustomPracticeFilter,
        CustomPracticeFilter
      >(this as CustomPracticeFilter, $identity, $identity);
  @override
  String toString() {
    return CustomPracticeFilterMapper.ensureInitialized().stringifyValue(
      this as CustomPracticeFilter,
    );
  }

  @override
  bool operator ==(Object other) {
    return CustomPracticeFilterMapper.ensureInitialized().equalsValue(
      this as CustomPracticeFilter,
      other,
    );
  }

  @override
  int get hashCode {
    return CustomPracticeFilterMapper.ensureInitialized().hashValue(
      this as CustomPracticeFilter,
    );
  }
}

extension CustomPracticeFilterValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CustomPracticeFilter, $Out> {
  CustomPracticeFilterCopyWith<$R, CustomPracticeFilter, $Out>
  get $asCustomPracticeFilter => $base.as(
    (v, t, t2) => _CustomPracticeFilterCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CustomPracticeFilterCopyWith<
  $R,
  $In extends CustomPracticeFilter,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Set<Language>? languages,
    Set<String>? tagIds,
    PracticeWords? words,
    PracticeNewWords? newWords,
  });
  CustomPracticeFilterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CustomPracticeFilterCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CustomPracticeFilter, $Out>
    implements CustomPracticeFilterCopyWith<$R, CustomPracticeFilter, $Out> {
  _CustomPracticeFilterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CustomPracticeFilter> $mapper =
      CustomPracticeFilterMapper.ensureInitialized();
  @override
  $R call({
    Set<Language>? languages,
    Set<String>? tagIds,
    PracticeWords? words,
    PracticeNewWords? newWords,
  }) => $apply(
    FieldCopyWithData({
      if (languages != null) #languages: languages,
      if (tagIds != null) #tagIds: tagIds,
      if (words != null) #words: words,
      if (newWords != null) #newWords: newWords,
    }),
  );
  @override
  CustomPracticeFilter $make(CopyWithData data) => CustomPracticeFilter(
    languages: data.get(#languages, or: $value.languages),
    tagIds: data.get(#tagIds, or: $value.tagIds),
    words: data.get(#words, or: $value.words),
    newWords: data.get(#newWords, or: $value.newWords),
  );

  @override
  CustomPracticeFilterCopyWith<$R2, CustomPracticeFilter, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CustomPracticeFilterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CustomPracticeSessionMapper
    extends ClassMapperBase<CustomPracticeSession> {
  CustomPracticeSessionMapper._();

  static CustomPracticeSessionMapper? _instance;
  static CustomPracticeSessionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomPracticeSessionMapper._());
      CustomPracticeFilterMapper.ensureInitialized();
      PracticeItemKeyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CustomPracticeSession';

  static CustomPracticeFilter _$filter(CustomPracticeSession v) => v.filter;
  static const Field<CustomPracticeSession, CustomPracticeFilter> _f$filter =
      Field('filter', _$filter);
  static List<PracticeItemKey> _$items(CustomPracticeSession v) => v.items;
  static const Field<CustomPracticeSession, List<PracticeItemKey>> _f$items =
      Field('items', _$items);
  static int _$doneCount(CustomPracticeSession v) => v.doneCount;
  static const Field<CustomPracticeSession, int> _f$doneCount = Field(
    'doneCount',
    _$doneCount,
  );
  static DateTime _$startedAt(CustomPracticeSession v) => v.startedAt;
  static const Field<CustomPracticeSession, DateTime> _f$startedAt = Field(
    'startedAt',
    _$startedAt,
  );

  @override
  final MappableFields<CustomPracticeSession> fields = const {
    #filter: _f$filter,
    #items: _f$items,
    #doneCount: _f$doneCount,
    #startedAt: _f$startedAt,
  };

  static CustomPracticeSession _instantiate(DecodingData data) {
    return CustomPracticeSession(
      filter: data.dec(_f$filter),
      items: data.dec(_f$items),
      doneCount: data.dec(_f$doneCount),
      startedAt: data.dec(_f$startedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CustomPracticeSession fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomPracticeSession>(map);
  }

  static CustomPracticeSession fromJson(String json) {
    return ensureInitialized().decodeJson<CustomPracticeSession>(json);
  }
}

mixin CustomPracticeSessionMappable {
  String toJson() {
    return CustomPracticeSessionMapper.ensureInitialized()
        .encodeJson<CustomPracticeSession>(this as CustomPracticeSession);
  }

  Map<String, dynamic> toMap() {
    return CustomPracticeSessionMapper.ensureInitialized()
        .encodeMap<CustomPracticeSession>(this as CustomPracticeSession);
  }

  CustomPracticeSessionCopyWith<
    CustomPracticeSession,
    CustomPracticeSession,
    CustomPracticeSession
  >
  get copyWith =>
      _CustomPracticeSessionCopyWithImpl<
        CustomPracticeSession,
        CustomPracticeSession
      >(this as CustomPracticeSession, $identity, $identity);
  @override
  String toString() {
    return CustomPracticeSessionMapper.ensureInitialized().stringifyValue(
      this as CustomPracticeSession,
    );
  }

  @override
  bool operator ==(Object other) {
    return CustomPracticeSessionMapper.ensureInitialized().equalsValue(
      this as CustomPracticeSession,
      other,
    );
  }

  @override
  int get hashCode {
    return CustomPracticeSessionMapper.ensureInitialized().hashValue(
      this as CustomPracticeSession,
    );
  }
}

extension CustomPracticeSessionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CustomPracticeSession, $Out> {
  CustomPracticeSessionCopyWith<$R, CustomPracticeSession, $Out>
  get $asCustomPracticeSession => $base.as(
    (v, t, t2) => _CustomPracticeSessionCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CustomPracticeSessionCopyWith<
  $R,
  $In extends CustomPracticeSession,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  CustomPracticeFilterCopyWith<$R, CustomPracticeFilter, CustomPracticeFilter>
  get filter;
  ListCopyWith<
    $R,
    PracticeItemKey,
    PracticeItemKeyCopyWith<$R, PracticeItemKey, PracticeItemKey>
  >
  get items;
  $R call({
    CustomPracticeFilter? filter,
    List<PracticeItemKey>? items,
    int? doneCount,
    DateTime? startedAt,
  });
  CustomPracticeSessionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CustomPracticeSessionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CustomPracticeSession, $Out>
    implements CustomPracticeSessionCopyWith<$R, CustomPracticeSession, $Out> {
  _CustomPracticeSessionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CustomPracticeSession> $mapper =
      CustomPracticeSessionMapper.ensureInitialized();
  @override
  CustomPracticeFilterCopyWith<$R, CustomPracticeFilter, CustomPracticeFilter>
  get filter => $value.filter.copyWith.$chain((v) => call(filter: v));
  @override
  ListCopyWith<
    $R,
    PracticeItemKey,
    PracticeItemKeyCopyWith<$R, PracticeItemKey, PracticeItemKey>
  >
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({
    CustomPracticeFilter? filter,
    List<PracticeItemKey>? items,
    int? doneCount,
    DateTime? startedAt,
  }) => $apply(
    FieldCopyWithData({
      if (filter != null) #filter: filter,
      if (items != null) #items: items,
      if (doneCount != null) #doneCount: doneCount,
      if (startedAt != null) #startedAt: startedAt,
    }),
  );
  @override
  CustomPracticeSession $make(CopyWithData data) => CustomPracticeSession(
    filter: data.get(#filter, or: $value.filter),
    items: data.get(#items, or: $value.items),
    doneCount: data.get(#doneCount, or: $value.doneCount),
    startedAt: data.get(#startedAt, or: $value.startedAt),
  );

  @override
  CustomPracticeSessionCopyWith<$R2, CustomPracticeSession, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CustomPracticeSessionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

