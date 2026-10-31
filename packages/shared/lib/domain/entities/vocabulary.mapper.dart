// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vocabulary.dart';

class VocabularyMapper extends ClassMapperBase<Vocabulary> {
  VocabularyMapper._();

  static VocabularyMapper? _instance;
  static VocabularyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VocabularyMapper._());
      TranslationMapper.ensureInitialized();
      ProgressMapper.ensureInitialized();
      VocabularyImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Vocabulary';

  static String _$id(Vocabulary v) => v.id;
  static const Field<Vocabulary, String> _f$id = Field('id', _$id);
  static Map<Language, Translation> _$translations(Vocabulary v) =>
      v.translations;
  static const Field<Vocabulary, Map<Language, Translation>> _f$translations =
      Field('translations', _$translations);
  static Map<Language, Progress> _$progress(Vocabulary v) => v.progress;
  static const Field<Vocabulary, Map<Language, Progress>> _f$progress = Field(
    'progress',
    _$progress,
  );
  static VocabularyImage _$image(Vocabulary v) => v.image;
  static const Field<Vocabulary, VocabularyImage> _f$image = Field(
    'image',
    _$image,
  );
  static Set<String> _$tagIds(Vocabulary v) => v.tagIds;
  static const Field<Vocabulary, Set<String>> _f$tagIds = Field(
    'tagIds',
    _$tagIds,
  );
  static DateTime _$createdAt(Vocabulary v) => v.createdAt;
  static const Field<Vocabulary, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<Vocabulary> fields = const {
    #id: _f$id,
    #translations: _f$translations,
    #progress: _f$progress,
    #image: _f$image,
    #tagIds: _f$tagIds,
    #createdAt: _f$createdAt,
  };

  static Vocabulary _instantiate(DecodingData data) {
    return Vocabulary(
      id: data.dec(_f$id),
      translations: data.dec(_f$translations),
      progress: data.dec(_f$progress),
      image: data.dec(_f$image),
      tagIds: data.dec(_f$tagIds),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Vocabulary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Vocabulary>(map);
  }

  static Vocabulary fromJson(String json) {
    return ensureInitialized().decodeJson<Vocabulary>(json);
  }
}

mixin VocabularyMappable {
  String toJson() {
    return VocabularyMapper.ensureInitialized().encodeJson<Vocabulary>(
      this as Vocabulary,
    );
  }

  Map<String, dynamic> toMap() {
    return VocabularyMapper.ensureInitialized().encodeMap<Vocabulary>(
      this as Vocabulary,
    );
  }

  VocabularyCopyWith<Vocabulary, Vocabulary, Vocabulary> get copyWith =>
      _VocabularyCopyWithImpl<Vocabulary, Vocabulary>(
        this as Vocabulary,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return VocabularyMapper.ensureInitialized().stringifyValue(
      this as Vocabulary,
    );
  }

  @override
  bool operator ==(Object other) {
    return VocabularyMapper.ensureInitialized().equalsValue(
      this as Vocabulary,
      other,
    );
  }

  @override
  int get hashCode {
    return VocabularyMapper.ensureInitialized().hashValue(this as Vocabulary);
  }
}

extension VocabularyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Vocabulary, $Out> {
  VocabularyCopyWith<$R, Vocabulary, $Out> get $asVocabulary =>
      $base.as((v, t, t2) => _VocabularyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VocabularyCopyWith<$R, $In extends Vocabulary, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<
    $R,
    Language,
    Translation,
    TranslationCopyWith<$R, Translation, Translation>
  >
  get translations;
  MapCopyWith<$R, Language, Progress, ProgressCopyWith<$R, Progress, Progress>>
  get progress;
  VocabularyImageCopyWith<$R, VocabularyImage, VocabularyImage> get image;
  $R call({
    String? id,
    Map<Language, Translation>? translations,
    Map<Language, Progress>? progress,
    VocabularyImage? image,
    Set<String>? tagIds,
    DateTime? createdAt,
  });
  VocabularyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VocabularyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Vocabulary, $Out>
    implements VocabularyCopyWith<$R, Vocabulary, $Out> {
  _VocabularyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Vocabulary> $mapper =
      VocabularyMapper.ensureInitialized();
  @override
  MapCopyWith<
    $R,
    Language,
    Translation,
    TranslationCopyWith<$R, Translation, Translation>
  >
  get translations => MapCopyWith(
    $value.translations,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(translations: v),
  );
  @override
  MapCopyWith<$R, Language, Progress, ProgressCopyWith<$R, Progress, Progress>>
  get progress => MapCopyWith(
    $value.progress,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(progress: v),
  );
  @override
  VocabularyImageCopyWith<$R, VocabularyImage, VocabularyImage> get image =>
      $value.image.copyWith.$chain((v) => call(image: v));
  @override
  $R call({
    String? id,
    Map<Language, Translation>? translations,
    Map<Language, Progress>? progress,
    VocabularyImage? image,
    Set<String>? tagIds,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (translations != null) #translations: translations,
      if (progress != null) #progress: progress,
      if (image != null) #image: image,
      if (tagIds != null) #tagIds: tagIds,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  Vocabulary $make(CopyWithData data) => Vocabulary(
    id: data.get(#id, or: $value.id),
    translations: data.get(#translations, or: $value.translations),
    progress: data.get(#progress, or: $value.progress),
    image: data.get(#image, or: $value.image),
    tagIds: data.get(#tagIds, or: $value.tagIds),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  VocabularyCopyWith<$R2, Vocabulary, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VocabularyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

