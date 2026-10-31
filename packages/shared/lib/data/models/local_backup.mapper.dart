// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_backup.dart';

class LocalBackupManifestMapper extends ClassMapperBase<LocalBackupManifest> {
  LocalBackupManifestMapper._();

  static LocalBackupManifestMapper? _instance;
  static LocalBackupManifestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalBackupManifestMapper._());
      LocalBackupLanguagesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalBackupManifest';

  static String _$format(LocalBackupManifest v) => v.format;
  static const Field<LocalBackupManifest, String> _f$format = Field(
    'format',
    _$format,
  );
  static int _$version(LocalBackupManifest v) => v.version;
  static const Field<LocalBackupManifest, int> _f$version = Field(
    'version',
    _$version,
  );
  static String _$source(LocalBackupManifest v) => v.source;
  static const Field<LocalBackupManifest, String> _f$source = Field(
    'source',
    _$source,
  );
  static DateTime _$createdAt(LocalBackupManifest v) => v.createdAt;
  static const Field<LocalBackupManifest, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static Map<String, int> _$counts(LocalBackupManifest v) => v.counts;
  static const Field<LocalBackupManifest, Map<String, int>> _f$counts = Field(
    'counts',
    _$counts,
  );
  static List<String> _$missingImages(LocalBackupManifest v) => v.missingImages;
  static const Field<LocalBackupManifest, List<String>> _f$missingImages =
      Field('missingImages', _$missingImages);
  static LocalBackupLanguages? _$languages(LocalBackupManifest v) =>
      v.languages;
  static const Field<LocalBackupManifest, LocalBackupLanguages> _f$languages =
      Field('languages', _$languages);

  @override
  final MappableFields<LocalBackupManifest> fields = const {
    #format: _f$format,
    #version: _f$version,
    #source: _f$source,
    #createdAt: _f$createdAt,
    #counts: _f$counts,
    #missingImages: _f$missingImages,
    #languages: _f$languages,
  };

  static LocalBackupManifest _instantiate(DecodingData data) {
    return LocalBackupManifest(
      format: data.dec(_f$format),
      version: data.dec(_f$version),
      source: data.dec(_f$source),
      createdAt: data.dec(_f$createdAt),
      counts: data.dec(_f$counts),
      missingImages: data.dec(_f$missingImages),
      languages: data.dec(_f$languages),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalBackupManifest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalBackupManifest>(map);
  }

  static LocalBackupManifest fromJson(String json) {
    return ensureInitialized().decodeJson<LocalBackupManifest>(json);
  }
}

mixin LocalBackupManifestMappable {
  String toJson() {
    return LocalBackupManifestMapper.ensureInitialized()
        .encodeJson<LocalBackupManifest>(this as LocalBackupManifest);
  }

  Map<String, dynamic> toMap() {
    return LocalBackupManifestMapper.ensureInitialized()
        .encodeMap<LocalBackupManifest>(this as LocalBackupManifest);
  }

  LocalBackupManifestCopyWith<
    LocalBackupManifest,
    LocalBackupManifest,
    LocalBackupManifest
  >
  get copyWith =>
      _LocalBackupManifestCopyWithImpl<
        LocalBackupManifest,
        LocalBackupManifest
      >(this as LocalBackupManifest, $identity, $identity);
  @override
  String toString() {
    return LocalBackupManifestMapper.ensureInitialized().stringifyValue(
      this as LocalBackupManifest,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalBackupManifestMapper.ensureInitialized().equalsValue(
      this as LocalBackupManifest,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalBackupManifestMapper.ensureInitialized().hashValue(
      this as LocalBackupManifest,
    );
  }
}

extension LocalBackupManifestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalBackupManifest, $Out> {
  LocalBackupManifestCopyWith<$R, LocalBackupManifest, $Out>
  get $asLocalBackupManifest => $base.as(
    (v, t, t2) => _LocalBackupManifestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalBackupManifestCopyWith<
  $R,
  $In extends LocalBackupManifest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>> get counts;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get missingImages;
  LocalBackupLanguagesCopyWith<$R, LocalBackupLanguages, LocalBackupLanguages>?
  get languages;
  $R call({
    String? format,
    int? version,
    String? source,
    DateTime? createdAt,
    Map<String, int>? counts,
    List<String>? missingImages,
    LocalBackupLanguages? languages,
  });
  LocalBackupManifestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalBackupManifestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalBackupManifest, $Out>
    implements LocalBackupManifestCopyWith<$R, LocalBackupManifest, $Out> {
  _LocalBackupManifestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalBackupManifest> $mapper =
      LocalBackupManifestMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>> get counts =>
      MapCopyWith(
        $value.counts,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(counts: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get missingImages => ListCopyWith(
    $value.missingImages,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(missingImages: v),
  );
  @override
  LocalBackupLanguagesCopyWith<$R, LocalBackupLanguages, LocalBackupLanguages>?
  get languages => $value.languages?.copyWith.$chain((v) => call(languages: v));
  @override
  $R call({
    String? format,
    int? version,
    String? source,
    DateTime? createdAt,
    Map<String, int>? counts,
    List<String>? missingImages,
    Object? languages = $none,
  }) => $apply(
    FieldCopyWithData({
      if (format != null) #format: format,
      if (version != null) #version: version,
      if (source != null) #source: source,
      if (createdAt != null) #createdAt: createdAt,
      if (counts != null) #counts: counts,
      if (missingImages != null) #missingImages: missingImages,
      if (languages != $none) #languages: languages,
    }),
  );
  @override
  LocalBackupManifest $make(CopyWithData data) => LocalBackupManifest(
    format: data.get(#format, or: $value.format),
    version: data.get(#version, or: $value.version),
    source: data.get(#source, or: $value.source),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    counts: data.get(#counts, or: $value.counts),
    missingImages: data.get(#missingImages, or: $value.missingImages),
    languages: data.get(#languages, or: $value.languages),
  );

  @override
  LocalBackupManifestCopyWith<$R2, LocalBackupManifest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalBackupManifestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LocalBackupLanguagesMapper extends ClassMapperBase<LocalBackupLanguages> {
  LocalBackupLanguagesMapper._();

  static LocalBackupLanguagesMapper? _instance;
  static LocalBackupLanguagesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalBackupLanguagesMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalBackupLanguages';

  static String? _$mainLanguage(LocalBackupLanguages v) => v.mainLanguage;
  static const Field<LocalBackupLanguages, String> _f$mainLanguage = Field(
    'mainLanguage',
    _$mainLanguage,
  );
  static String? _$selectedLanguage(LocalBackupLanguages v) =>
      v.selectedLanguage;
  static const Field<LocalBackupLanguages, String> _f$selectedLanguage = Field(
    'selectedLanguage',
    _$selectedLanguage,
  );
  static List<String> _$learnedLanguages(LocalBackupLanguages v) =>
      v.learnedLanguages;
  static const Field<LocalBackupLanguages, List<String>> _f$learnedLanguages =
      Field('learnedLanguages', _$learnedLanguages);

  @override
  final MappableFields<LocalBackupLanguages> fields = const {
    #mainLanguage: _f$mainLanguage,
    #selectedLanguage: _f$selectedLanguage,
    #learnedLanguages: _f$learnedLanguages,
  };

  static LocalBackupLanguages _instantiate(DecodingData data) {
    return LocalBackupLanguages(
      mainLanguage: data.dec(_f$mainLanguage),
      selectedLanguage: data.dec(_f$selectedLanguage),
      learnedLanguages: data.dec(_f$learnedLanguages),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalBackupLanguages fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalBackupLanguages>(map);
  }

  static LocalBackupLanguages fromJson(String json) {
    return ensureInitialized().decodeJson<LocalBackupLanguages>(json);
  }
}

mixin LocalBackupLanguagesMappable {
  String toJson() {
    return LocalBackupLanguagesMapper.ensureInitialized()
        .encodeJson<LocalBackupLanguages>(this as LocalBackupLanguages);
  }

  Map<String, dynamic> toMap() {
    return LocalBackupLanguagesMapper.ensureInitialized()
        .encodeMap<LocalBackupLanguages>(this as LocalBackupLanguages);
  }

  LocalBackupLanguagesCopyWith<
    LocalBackupLanguages,
    LocalBackupLanguages,
    LocalBackupLanguages
  >
  get copyWith =>
      _LocalBackupLanguagesCopyWithImpl<
        LocalBackupLanguages,
        LocalBackupLanguages
      >(this as LocalBackupLanguages, $identity, $identity);
  @override
  String toString() {
    return LocalBackupLanguagesMapper.ensureInitialized().stringifyValue(
      this as LocalBackupLanguages,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalBackupLanguagesMapper.ensureInitialized().equalsValue(
      this as LocalBackupLanguages,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalBackupLanguagesMapper.ensureInitialized().hashValue(
      this as LocalBackupLanguages,
    );
  }
}

extension LocalBackupLanguagesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalBackupLanguages, $Out> {
  LocalBackupLanguagesCopyWith<$R, LocalBackupLanguages, $Out>
  get $asLocalBackupLanguages => $base.as(
    (v, t, t2) => _LocalBackupLanguagesCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalBackupLanguagesCopyWith<
  $R,
  $In extends LocalBackupLanguages,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get learnedLanguages;
  $R call({
    String? mainLanguage,
    String? selectedLanguage,
    List<String>? learnedLanguages,
  });
  LocalBackupLanguagesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalBackupLanguagesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalBackupLanguages, $Out>
    implements LocalBackupLanguagesCopyWith<$R, LocalBackupLanguages, $Out> {
  _LocalBackupLanguagesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalBackupLanguages> $mapper =
      LocalBackupLanguagesMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get learnedLanguages => ListCopyWith(
    $value.learnedLanguages,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(learnedLanguages: v),
  );
  @override
  $R call({
    Object? mainLanguage = $none,
    Object? selectedLanguage = $none,
    List<String>? learnedLanguages,
  }) => $apply(
    FieldCopyWithData({
      if (mainLanguage != $none) #mainLanguage: mainLanguage,
      if (selectedLanguage != $none) #selectedLanguage: selectedLanguage,
      if (learnedLanguages != null) #learnedLanguages: learnedLanguages,
    }),
  );
  @override
  LocalBackupLanguages $make(CopyWithData data) => LocalBackupLanguages(
    mainLanguage: data.get(#mainLanguage, or: $value.mainLanguage),
    selectedLanguage: data.get(#selectedLanguage, or: $value.selectedLanguage),
    learnedLanguages: data.get(#learnedLanguages, or: $value.learnedLanguages),
  );

  @override
  LocalBackupLanguagesCopyWith<$R2, LocalBackupLanguages, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalBackupLanguagesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LocalBackupVocabularyMapper
    extends ClassMapperBase<LocalBackupVocabulary> {
  LocalBackupVocabularyMapper._();

  static LocalBackupVocabularyMapper? _instance;
  static LocalBackupVocabularyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalBackupVocabularyMapper._());
      LocalBackupTranslationMapper.ensureInitialized();
      LocalBackupProgressMapper.ensureInitialized();
      LocalBackupImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalBackupVocabulary';

  static String _$id(LocalBackupVocabulary v) => v.id;
  static const Field<LocalBackupVocabulary, String> _f$id = Field('id', _$id);
  static List<LocalBackupTranslation> _$translations(LocalBackupVocabulary v) =>
      v.translations;
  static const Field<LocalBackupVocabulary, List<LocalBackupTranslation>>
  _f$translations = Field('translations', _$translations);
  static List<LocalBackupProgress> _$progress(LocalBackupVocabulary v) =>
      v.progress;
  static const Field<LocalBackupVocabulary, List<LocalBackupProgress>>
  _f$progress = Field('progress', _$progress);
  static List<String> _$tagIds(LocalBackupVocabulary v) => v.tagIds;
  static const Field<LocalBackupVocabulary, List<String>> _f$tagIds = Field(
    'tagIds',
    _$tagIds,
  );
  static DateTime _$createdAt(LocalBackupVocabulary v) => v.createdAt;
  static const Field<LocalBackupVocabulary, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static LocalBackupImage? _$image(LocalBackupVocabulary v) => v.image;
  static const Field<LocalBackupVocabulary, LocalBackupImage> _f$image = Field(
    'image',
    _$image,
  );

  @override
  final MappableFields<LocalBackupVocabulary> fields = const {
    #id: _f$id,
    #translations: _f$translations,
    #progress: _f$progress,
    #tagIds: _f$tagIds,
    #createdAt: _f$createdAt,
    #image: _f$image,
  };

  static LocalBackupVocabulary _instantiate(DecodingData data) {
    return LocalBackupVocabulary(
      id: data.dec(_f$id),
      translations: data.dec(_f$translations),
      progress: data.dec(_f$progress),
      tagIds: data.dec(_f$tagIds),
      createdAt: data.dec(_f$createdAt),
      image: data.dec(_f$image),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalBackupVocabulary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalBackupVocabulary>(map);
  }

  static LocalBackupVocabulary fromJson(String json) {
    return ensureInitialized().decodeJson<LocalBackupVocabulary>(json);
  }
}

mixin LocalBackupVocabularyMappable {
  String toJson() {
    return LocalBackupVocabularyMapper.ensureInitialized()
        .encodeJson<LocalBackupVocabulary>(this as LocalBackupVocabulary);
  }

  Map<String, dynamic> toMap() {
    return LocalBackupVocabularyMapper.ensureInitialized()
        .encodeMap<LocalBackupVocabulary>(this as LocalBackupVocabulary);
  }

  LocalBackupVocabularyCopyWith<
    LocalBackupVocabulary,
    LocalBackupVocabulary,
    LocalBackupVocabulary
  >
  get copyWith =>
      _LocalBackupVocabularyCopyWithImpl<
        LocalBackupVocabulary,
        LocalBackupVocabulary
      >(this as LocalBackupVocabulary, $identity, $identity);
  @override
  String toString() {
    return LocalBackupVocabularyMapper.ensureInitialized().stringifyValue(
      this as LocalBackupVocabulary,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalBackupVocabularyMapper.ensureInitialized().equalsValue(
      this as LocalBackupVocabulary,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalBackupVocabularyMapper.ensureInitialized().hashValue(
      this as LocalBackupVocabulary,
    );
  }
}

extension LocalBackupVocabularyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalBackupVocabulary, $Out> {
  LocalBackupVocabularyCopyWith<$R, LocalBackupVocabulary, $Out>
  get $asLocalBackupVocabulary => $base.as(
    (v, t, t2) => _LocalBackupVocabularyCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalBackupVocabularyCopyWith<
  $R,
  $In extends LocalBackupVocabulary,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    LocalBackupTranslation,
    LocalBackupTranslationCopyWith<
      $R,
      LocalBackupTranslation,
      LocalBackupTranslation
    >
  >
  get translations;
  ListCopyWith<
    $R,
    LocalBackupProgress,
    LocalBackupProgressCopyWith<$R, LocalBackupProgress, LocalBackupProgress>
  >
  get progress;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tagIds;
  LocalBackupImageCopyWith<$R, LocalBackupImage, LocalBackupImage>? get image;
  $R call({
    String? id,
    List<LocalBackupTranslation>? translations,
    List<LocalBackupProgress>? progress,
    List<String>? tagIds,
    DateTime? createdAt,
    LocalBackupImage? image,
  });
  LocalBackupVocabularyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalBackupVocabularyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalBackupVocabulary, $Out>
    implements LocalBackupVocabularyCopyWith<$R, LocalBackupVocabulary, $Out> {
  _LocalBackupVocabularyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalBackupVocabulary> $mapper =
      LocalBackupVocabularyMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    LocalBackupTranslation,
    LocalBackupTranslationCopyWith<
      $R,
      LocalBackupTranslation,
      LocalBackupTranslation
    >
  >
  get translations => ListCopyWith(
    $value.translations,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(translations: v),
  );
  @override
  ListCopyWith<
    $R,
    LocalBackupProgress,
    LocalBackupProgressCopyWith<$R, LocalBackupProgress, LocalBackupProgress>
  >
  get progress => ListCopyWith(
    $value.progress,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(progress: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tagIds =>
      ListCopyWith(
        $value.tagIds,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(tagIds: v),
      );
  @override
  LocalBackupImageCopyWith<$R, LocalBackupImage, LocalBackupImage>? get image =>
      $value.image?.copyWith.$chain((v) => call(image: v));
  @override
  $R call({
    String? id,
    List<LocalBackupTranslation>? translations,
    List<LocalBackupProgress>? progress,
    List<String>? tagIds,
    DateTime? createdAt,
    Object? image = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (translations != null) #translations: translations,
      if (progress != null) #progress: progress,
      if (tagIds != null) #tagIds: tagIds,
      if (createdAt != null) #createdAt: createdAt,
      if (image != $none) #image: image,
    }),
  );
  @override
  LocalBackupVocabulary $make(CopyWithData data) => LocalBackupVocabulary(
    id: data.get(#id, or: $value.id),
    translations: data.get(#translations, or: $value.translations),
    progress: data.get(#progress, or: $value.progress),
    tagIds: data.get(#tagIds, or: $value.tagIds),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    image: data.get(#image, or: $value.image),
  );

  @override
  LocalBackupVocabularyCopyWith<$R2, LocalBackupVocabulary, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalBackupVocabularyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LocalBackupTranslationMapper
    extends ClassMapperBase<LocalBackupTranslation> {
  LocalBackupTranslationMapper._();

  static LocalBackupTranslationMapper? _instance;
  static LocalBackupTranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalBackupTranslationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalBackupTranslation';

  static String _$language(LocalBackupTranslation v) => v.language;
  static const Field<LocalBackupTranslation, String> _f$language = Field(
    'language',
    _$language,
  );
  static String _$text(LocalBackupTranslation v) => v.text;
  static const Field<LocalBackupTranslation, String> _f$text = Field(
    'text',
    _$text,
  );
  static String _$origin(LocalBackupTranslation v) => v.origin;
  static const Field<LocalBackupTranslation, String> _f$origin = Field(
    'origin',
    _$origin,
  );

  @override
  final MappableFields<LocalBackupTranslation> fields = const {
    #language: _f$language,
    #text: _f$text,
    #origin: _f$origin,
  };

  static LocalBackupTranslation _instantiate(DecodingData data) {
    return LocalBackupTranslation(
      language: data.dec(_f$language),
      text: data.dec(_f$text),
      origin: data.dec(_f$origin),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalBackupTranslation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalBackupTranslation>(map);
  }

  static LocalBackupTranslation fromJson(String json) {
    return ensureInitialized().decodeJson<LocalBackupTranslation>(json);
  }
}

mixin LocalBackupTranslationMappable {
  String toJson() {
    return LocalBackupTranslationMapper.ensureInitialized()
        .encodeJson<LocalBackupTranslation>(this as LocalBackupTranslation);
  }

  Map<String, dynamic> toMap() {
    return LocalBackupTranslationMapper.ensureInitialized()
        .encodeMap<LocalBackupTranslation>(this as LocalBackupTranslation);
  }

  LocalBackupTranslationCopyWith<
    LocalBackupTranslation,
    LocalBackupTranslation,
    LocalBackupTranslation
  >
  get copyWith =>
      _LocalBackupTranslationCopyWithImpl<
        LocalBackupTranslation,
        LocalBackupTranslation
      >(this as LocalBackupTranslation, $identity, $identity);
  @override
  String toString() {
    return LocalBackupTranslationMapper.ensureInitialized().stringifyValue(
      this as LocalBackupTranslation,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalBackupTranslationMapper.ensureInitialized().equalsValue(
      this as LocalBackupTranslation,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalBackupTranslationMapper.ensureInitialized().hashValue(
      this as LocalBackupTranslation,
    );
  }
}

extension LocalBackupTranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalBackupTranslation, $Out> {
  LocalBackupTranslationCopyWith<$R, LocalBackupTranslation, $Out>
  get $asLocalBackupTranslation => $base.as(
    (v, t, t2) => _LocalBackupTranslationCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalBackupTranslationCopyWith<
  $R,
  $In extends LocalBackupTranslation,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? language, String? text, String? origin});
  LocalBackupTranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalBackupTranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalBackupTranslation, $Out>
    implements
        LocalBackupTranslationCopyWith<$R, LocalBackupTranslation, $Out> {
  _LocalBackupTranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalBackupTranslation> $mapper =
      LocalBackupTranslationMapper.ensureInitialized();
  @override
  $R call({String? language, String? text, String? origin}) => $apply(
    FieldCopyWithData({
      if (language != null) #language: language,
      if (text != null) #text: text,
      if (origin != null) #origin: origin,
    }),
  );
  @override
  LocalBackupTranslation $make(CopyWithData data) => LocalBackupTranslation(
    language: data.get(#language, or: $value.language),
    text: data.get(#text, or: $value.text),
    origin: data.get(#origin, or: $value.origin),
  );

  @override
  LocalBackupTranslationCopyWith<$R2, LocalBackupTranslation, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalBackupTranslationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LocalBackupProgressMapper extends ClassMapperBase<LocalBackupProgress> {
  LocalBackupProgressMapper._();

  static LocalBackupProgressMapper? _instance;
  static LocalBackupProgressMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalBackupProgressMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalBackupProgress';

  static String _$language(LocalBackupProgress v) => v.language;
  static const Field<LocalBackupProgress, String> _f$language = Field(
    'language',
    _$language,
  );
  static String _$stage(LocalBackupProgress v) => v.stage;
  static const Field<LocalBackupProgress, String> _f$stage = Field(
    'stage',
    _$stage,
  );
  static double _$level(LocalBackupProgress v) => v.level;
  static const Field<LocalBackupProgress, double> _f$level = Field(
    'level',
    _$level,
  );
  static int _$intervalMinutes(LocalBackupProgress v) => v.intervalMinutes;
  static const Field<LocalBackupProgress, int> _f$intervalMinutes = Field(
    'intervalMinutes',
    _$intervalMinutes,
  );
  static double _$ease(LocalBackupProgress v) => v.ease;
  static const Field<LocalBackupProgress, double> _f$ease = Field(
    'ease',
    _$ease,
  );
  static DateTime _$nextReviewAt(LocalBackupProgress v) => v.nextReviewAt;
  static const Field<LocalBackupProgress, DateTime> _f$nextReviewAt = Field(
    'nextReviewAt',
    _$nextReviewAt,
  );
  static DateTime _$createdAt(LocalBackupProgress v) => v.createdAt;
  static const Field<LocalBackupProgress, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<LocalBackupProgress> fields = const {
    #language: _f$language,
    #stage: _f$stage,
    #level: _f$level,
    #intervalMinutes: _f$intervalMinutes,
    #ease: _f$ease,
    #nextReviewAt: _f$nextReviewAt,
    #createdAt: _f$createdAt,
  };

  static LocalBackupProgress _instantiate(DecodingData data) {
    return LocalBackupProgress(
      language: data.dec(_f$language),
      stage: data.dec(_f$stage),
      level: data.dec(_f$level),
      intervalMinutes: data.dec(_f$intervalMinutes),
      ease: data.dec(_f$ease),
      nextReviewAt: data.dec(_f$nextReviewAt),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalBackupProgress fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalBackupProgress>(map);
  }

  static LocalBackupProgress fromJson(String json) {
    return ensureInitialized().decodeJson<LocalBackupProgress>(json);
  }
}

mixin LocalBackupProgressMappable {
  String toJson() {
    return LocalBackupProgressMapper.ensureInitialized()
        .encodeJson<LocalBackupProgress>(this as LocalBackupProgress);
  }

  Map<String, dynamic> toMap() {
    return LocalBackupProgressMapper.ensureInitialized()
        .encodeMap<LocalBackupProgress>(this as LocalBackupProgress);
  }

  LocalBackupProgressCopyWith<
    LocalBackupProgress,
    LocalBackupProgress,
    LocalBackupProgress
  >
  get copyWith =>
      _LocalBackupProgressCopyWithImpl<
        LocalBackupProgress,
        LocalBackupProgress
      >(this as LocalBackupProgress, $identity, $identity);
  @override
  String toString() {
    return LocalBackupProgressMapper.ensureInitialized().stringifyValue(
      this as LocalBackupProgress,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalBackupProgressMapper.ensureInitialized().equalsValue(
      this as LocalBackupProgress,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalBackupProgressMapper.ensureInitialized().hashValue(
      this as LocalBackupProgress,
    );
  }
}

extension LocalBackupProgressValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalBackupProgress, $Out> {
  LocalBackupProgressCopyWith<$R, LocalBackupProgress, $Out>
  get $asLocalBackupProgress => $base.as(
    (v, t, t2) => _LocalBackupProgressCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalBackupProgressCopyWith<
  $R,
  $In extends LocalBackupProgress,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? language,
    String? stage,
    double? level,
    int? intervalMinutes,
    double? ease,
    DateTime? nextReviewAt,
    DateTime? createdAt,
  });
  LocalBackupProgressCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalBackupProgressCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalBackupProgress, $Out>
    implements LocalBackupProgressCopyWith<$R, LocalBackupProgress, $Out> {
  _LocalBackupProgressCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalBackupProgress> $mapper =
      LocalBackupProgressMapper.ensureInitialized();
  @override
  $R call({
    String? language,
    String? stage,
    double? level,
    int? intervalMinutes,
    double? ease,
    DateTime? nextReviewAt,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (language != null) #language: language,
      if (stage != null) #stage: stage,
      if (level != null) #level: level,
      if (intervalMinutes != null) #intervalMinutes: intervalMinutes,
      if (ease != null) #ease: ease,
      if (nextReviewAt != null) #nextReviewAt: nextReviewAt,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  LocalBackupProgress $make(CopyWithData data) => LocalBackupProgress(
    language: data.get(#language, or: $value.language),
    stage: data.get(#stage, or: $value.stage),
    level: data.get(#level, or: $value.level),
    intervalMinutes: data.get(#intervalMinutes, or: $value.intervalMinutes),
    ease: data.get(#ease, or: $value.ease),
    nextReviewAt: data.get(#nextReviewAt, or: $value.nextReviewAt),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  LocalBackupProgressCopyWith<$R2, LocalBackupProgress, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalBackupProgressCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LocalBackupImageMapper extends ClassMapperBase<LocalBackupImage> {
  LocalBackupImageMapper._();

  static LocalBackupImageMapper? _instance;
  static LocalBackupImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalBackupImageMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalBackupImage';

  static String _$kind(LocalBackupImage v) => v.kind;
  static const Field<LocalBackupImage, String> _f$kind = Field('kind', _$kind);
  static String? _$path(LocalBackupImage v) => v.path;
  static const Field<LocalBackupImage, String> _f$path = Field('path', _$path);
  static String? _$pexelsId(LocalBackupImage v) => v.pexelsId;
  static const Field<LocalBackupImage, String> _f$pexelsId = Field(
    'pexelsId',
    _$pexelsId,
  );
  static String? _$url(LocalBackupImage v) => v.url;
  static const Field<LocalBackupImage, String> _f$url = Field('url', _$url);
  static String? _$thumbUrl(LocalBackupImage v) => v.thumbUrl;
  static const Field<LocalBackupImage, String> _f$thumbUrl = Field(
    'thumbUrl',
    _$thumbUrl,
  );
  static String? _$photographer(LocalBackupImage v) => v.photographer;
  static const Field<LocalBackupImage, String> _f$photographer = Field(
    'photographer',
    _$photographer,
  );
  static String? _$photographerUrl(LocalBackupImage v) => v.photographerUrl;
  static const Field<LocalBackupImage, String> _f$photographerUrl = Field(
    'photographerUrl',
    _$photographerUrl,
  );

  @override
  final MappableFields<LocalBackupImage> fields = const {
    #kind: _f$kind,
    #path: _f$path,
    #pexelsId: _f$pexelsId,
    #url: _f$url,
    #thumbUrl: _f$thumbUrl,
    #photographer: _f$photographer,
    #photographerUrl: _f$photographerUrl,
  };

  static LocalBackupImage _instantiate(DecodingData data) {
    return LocalBackupImage(
      kind: data.dec(_f$kind),
      path: data.dec(_f$path),
      pexelsId: data.dec(_f$pexelsId),
      url: data.dec(_f$url),
      thumbUrl: data.dec(_f$thumbUrl),
      photographer: data.dec(_f$photographer),
      photographerUrl: data.dec(_f$photographerUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalBackupImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalBackupImage>(map);
  }

  static LocalBackupImage fromJson(String json) {
    return ensureInitialized().decodeJson<LocalBackupImage>(json);
  }
}

mixin LocalBackupImageMappable {
  String toJson() {
    return LocalBackupImageMapper.ensureInitialized()
        .encodeJson<LocalBackupImage>(this as LocalBackupImage);
  }

  Map<String, dynamic> toMap() {
    return LocalBackupImageMapper.ensureInitialized()
        .encodeMap<LocalBackupImage>(this as LocalBackupImage);
  }

  LocalBackupImageCopyWith<LocalBackupImage, LocalBackupImage, LocalBackupImage>
  get copyWith =>
      _LocalBackupImageCopyWithImpl<LocalBackupImage, LocalBackupImage>(
        this as LocalBackupImage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LocalBackupImageMapper.ensureInitialized().stringifyValue(
      this as LocalBackupImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalBackupImageMapper.ensureInitialized().equalsValue(
      this as LocalBackupImage,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalBackupImageMapper.ensureInitialized().hashValue(
      this as LocalBackupImage,
    );
  }
}

extension LocalBackupImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalBackupImage, $Out> {
  LocalBackupImageCopyWith<$R, LocalBackupImage, $Out>
  get $asLocalBackupImage =>
      $base.as((v, t, t2) => _LocalBackupImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocalBackupImageCopyWith<$R, $In extends LocalBackupImage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? kind,
    String? path,
    String? pexelsId,
    String? url,
    String? thumbUrl,
    String? photographer,
    String? photographerUrl,
  });
  LocalBackupImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalBackupImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalBackupImage, $Out>
    implements LocalBackupImageCopyWith<$R, LocalBackupImage, $Out> {
  _LocalBackupImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalBackupImage> $mapper =
      LocalBackupImageMapper.ensureInitialized();
  @override
  $R call({
    String? kind,
    Object? path = $none,
    Object? pexelsId = $none,
    Object? url = $none,
    Object? thumbUrl = $none,
    Object? photographer = $none,
    Object? photographerUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (kind != null) #kind: kind,
      if (path != $none) #path: path,
      if (pexelsId != $none) #pexelsId: pexelsId,
      if (url != $none) #url: url,
      if (thumbUrl != $none) #thumbUrl: thumbUrl,
      if (photographer != $none) #photographer: photographer,
      if (photographerUrl != $none) #photographerUrl: photographerUrl,
    }),
  );
  @override
  LocalBackupImage $make(CopyWithData data) => LocalBackupImage(
    kind: data.get(#kind, or: $value.kind),
    path: data.get(#path, or: $value.path),
    pexelsId: data.get(#pexelsId, or: $value.pexelsId),
    url: data.get(#url, or: $value.url),
    thumbUrl: data.get(#thumbUrl, or: $value.thumbUrl),
    photographer: data.get(#photographer, or: $value.photographer),
    photographerUrl: data.get(#photographerUrl, or: $value.photographerUrl),
  );

  @override
  LocalBackupImageCopyWith<$R2, LocalBackupImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocalBackupImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LocalBackupTagMapper extends ClassMapperBase<LocalBackupTag> {
  LocalBackupTagMapper._();

  static LocalBackupTagMapper? _instance;
  static LocalBackupTagMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalBackupTagMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalBackupTag';

  static String _$id(LocalBackupTag v) => v.id;
  static const Field<LocalBackupTag, String> _f$id = Field('id', _$id);
  static String _$name(LocalBackupTag v) => v.name;
  static const Field<LocalBackupTag, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<LocalBackupTag> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static LocalBackupTag _instantiate(DecodingData data) {
    return LocalBackupTag(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static LocalBackupTag fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalBackupTag>(map);
  }

  static LocalBackupTag fromJson(String json) {
    return ensureInitialized().decodeJson<LocalBackupTag>(json);
  }
}

mixin LocalBackupTagMappable {
  String toJson() {
    return LocalBackupTagMapper.ensureInitialized().encodeJson<LocalBackupTag>(
      this as LocalBackupTag,
    );
  }

  Map<String, dynamic> toMap() {
    return LocalBackupTagMapper.ensureInitialized().encodeMap<LocalBackupTag>(
      this as LocalBackupTag,
    );
  }

  LocalBackupTagCopyWith<LocalBackupTag, LocalBackupTag, LocalBackupTag>
  get copyWith => _LocalBackupTagCopyWithImpl<LocalBackupTag, LocalBackupTag>(
    this as LocalBackupTag,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return LocalBackupTagMapper.ensureInitialized().stringifyValue(
      this as LocalBackupTag,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalBackupTagMapper.ensureInitialized().equalsValue(
      this as LocalBackupTag,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalBackupTagMapper.ensureInitialized().hashValue(
      this as LocalBackupTag,
    );
  }
}

extension LocalBackupTagValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalBackupTag, $Out> {
  LocalBackupTagCopyWith<$R, LocalBackupTag, $Out> get $asLocalBackupTag =>
      $base.as((v, t, t2) => _LocalBackupTagCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocalBackupTagCopyWith<$R, $In extends LocalBackupTag, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  LocalBackupTagCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalBackupTagCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalBackupTag, $Out>
    implements LocalBackupTagCopyWith<$R, LocalBackupTag, $Out> {
  _LocalBackupTagCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalBackupTag> $mapper =
      LocalBackupTagMapper.ensureInitialized();
  @override
  $R call({String? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  LocalBackupTag $make(CopyWithData data) => LocalBackupTag(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  LocalBackupTagCopyWith<$R2, LocalBackupTag, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocalBackupTagCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LocalBackupActivityMapper extends ClassMapperBase<LocalBackupActivity> {
  LocalBackupActivityMapper._();

  static LocalBackupActivityMapper? _instance;
  static LocalBackupActivityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalBackupActivityMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalBackupActivity';

  static String _$localDate(LocalBackupActivity v) => v.localDate;
  static const Field<LocalBackupActivity, String> _f$localDate = Field(
    'localDate',
    _$localDate,
  );
  static int? _$practicedCount(LocalBackupActivity v) => v.practicedCount;
  static const Field<LocalBackupActivity, int> _f$practicedCount = Field(
    'practicedCount',
    _$practicedCount,
  );

  @override
  final MappableFields<LocalBackupActivity> fields = const {
    #localDate: _f$localDate,
    #practicedCount: _f$practicedCount,
  };

  static LocalBackupActivity _instantiate(DecodingData data) {
    return LocalBackupActivity(
      localDate: data.dec(_f$localDate),
      practicedCount: data.dec(_f$practicedCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalBackupActivity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalBackupActivity>(map);
  }

  static LocalBackupActivity fromJson(String json) {
    return ensureInitialized().decodeJson<LocalBackupActivity>(json);
  }
}

mixin LocalBackupActivityMappable {
  String toJson() {
    return LocalBackupActivityMapper.ensureInitialized()
        .encodeJson<LocalBackupActivity>(this as LocalBackupActivity);
  }

  Map<String, dynamic> toMap() {
    return LocalBackupActivityMapper.ensureInitialized()
        .encodeMap<LocalBackupActivity>(this as LocalBackupActivity);
  }

  LocalBackupActivityCopyWith<
    LocalBackupActivity,
    LocalBackupActivity,
    LocalBackupActivity
  >
  get copyWith =>
      _LocalBackupActivityCopyWithImpl<
        LocalBackupActivity,
        LocalBackupActivity
      >(this as LocalBackupActivity, $identity, $identity);
  @override
  String toString() {
    return LocalBackupActivityMapper.ensureInitialized().stringifyValue(
      this as LocalBackupActivity,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalBackupActivityMapper.ensureInitialized().equalsValue(
      this as LocalBackupActivity,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalBackupActivityMapper.ensureInitialized().hashValue(
      this as LocalBackupActivity,
    );
  }
}

extension LocalBackupActivityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalBackupActivity, $Out> {
  LocalBackupActivityCopyWith<$R, LocalBackupActivity, $Out>
  get $asLocalBackupActivity => $base.as(
    (v, t, t2) => _LocalBackupActivityCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalBackupActivityCopyWith<
  $R,
  $In extends LocalBackupActivity,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? localDate, int? practicedCount});
  LocalBackupActivityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalBackupActivityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalBackupActivity, $Out>
    implements LocalBackupActivityCopyWith<$R, LocalBackupActivity, $Out> {
  _LocalBackupActivityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalBackupActivity> $mapper =
      LocalBackupActivityMapper.ensureInitialized();
  @override
  $R call({String? localDate, Object? practicedCount = $none}) => $apply(
    FieldCopyWithData({
      if (localDate != null) #localDate: localDate,
      if (practicedCount != $none) #practicedCount: practicedCount,
    }),
  );
  @override
  LocalBackupActivity $make(CopyWithData data) => LocalBackupActivity(
    localDate: data.get(#localDate, or: $value.localDate),
    practicedCount: data.get(#practicedCount, or: $value.practicedCount),
  );

  @override
  LocalBackupActivityCopyWith<$R2, LocalBackupActivity, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalBackupActivityCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

