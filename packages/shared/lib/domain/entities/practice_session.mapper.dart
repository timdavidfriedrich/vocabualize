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

  @override
  final MappableFields<CustomPracticeFilter> fields = const {
    #languages: _f$languages,
    #tagIds: _f$tagIds,
  };

  static CustomPracticeFilter _instantiate(DecodingData data) {
    return CustomPracticeFilter(
      languages: data.dec(_f$languages),
      tagIds: data.dec(_f$tagIds),
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
  $R call({Set<Language>? languages, Set<String>? tagIds});
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
  $R call({Set<Language>? languages, Set<String>? tagIds}) => $apply(
    FieldCopyWithData({
      if (languages != null) #languages: languages,
      if (tagIds != null) #tagIds: tagIds,
    }),
  );
  @override
  CustomPracticeFilter $make(CopyWithData data) => CustomPracticeFilter(
    languages: data.get(#languages, or: $value.languages),
    tagIds: data.get(#tagIds, or: $value.tagIds),
  );

  @override
  CustomPracticeFilterCopyWith<$R2, CustomPracticeFilter, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CustomPracticeFilterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CustomPracticeLanguagePlanMapper
    extends ClassMapperBase<CustomPracticeLanguagePlan> {
  CustomPracticeLanguagePlanMapper._();

  static CustomPracticeLanguagePlanMapper? _instance;
  static CustomPracticeLanguagePlanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = CustomPracticeLanguagePlanMapper._(),
      );
      PracticeWordsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CustomPracticeLanguagePlan';

  static Language _$language(CustomPracticeLanguagePlan v) => v.language;
  static const Field<CustomPracticeLanguagePlan, Language> _f$language = Field(
    'language',
    _$language,
  );
  static PracticeWords _$words(CustomPracticeLanguagePlan v) => v.words;
  static const Field<CustomPracticeLanguagePlan, PracticeWords> _f$words =
      Field('words', _$words);
  static int _$reviewWordCount(CustomPracticeLanguagePlan v) =>
      v.reviewWordCount;
  static const Field<CustomPracticeLanguagePlan, int> _f$reviewWordCount =
      Field('reviewWordCount', _$reviewWordCount);
  static int _$newWordCount(CustomPracticeLanguagePlan v) => v.newWordCount;
  static const Field<CustomPracticeLanguagePlan, int> _f$newWordCount = Field(
    'newWordCount',
    _$newWordCount,
  );

  @override
  final MappableFields<CustomPracticeLanguagePlan> fields = const {
    #language: _f$language,
    #words: _f$words,
    #reviewWordCount: _f$reviewWordCount,
    #newWordCount: _f$newWordCount,
  };

  static CustomPracticeLanguagePlan _instantiate(DecodingData data) {
    return CustomPracticeLanguagePlan(
      language: data.dec(_f$language),
      words: data.dec(_f$words),
      reviewWordCount: data.dec(_f$reviewWordCount),
      newWordCount: data.dec(_f$newWordCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CustomPracticeLanguagePlan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomPracticeLanguagePlan>(map);
  }

  static CustomPracticeLanguagePlan fromJson(String json) {
    return ensureInitialized().decodeJson<CustomPracticeLanguagePlan>(json);
  }
}

mixin CustomPracticeLanguagePlanMappable {
  String toJson() {
    return CustomPracticeLanguagePlanMapper.ensureInitialized()
        .encodeJson<CustomPracticeLanguagePlan>(
          this as CustomPracticeLanguagePlan,
        );
  }

  Map<String, dynamic> toMap() {
    return CustomPracticeLanguagePlanMapper.ensureInitialized()
        .encodeMap<CustomPracticeLanguagePlan>(
          this as CustomPracticeLanguagePlan,
        );
  }

  CustomPracticeLanguagePlanCopyWith<
    CustomPracticeLanguagePlan,
    CustomPracticeLanguagePlan,
    CustomPracticeLanguagePlan
  >
  get copyWith =>
      _CustomPracticeLanguagePlanCopyWithImpl<
        CustomPracticeLanguagePlan,
        CustomPracticeLanguagePlan
      >(this as CustomPracticeLanguagePlan, $identity, $identity);
  @override
  String toString() {
    return CustomPracticeLanguagePlanMapper.ensureInitialized().stringifyValue(
      this as CustomPracticeLanguagePlan,
    );
  }

  @override
  bool operator ==(Object other) {
    return CustomPracticeLanguagePlanMapper.ensureInitialized().equalsValue(
      this as CustomPracticeLanguagePlan,
      other,
    );
  }

  @override
  int get hashCode {
    return CustomPracticeLanguagePlanMapper.ensureInitialized().hashValue(
      this as CustomPracticeLanguagePlan,
    );
  }
}

extension CustomPracticeLanguagePlanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CustomPracticeLanguagePlan, $Out> {
  CustomPracticeLanguagePlanCopyWith<$R, CustomPracticeLanguagePlan, $Out>
  get $asCustomPracticeLanguagePlan => $base.as(
    (v, t, t2) => _CustomPracticeLanguagePlanCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CustomPracticeLanguagePlanCopyWith<
  $R,
  $In extends CustomPracticeLanguagePlan,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Language? language,
    PracticeWords? words,
    int? reviewWordCount,
    int? newWordCount,
  });
  CustomPracticeLanguagePlanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CustomPracticeLanguagePlanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CustomPracticeLanguagePlan, $Out>
    implements
        CustomPracticeLanguagePlanCopyWith<
          $R,
          CustomPracticeLanguagePlan,
          $Out
        > {
  _CustomPracticeLanguagePlanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CustomPracticeLanguagePlan> $mapper =
      CustomPracticeLanguagePlanMapper.ensureInitialized();
  @override
  $R call({
    Language? language,
    PracticeWords? words,
    int? reviewWordCount,
    int? newWordCount,
  }) => $apply(
    FieldCopyWithData({
      if (language != null) #language: language,
      if (words != null) #words: words,
      if (reviewWordCount != null) #reviewWordCount: reviewWordCount,
      if (newWordCount != null) #newWordCount: newWordCount,
    }),
  );
  @override
  CustomPracticeLanguagePlan $make(CopyWithData data) =>
      CustomPracticeLanguagePlan(
        language: data.get(#language, or: $value.language),
        words: data.get(#words, or: $value.words),
        reviewWordCount: data.get(#reviewWordCount, or: $value.reviewWordCount),
        newWordCount: data.get(#newWordCount, or: $value.newWordCount),
      );

  @override
  CustomPracticeLanguagePlanCopyWith<$R2, CustomPracticeLanguagePlan, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CustomPracticeLanguagePlanCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CustomPracticePlanMapper extends ClassMapperBase<CustomPracticePlan> {
  CustomPracticePlanMapper._();

  static CustomPracticePlanMapper? _instance;
  static CustomPracticePlanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomPracticePlanMapper._());
      CustomPracticeLanguagePlanMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CustomPracticePlan';

  static List<CustomPracticeLanguagePlan> _$languages(CustomPracticePlan v) =>
      v.languages;
  static const Field<CustomPracticePlan, List<CustomPracticeLanguagePlan>>
  _f$languages = Field('languages', _$languages);
  static Set<String> _$tagIds(CustomPracticePlan v) => v.tagIds;
  static const Field<CustomPracticePlan, Set<String>> _f$tagIds = Field(
    'tagIds',
    _$tagIds,
  );

  @override
  final MappableFields<CustomPracticePlan> fields = const {
    #languages: _f$languages,
    #tagIds: _f$tagIds,
  };

  static CustomPracticePlan _instantiate(DecodingData data) {
    return CustomPracticePlan(
      languages: data.dec(_f$languages),
      tagIds: data.dec(_f$tagIds),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CustomPracticePlan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomPracticePlan>(map);
  }

  static CustomPracticePlan fromJson(String json) {
    return ensureInitialized().decodeJson<CustomPracticePlan>(json);
  }
}

mixin CustomPracticePlanMappable {
  String toJson() {
    return CustomPracticePlanMapper.ensureInitialized()
        .encodeJson<CustomPracticePlan>(this as CustomPracticePlan);
  }

  Map<String, dynamic> toMap() {
    return CustomPracticePlanMapper.ensureInitialized()
        .encodeMap<CustomPracticePlan>(this as CustomPracticePlan);
  }

  CustomPracticePlanCopyWith<
    CustomPracticePlan,
    CustomPracticePlan,
    CustomPracticePlan
  >
  get copyWith =>
      _CustomPracticePlanCopyWithImpl<CustomPracticePlan, CustomPracticePlan>(
        this as CustomPracticePlan,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CustomPracticePlanMapper.ensureInitialized().stringifyValue(
      this as CustomPracticePlan,
    );
  }

  @override
  bool operator ==(Object other) {
    return CustomPracticePlanMapper.ensureInitialized().equalsValue(
      this as CustomPracticePlan,
      other,
    );
  }

  @override
  int get hashCode {
    return CustomPracticePlanMapper.ensureInitialized().hashValue(
      this as CustomPracticePlan,
    );
  }
}

extension CustomPracticePlanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CustomPracticePlan, $Out> {
  CustomPracticePlanCopyWith<$R, CustomPracticePlan, $Out>
  get $asCustomPracticePlan => $base.as(
    (v, t, t2) => _CustomPracticePlanCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CustomPracticePlanCopyWith<
  $R,
  $In extends CustomPracticePlan,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    CustomPracticeLanguagePlan,
    CustomPracticeLanguagePlanCopyWith<
      $R,
      CustomPracticeLanguagePlan,
      CustomPracticeLanguagePlan
    >
  >
  get languages;
  $R call({List<CustomPracticeLanguagePlan>? languages, Set<String>? tagIds});
  CustomPracticePlanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CustomPracticePlanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CustomPracticePlan, $Out>
    implements CustomPracticePlanCopyWith<$R, CustomPracticePlan, $Out> {
  _CustomPracticePlanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CustomPracticePlan> $mapper =
      CustomPracticePlanMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    CustomPracticeLanguagePlan,
    CustomPracticeLanguagePlanCopyWith<
      $R,
      CustomPracticeLanguagePlan,
      CustomPracticeLanguagePlan
    >
  >
  get languages => ListCopyWith(
    $value.languages,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(languages: v),
  );
  @override
  $R call({List<CustomPracticeLanguagePlan>? languages, Set<String>? tagIds}) =>
      $apply(
        FieldCopyWithData({
          if (languages != null) #languages: languages,
          if (tagIds != null) #tagIds: tagIds,
        }),
      );
  @override
  CustomPracticePlan $make(CopyWithData data) => CustomPracticePlan(
    languages: data.get(#languages, or: $value.languages),
    tagIds: data.get(#tagIds, or: $value.tagIds),
  );

  @override
  CustomPracticePlanCopyWith<$R2, CustomPracticePlan, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CustomPracticePlanCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CustomPracticeCountsMapper extends ClassMapperBase<CustomPracticeCounts> {
  CustomPracticeCountsMapper._();

  static CustomPracticeCountsMapper? _instance;
  static CustomPracticeCountsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomPracticeCountsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CustomPracticeCounts';

  static int _$dueCount(CustomPracticeCounts v) => v.dueCount;
  static const Field<CustomPracticeCounts, int> _f$dueCount = Field(
    'dueCount',
    _$dueCount,
  );
  static int _$startedCount(CustomPracticeCounts v) => v.startedCount;
  static const Field<CustomPracticeCounts, int> _f$startedCount = Field(
    'startedCount',
    _$startedCount,
  );
  static int _$waitingCount(CustomPracticeCounts v) => v.waitingCount;
  static const Field<CustomPracticeCounts, int> _f$waitingCount = Field(
    'waitingCount',
    _$waitingCount,
  );

  @override
  final MappableFields<CustomPracticeCounts> fields = const {
    #dueCount: _f$dueCount,
    #startedCount: _f$startedCount,
    #waitingCount: _f$waitingCount,
  };

  static CustomPracticeCounts _instantiate(DecodingData data) {
    return CustomPracticeCounts(
      dueCount: data.dec(_f$dueCount),
      startedCount: data.dec(_f$startedCount),
      waitingCount: data.dec(_f$waitingCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CustomPracticeCounts fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomPracticeCounts>(map);
  }

  static CustomPracticeCounts fromJson(String json) {
    return ensureInitialized().decodeJson<CustomPracticeCounts>(json);
  }
}

mixin CustomPracticeCountsMappable {
  String toJson() {
    return CustomPracticeCountsMapper.ensureInitialized()
        .encodeJson<CustomPracticeCounts>(this as CustomPracticeCounts);
  }

  Map<String, dynamic> toMap() {
    return CustomPracticeCountsMapper.ensureInitialized()
        .encodeMap<CustomPracticeCounts>(this as CustomPracticeCounts);
  }

  CustomPracticeCountsCopyWith<
    CustomPracticeCounts,
    CustomPracticeCounts,
    CustomPracticeCounts
  >
  get copyWith =>
      _CustomPracticeCountsCopyWithImpl<
        CustomPracticeCounts,
        CustomPracticeCounts
      >(this as CustomPracticeCounts, $identity, $identity);
  @override
  String toString() {
    return CustomPracticeCountsMapper.ensureInitialized().stringifyValue(
      this as CustomPracticeCounts,
    );
  }

  @override
  bool operator ==(Object other) {
    return CustomPracticeCountsMapper.ensureInitialized().equalsValue(
      this as CustomPracticeCounts,
      other,
    );
  }

  @override
  int get hashCode {
    return CustomPracticeCountsMapper.ensureInitialized().hashValue(
      this as CustomPracticeCounts,
    );
  }
}

extension CustomPracticeCountsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CustomPracticeCounts, $Out> {
  CustomPracticeCountsCopyWith<$R, CustomPracticeCounts, $Out>
  get $asCustomPracticeCounts => $base.as(
    (v, t, t2) => _CustomPracticeCountsCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CustomPracticeCountsCopyWith<
  $R,
  $In extends CustomPracticeCounts,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? dueCount, int? startedCount, int? waitingCount});
  CustomPracticeCountsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CustomPracticeCountsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CustomPracticeCounts, $Out>
    implements CustomPracticeCountsCopyWith<$R, CustomPracticeCounts, $Out> {
  _CustomPracticeCountsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CustomPracticeCounts> $mapper =
      CustomPracticeCountsMapper.ensureInitialized();
  @override
  $R call({int? dueCount, int? startedCount, int? waitingCount}) => $apply(
    FieldCopyWithData({
      if (dueCount != null) #dueCount: dueCount,
      if (startedCount != null) #startedCount: startedCount,
      if (waitingCount != null) #waitingCount: waitingCount,
    }),
  );
  @override
  CustomPracticeCounts $make(CopyWithData data) => CustomPracticeCounts(
    dueCount: data.get(#dueCount, or: $value.dueCount),
    startedCount: data.get(#startedCount, or: $value.startedCount),
    waitingCount: data.get(#waitingCount, or: $value.waitingCount),
  );

  @override
  CustomPracticeCountsCopyWith<$R2, CustomPracticeCounts, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CustomPracticeCountsCopyWithImpl<$R2, $Out2>($value, $cast, t);
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

