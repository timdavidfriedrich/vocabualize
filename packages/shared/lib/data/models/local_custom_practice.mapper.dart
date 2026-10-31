// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_custom_practice.dart';

class LocalCustomPracticeMapper extends ClassMapperBase<LocalCustomPractice> {
  LocalCustomPracticeMapper._();

  static LocalCustomPracticeMapper? _instance;
  static LocalCustomPracticeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalCustomPracticeMapper._());
      LocalCustomPracticeItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalCustomPractice';

  static List<String> _$languages(LocalCustomPractice v) => v.languages;
  static const Field<LocalCustomPractice, List<String>> _f$languages = Field(
    'languages',
    _$languages,
  );
  static List<String> _$tagIds(LocalCustomPractice v) => v.tagIds;
  static const Field<LocalCustomPractice, List<String>> _f$tagIds = Field(
    'tagIds',
    _$tagIds,
  );
  static String _$words(LocalCustomPractice v) => v.words;
  static const Field<LocalCustomPractice, String> _f$words = Field(
    'words',
    _$words,
  );
  static String _$newWords(LocalCustomPractice v) => v.newWords;
  static const Field<LocalCustomPractice, String> _f$newWords = Field(
    'newWords',
    _$newWords,
  );
  static List<LocalCustomPracticeItem> _$items(LocalCustomPractice v) =>
      v.items;
  static const Field<LocalCustomPractice, List<LocalCustomPracticeItem>>
  _f$items = Field('items', _$items);
  static int _$doneCount(LocalCustomPractice v) => v.doneCount;
  static const Field<LocalCustomPractice, int> _f$doneCount = Field(
    'doneCount',
    _$doneCount,
  );
  static DateTime _$startedAt(LocalCustomPractice v) => v.startedAt;
  static const Field<LocalCustomPractice, DateTime> _f$startedAt = Field(
    'startedAt',
    _$startedAt,
  );

  @override
  final MappableFields<LocalCustomPractice> fields = const {
    #languages: _f$languages,
    #tagIds: _f$tagIds,
    #words: _f$words,
    #newWords: _f$newWords,
    #items: _f$items,
    #doneCount: _f$doneCount,
    #startedAt: _f$startedAt,
  };

  static LocalCustomPractice _instantiate(DecodingData data) {
    return LocalCustomPractice(
      languages: data.dec(_f$languages),
      tagIds: data.dec(_f$tagIds),
      words: data.dec(_f$words),
      newWords: data.dec(_f$newWords),
      items: data.dec(_f$items),
      doneCount: data.dec(_f$doneCount),
      startedAt: data.dec(_f$startedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalCustomPractice fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalCustomPractice>(map);
  }

  static LocalCustomPractice fromJson(String json) {
    return ensureInitialized().decodeJson<LocalCustomPractice>(json);
  }
}

mixin LocalCustomPracticeMappable {
  String toJson() {
    return LocalCustomPracticeMapper.ensureInitialized()
        .encodeJson<LocalCustomPractice>(this as LocalCustomPractice);
  }

  Map<String, dynamic> toMap() {
    return LocalCustomPracticeMapper.ensureInitialized()
        .encodeMap<LocalCustomPractice>(this as LocalCustomPractice);
  }

  LocalCustomPracticeCopyWith<
    LocalCustomPractice,
    LocalCustomPractice,
    LocalCustomPractice
  >
  get copyWith =>
      _LocalCustomPracticeCopyWithImpl<
        LocalCustomPractice,
        LocalCustomPractice
      >(this as LocalCustomPractice, $identity, $identity);
  @override
  String toString() {
    return LocalCustomPracticeMapper.ensureInitialized().stringifyValue(
      this as LocalCustomPractice,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalCustomPracticeMapper.ensureInitialized().equalsValue(
      this as LocalCustomPractice,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalCustomPracticeMapper.ensureInitialized().hashValue(
      this as LocalCustomPractice,
    );
  }
}

extension LocalCustomPracticeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalCustomPractice, $Out> {
  LocalCustomPracticeCopyWith<$R, LocalCustomPractice, $Out>
  get $asLocalCustomPractice => $base.as(
    (v, t, t2) => _LocalCustomPracticeCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalCustomPracticeCopyWith<
  $R,
  $In extends LocalCustomPractice,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get languages;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tagIds;
  ListCopyWith<
    $R,
    LocalCustomPracticeItem,
    LocalCustomPracticeItemCopyWith<
      $R,
      LocalCustomPracticeItem,
      LocalCustomPracticeItem
    >
  >
  get items;
  $R call({
    List<String>? languages,
    List<String>? tagIds,
    String? words,
    String? newWords,
    List<LocalCustomPracticeItem>? items,
    int? doneCount,
    DateTime? startedAt,
  });
  LocalCustomPracticeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalCustomPracticeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalCustomPractice, $Out>
    implements LocalCustomPracticeCopyWith<$R, LocalCustomPractice, $Out> {
  _LocalCustomPracticeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalCustomPractice> $mapper =
      LocalCustomPracticeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get languages =>
      ListCopyWith(
        $value.languages,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(languages: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tagIds =>
      ListCopyWith(
        $value.tagIds,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(tagIds: v),
      );
  @override
  ListCopyWith<
    $R,
    LocalCustomPracticeItem,
    LocalCustomPracticeItemCopyWith<
      $R,
      LocalCustomPracticeItem,
      LocalCustomPracticeItem
    >
  >
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({
    List<String>? languages,
    List<String>? tagIds,
    String? words,
    String? newWords,
    List<LocalCustomPracticeItem>? items,
    int? doneCount,
    DateTime? startedAt,
  }) => $apply(
    FieldCopyWithData({
      if (languages != null) #languages: languages,
      if (tagIds != null) #tagIds: tagIds,
      if (words != null) #words: words,
      if (newWords != null) #newWords: newWords,
      if (items != null) #items: items,
      if (doneCount != null) #doneCount: doneCount,
      if (startedAt != null) #startedAt: startedAt,
    }),
  );
  @override
  LocalCustomPractice $make(CopyWithData data) => LocalCustomPractice(
    languages: data.get(#languages, or: $value.languages),
    tagIds: data.get(#tagIds, or: $value.tagIds),
    words: data.get(#words, or: $value.words),
    newWords: data.get(#newWords, or: $value.newWords),
    items: data.get(#items, or: $value.items),
    doneCount: data.get(#doneCount, or: $value.doneCount),
    startedAt: data.get(#startedAt, or: $value.startedAt),
  );

  @override
  LocalCustomPracticeCopyWith<$R2, LocalCustomPractice, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalCustomPracticeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LocalCustomPracticeItemMapper
    extends ClassMapperBase<LocalCustomPracticeItem> {
  LocalCustomPracticeItemMapper._();

  static LocalCustomPracticeItemMapper? _instance;
  static LocalCustomPracticeItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LocalCustomPracticeItemMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'LocalCustomPracticeItem';

  static String _$vocabularyId(LocalCustomPracticeItem v) => v.vocabularyId;
  static const Field<LocalCustomPracticeItem, String> _f$vocabularyId = Field(
    'vocabularyId',
    _$vocabularyId,
  );
  static String _$language(LocalCustomPracticeItem v) => v.language;
  static const Field<LocalCustomPracticeItem, String> _f$language = Field(
    'language',
    _$language,
  );

  @override
  final MappableFields<LocalCustomPracticeItem> fields = const {
    #vocabularyId: _f$vocabularyId,
    #language: _f$language,
  };

  static LocalCustomPracticeItem _instantiate(DecodingData data) {
    return LocalCustomPracticeItem(
      vocabularyId: data.dec(_f$vocabularyId),
      language: data.dec(_f$language),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalCustomPracticeItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalCustomPracticeItem>(map);
  }

  static LocalCustomPracticeItem fromJson(String json) {
    return ensureInitialized().decodeJson<LocalCustomPracticeItem>(json);
  }
}

mixin LocalCustomPracticeItemMappable {
  String toJson() {
    return LocalCustomPracticeItemMapper.ensureInitialized()
        .encodeJson<LocalCustomPracticeItem>(this as LocalCustomPracticeItem);
  }

  Map<String, dynamic> toMap() {
    return LocalCustomPracticeItemMapper.ensureInitialized()
        .encodeMap<LocalCustomPracticeItem>(this as LocalCustomPracticeItem);
  }

  LocalCustomPracticeItemCopyWith<
    LocalCustomPracticeItem,
    LocalCustomPracticeItem,
    LocalCustomPracticeItem
  >
  get copyWith =>
      _LocalCustomPracticeItemCopyWithImpl<
        LocalCustomPracticeItem,
        LocalCustomPracticeItem
      >(this as LocalCustomPracticeItem, $identity, $identity);
  @override
  String toString() {
    return LocalCustomPracticeItemMapper.ensureInitialized().stringifyValue(
      this as LocalCustomPracticeItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalCustomPracticeItemMapper.ensureInitialized().equalsValue(
      this as LocalCustomPracticeItem,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalCustomPracticeItemMapper.ensureInitialized().hashValue(
      this as LocalCustomPracticeItem,
    );
  }
}

extension LocalCustomPracticeItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalCustomPracticeItem, $Out> {
  LocalCustomPracticeItemCopyWith<$R, LocalCustomPracticeItem, $Out>
  get $asLocalCustomPracticeItem => $base.as(
    (v, t, t2) => _LocalCustomPracticeItemCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalCustomPracticeItemCopyWith<
  $R,
  $In extends LocalCustomPracticeItem,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? vocabularyId, String? language});
  LocalCustomPracticeItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalCustomPracticeItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalCustomPracticeItem, $Out>
    implements
        LocalCustomPracticeItemCopyWith<$R, LocalCustomPracticeItem, $Out> {
  _LocalCustomPracticeItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalCustomPracticeItem> $mapper =
      LocalCustomPracticeItemMapper.ensureInitialized();
  @override
  $R call({String? vocabularyId, String? language}) => $apply(
    FieldCopyWithData({
      if (vocabularyId != null) #vocabularyId: vocabularyId,
      if (language != null) #language: language,
    }),
  );
  @override
  LocalCustomPracticeItem $make(CopyWithData data) => LocalCustomPracticeItem(
    vocabularyId: data.get(#vocabularyId, or: $value.vocabularyId),
    language: data.get(#language, or: $value.language),
  );

  @override
  LocalCustomPracticeItemCopyWith<$R2, LocalCustomPracticeItem, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalCustomPracticeItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

