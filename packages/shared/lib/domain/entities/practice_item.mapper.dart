// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'practice_item.dart';

class PracticeItemMapper extends ClassMapperBase<PracticeItem> {
  PracticeItemMapper._();

  static PracticeItemMapper? _instance;
  static PracticeItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PracticeItemMapper._());
      VocabularyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PracticeItem';

  static Vocabulary _$vocabulary(PracticeItem v) => v.vocabulary;
  static const Field<PracticeItem, Vocabulary> _f$vocabulary = Field(
    'vocabulary',
    _$vocabulary,
  );
  static Language _$language(PracticeItem v) => v.language;
  static const Field<PracticeItem, Language> _f$language = Field(
    'language',
    _$language,
  );

  @override
  final MappableFields<PracticeItem> fields = const {
    #vocabulary: _f$vocabulary,
    #language: _f$language,
  };

  static PracticeItem _instantiate(DecodingData data) {
    return PracticeItem(
      vocabulary: data.dec(_f$vocabulary),
      language: data.dec(_f$language),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PracticeItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PracticeItem>(map);
  }

  static PracticeItem fromJson(String json) {
    return ensureInitialized().decodeJson<PracticeItem>(json);
  }
}

mixin PracticeItemMappable {
  String toJson() {
    return PracticeItemMapper.ensureInitialized().encodeJson<PracticeItem>(
      this as PracticeItem,
    );
  }

  Map<String, dynamic> toMap() {
    return PracticeItemMapper.ensureInitialized().encodeMap<PracticeItem>(
      this as PracticeItem,
    );
  }

  PracticeItemCopyWith<PracticeItem, PracticeItem, PracticeItem> get copyWith =>
      _PracticeItemCopyWithImpl<PracticeItem, PracticeItem>(
        this as PracticeItem,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PracticeItemMapper.ensureInitialized().stringifyValue(
      this as PracticeItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return PracticeItemMapper.ensureInitialized().equalsValue(
      this as PracticeItem,
      other,
    );
  }

  @override
  int get hashCode {
    return PracticeItemMapper.ensureInitialized().hashValue(
      this as PracticeItem,
    );
  }
}

extension PracticeItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PracticeItem, $Out> {
  PracticeItemCopyWith<$R, PracticeItem, $Out> get $asPracticeItem =>
      $base.as((v, t, t2) => _PracticeItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PracticeItemCopyWith<$R, $In extends PracticeItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  VocabularyCopyWith<$R, Vocabulary, Vocabulary> get vocabulary;
  $R call({Vocabulary? vocabulary, Language? language});
  PracticeItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PracticeItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PracticeItem, $Out>
    implements PracticeItemCopyWith<$R, PracticeItem, $Out> {
  _PracticeItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PracticeItem> $mapper =
      PracticeItemMapper.ensureInitialized();
  @override
  VocabularyCopyWith<$R, Vocabulary, Vocabulary> get vocabulary =>
      $value.vocabulary.copyWith.$chain((v) => call(vocabulary: v));
  @override
  $R call({Vocabulary? vocabulary, Language? language}) => $apply(
    FieldCopyWithData({
      if (vocabulary != null) #vocabulary: vocabulary,
      if (language != null) #language: language,
    }),
  );
  @override
  PracticeItem $make(CopyWithData data) => PracticeItem(
    vocabulary: data.get(#vocabulary, or: $value.vocabulary),
    language: data.get(#language, or: $value.language),
  );

  @override
  PracticeItemCopyWith<$R2, PracticeItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PracticeItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

