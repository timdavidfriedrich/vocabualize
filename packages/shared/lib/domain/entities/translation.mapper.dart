// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'translation.dart';

class TranslationMapper extends ClassMapperBase<Translation> {
  TranslationMapper._();

  static TranslationMapper? _instance;
  static TranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TranslationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Translation';

  static Language _$language(Translation v) => v.language;
  static const Field<Translation, Language> _f$language = Field(
    'language',
    _$language,
  );
  static String _$text(Translation v) => v.text;
  static const Field<Translation, String> _f$text = Field('text', _$text);
  static TranslationOrigin _$origin(Translation v) => v.origin;
  static const Field<Translation, TranslationOrigin> _f$origin = Field(
    'origin',
    _$origin,
  );

  @override
  final MappableFields<Translation> fields = const {
    #language: _f$language,
    #text: _f$text,
    #origin: _f$origin,
  };

  static Translation _instantiate(DecodingData data) {
    return Translation(
      language: data.dec(_f$language),
      text: data.dec(_f$text),
      origin: data.dec(_f$origin),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Translation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Translation>(map);
  }

  static Translation fromJson(String json) {
    return ensureInitialized().decodeJson<Translation>(json);
  }
}

mixin TranslationMappable {
  String toJson() {
    return TranslationMapper.ensureInitialized().encodeJson<Translation>(
      this as Translation,
    );
  }

  Map<String, dynamic> toMap() {
    return TranslationMapper.ensureInitialized().encodeMap<Translation>(
      this as Translation,
    );
  }

  TranslationCopyWith<Translation, Translation, Translation> get copyWith =>
      _TranslationCopyWithImpl<Translation, Translation>(
        this as Translation,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TranslationMapper.ensureInitialized().stringifyValue(
      this as Translation,
    );
  }

  @override
  bool operator ==(Object other) {
    return TranslationMapper.ensureInitialized().equalsValue(
      this as Translation,
      other,
    );
  }

  @override
  int get hashCode {
    return TranslationMapper.ensureInitialized().hashValue(this as Translation);
  }
}

extension TranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Translation, $Out> {
  TranslationCopyWith<$R, Translation, $Out> get $asTranslation =>
      $base.as((v, t, t2) => _TranslationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TranslationCopyWith<$R, $In extends Translation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Language? language, String? text, TranslationOrigin? origin});
  TranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Translation, $Out>
    implements TranslationCopyWith<$R, Translation, $Out> {
  _TranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Translation> $mapper =
      TranslationMapper.ensureInitialized();
  @override
  $R call({Language? language, String? text, TranslationOrigin? origin}) =>
      $apply(
        FieldCopyWithData({
          if (language != null) #language: language,
          if (text != null) #text: text,
          if (origin != null) #origin: origin,
        }),
      );
  @override
  Translation $make(CopyWithData data) => Translation(
    language: data.get(#language, or: $value.language),
    text: data.get(#text, or: $value.text),
    origin: data.get(#origin, or: $value.origin),
  );

  @override
  TranslationCopyWith<$R2, Translation, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TranslationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

