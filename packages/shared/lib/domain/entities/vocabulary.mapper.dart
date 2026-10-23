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
      VocabularyImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Vocabulary';

  static String _$id(Vocabulary v) => v.id;
  static const Field<Vocabulary, String> _f$id = Field('id', _$id);
  static String _$source(Vocabulary v) => v.source;
  static const Field<Vocabulary, String> _f$source = Field('source', _$source);
  static String _$target(Vocabulary v) => v.target;
  static const Field<Vocabulary, String> _f$target = Field('target', _$target);
  static String _$sourceLanguageCode(Vocabulary v) => v.sourceLanguageCode;
  static const Field<Vocabulary, String> _f$sourceLanguageCode = Field(
    'sourceLanguageCode',
    _$sourceLanguageCode,
  );
  static String _$targetLanguageCode(Vocabulary v) => v.targetLanguageCode;
  static const Field<Vocabulary, String> _f$targetLanguageCode = Field(
    'targetLanguageCode',
    _$targetLanguageCode,
  );
  static double _$level(Vocabulary v) => v.level;
  static const Field<Vocabulary, double> _f$level = Field('level', _$level);
  static bool _$isNovice(Vocabulary v) => v.isNovice;
  static const Field<Vocabulary, bool> _f$isNovice = Field(
    'isNovice',
    _$isNovice,
  );
  static int _$intervalMinutes(Vocabulary v) => v.intervalMinutes;
  static const Field<Vocabulary, int> _f$intervalMinutes = Field(
    'intervalMinutes',
    _$intervalMinutes,
  );
  static double _$ease(Vocabulary v) => v.ease;
  static const Field<Vocabulary, double> _f$ease = Field('ease', _$ease);
  static DateTime _$nextReviewAt(Vocabulary v) => v.nextReviewAt;
  static const Field<Vocabulary, DateTime> _f$nextReviewAt = Field(
    'nextReviewAt',
    _$nextReviewAt,
  );
  static VocabularyImage _$image(Vocabulary v) => v.image;
  static const Field<Vocabulary, VocabularyImage> _f$image = Field(
    'image',
    _$image,
  );
  static DateTime _$createdAt(Vocabulary v) => v.createdAt;
  static const Field<Vocabulary, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<Vocabulary> fields = const {
    #id: _f$id,
    #source: _f$source,
    #target: _f$target,
    #sourceLanguageCode: _f$sourceLanguageCode,
    #targetLanguageCode: _f$targetLanguageCode,
    #level: _f$level,
    #isNovice: _f$isNovice,
    #intervalMinutes: _f$intervalMinutes,
    #ease: _f$ease,
    #nextReviewAt: _f$nextReviewAt,
    #image: _f$image,
    #createdAt: _f$createdAt,
  };

  static Vocabulary _instantiate(DecodingData data) {
    return Vocabulary(
      id: data.dec(_f$id),
      source: data.dec(_f$source),
      target: data.dec(_f$target),
      sourceLanguageCode: data.dec(_f$sourceLanguageCode),
      targetLanguageCode: data.dec(_f$targetLanguageCode),
      level: data.dec(_f$level),
      isNovice: data.dec(_f$isNovice),
      intervalMinutes: data.dec(_f$intervalMinutes),
      ease: data.dec(_f$ease),
      nextReviewAt: data.dec(_f$nextReviewAt),
      image: data.dec(_f$image),
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
  VocabularyImageCopyWith<$R, VocabularyImage, VocabularyImage> get image;
  $R call({
    String? id,
    String? source,
    String? target,
    String? sourceLanguageCode,
    String? targetLanguageCode,
    double? level,
    bool? isNovice,
    int? intervalMinutes,
    double? ease,
    DateTime? nextReviewAt,
    VocabularyImage? image,
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
  VocabularyImageCopyWith<$R, VocabularyImage, VocabularyImage> get image =>
      $value.image.copyWith.$chain((v) => call(image: v));
  @override
  $R call({
    String? id,
    String? source,
    String? target,
    String? sourceLanguageCode,
    String? targetLanguageCode,
    double? level,
    bool? isNovice,
    int? intervalMinutes,
    double? ease,
    DateTime? nextReviewAt,
    VocabularyImage? image,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (source != null) #source: source,
      if (target != null) #target: target,
      if (sourceLanguageCode != null) #sourceLanguageCode: sourceLanguageCode,
      if (targetLanguageCode != null) #targetLanguageCode: targetLanguageCode,
      if (level != null) #level: level,
      if (isNovice != null) #isNovice: isNovice,
      if (intervalMinutes != null) #intervalMinutes: intervalMinutes,
      if (ease != null) #ease: ease,
      if (nextReviewAt != null) #nextReviewAt: nextReviewAt,
      if (image != null) #image: image,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  Vocabulary $make(CopyWithData data) => Vocabulary(
    id: data.get(#id, or: $value.id),
    source: data.get(#source, or: $value.source),
    target: data.get(#target, or: $value.target),
    sourceLanguageCode: data.get(
      #sourceLanguageCode,
      or: $value.sourceLanguageCode,
    ),
    targetLanguageCode: data.get(
      #targetLanguageCode,
      or: $value.targetLanguageCode,
    ),
    level: data.get(#level, or: $value.level),
    isNovice: data.get(#isNovice, or: $value.isNovice),
    intervalMinutes: data.get(#intervalMinutes, or: $value.intervalMinutes),
    ease: data.get(#ease, or: $value.ease),
    nextReviewAt: data.get(#nextReviewAt, or: $value.nextReviewAt),
    image: data.get(#image, or: $value.image),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  VocabularyCopyWith<$R2, Vocabulary, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VocabularyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

