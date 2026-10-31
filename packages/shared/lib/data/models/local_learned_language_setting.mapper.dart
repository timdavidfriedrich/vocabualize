// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_learned_language_setting.dart';

class LocalLearnedLanguageSettingMapper
    extends ClassMapperBase<LocalLearnedLanguageSetting> {
  LocalLearnedLanguageSettingMapper._();

  static LocalLearnedLanguageSettingMapper? _instance;
  static LocalLearnedLanguageSettingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LocalLearnedLanguageSettingMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'LocalLearnedLanguageSetting';

  static String _$language(LocalLearnedLanguageSetting v) => v.language;
  static const Field<LocalLearnedLanguageSetting, String> _f$language = Field(
    'language',
    _$language,
  );
  static String? _$askMeIn(LocalLearnedLanguageSetting v) => v.askMeIn;
  static const Field<LocalLearnedLanguageSetting, String> _f$askMeIn = Field(
    'askMeIn',
    _$askMeIn,
  );
  static String _$askMeInFromLevel(LocalLearnedLanguageSetting v) =>
      v.askMeInFromLevel;
  static const Field<LocalLearnedLanguageSetting, String> _f$askMeInFromLevel =
      Field('askMeInFromLevel', _$askMeInFromLevel);
  static String _$newWords(LocalLearnedLanguageSetting v) => v.newWords;
  static const Field<LocalLearnedLanguageSetting, String> _f$newWords = Field(
    'newWords',
    _$newWords,
  );
  static bool _$isPaused(LocalLearnedLanguageSetting v) => v.isPaused;
  static const Field<LocalLearnedLanguageSetting, bool> _f$isPaused = Field(
    'isPaused',
    _$isPaused,
  );
  static DateTime _$addedAt(LocalLearnedLanguageSetting v) => v.addedAt;
  static const Field<LocalLearnedLanguageSetting, DateTime> _f$addedAt = Field(
    'addedAt',
    _$addedAt,
  );

  @override
  final MappableFields<LocalLearnedLanguageSetting> fields = const {
    #language: _f$language,
    #askMeIn: _f$askMeIn,
    #askMeInFromLevel: _f$askMeInFromLevel,
    #newWords: _f$newWords,
    #isPaused: _f$isPaused,
    #addedAt: _f$addedAt,
  };

  static LocalLearnedLanguageSetting _instantiate(DecodingData data) {
    return LocalLearnedLanguageSetting(
      language: data.dec(_f$language),
      askMeIn: data.dec(_f$askMeIn),
      askMeInFromLevel: data.dec(_f$askMeInFromLevel),
      newWords: data.dec(_f$newWords),
      isPaused: data.dec(_f$isPaused),
      addedAt: data.dec(_f$addedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalLearnedLanguageSetting fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalLearnedLanguageSetting>(map);
  }

  static LocalLearnedLanguageSetting fromJson(String json) {
    return ensureInitialized().decodeJson<LocalLearnedLanguageSetting>(json);
  }
}

mixin LocalLearnedLanguageSettingMappable {
  String toJson() {
    return LocalLearnedLanguageSettingMapper.ensureInitialized()
        .encodeJson<LocalLearnedLanguageSetting>(
          this as LocalLearnedLanguageSetting,
        );
  }

  Map<String, dynamic> toMap() {
    return LocalLearnedLanguageSettingMapper.ensureInitialized()
        .encodeMap<LocalLearnedLanguageSetting>(
          this as LocalLearnedLanguageSetting,
        );
  }

  LocalLearnedLanguageSettingCopyWith<
    LocalLearnedLanguageSetting,
    LocalLearnedLanguageSetting,
    LocalLearnedLanguageSetting
  >
  get copyWith =>
      _LocalLearnedLanguageSettingCopyWithImpl<
        LocalLearnedLanguageSetting,
        LocalLearnedLanguageSetting
      >(this as LocalLearnedLanguageSetting, $identity, $identity);
  @override
  String toString() {
    return LocalLearnedLanguageSettingMapper.ensureInitialized().stringifyValue(
      this as LocalLearnedLanguageSetting,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalLearnedLanguageSettingMapper.ensureInitialized().equalsValue(
      this as LocalLearnedLanguageSetting,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalLearnedLanguageSettingMapper.ensureInitialized().hashValue(
      this as LocalLearnedLanguageSetting,
    );
  }
}

extension LocalLearnedLanguageSettingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalLearnedLanguageSetting, $Out> {
  LocalLearnedLanguageSettingCopyWith<$R, LocalLearnedLanguageSetting, $Out>
  get $asLocalLearnedLanguageSetting => $base.as(
    (v, t, t2) => _LocalLearnedLanguageSettingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalLearnedLanguageSettingCopyWith<
  $R,
  $In extends LocalLearnedLanguageSetting,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? language,
    String? askMeIn,
    String? askMeInFromLevel,
    String? newWords,
    bool? isPaused,
    DateTime? addedAt,
  });
  LocalLearnedLanguageSettingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalLearnedLanguageSettingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalLearnedLanguageSetting, $Out>
    implements
        LocalLearnedLanguageSettingCopyWith<
          $R,
          LocalLearnedLanguageSetting,
          $Out
        > {
  _LocalLearnedLanguageSettingCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<LocalLearnedLanguageSetting> $mapper =
      LocalLearnedLanguageSettingMapper.ensureInitialized();
  @override
  $R call({
    String? language,
    Object? askMeIn = $none,
    String? askMeInFromLevel,
    String? newWords,
    bool? isPaused,
    DateTime? addedAt,
  }) => $apply(
    FieldCopyWithData({
      if (language != null) #language: language,
      if (askMeIn != $none) #askMeIn: askMeIn,
      if (askMeInFromLevel != null) #askMeInFromLevel: askMeInFromLevel,
      if (newWords != null) #newWords: newWords,
      if (isPaused != null) #isPaused: isPaused,
      if (addedAt != null) #addedAt: addedAt,
    }),
  );
  @override
  LocalLearnedLanguageSetting $make(CopyWithData data) =>
      LocalLearnedLanguageSetting(
        language: data.get(#language, or: $value.language),
        askMeIn: data.get(#askMeIn, or: $value.askMeIn),
        askMeInFromLevel: data.get(
          #askMeInFromLevel,
          or: $value.askMeInFromLevel,
        ),
        newWords: data.get(#newWords, or: $value.newWords),
        isPaused: data.get(#isPaused, or: $value.isPaused),
        addedAt: data.get(#addedAt, or: $value.addedAt),
      );

  @override
  LocalLearnedLanguageSettingCopyWith<$R2, LocalLearnedLanguageSetting, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalLearnedLanguageSettingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

