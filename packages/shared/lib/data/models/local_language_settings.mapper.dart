// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_language_settings.dart';

class LocalLanguageSettingsMapper
    extends ClassMapperBase<LocalLanguageSettings> {
  LocalLanguageSettingsMapper._();

  static LocalLanguageSettingsMapper? _instance;
  static LocalLanguageSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalLanguageSettingsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalLanguageSettings';

  static String? _$mainLanguage(LocalLanguageSettings v) => v.mainLanguage;
  static const Field<LocalLanguageSettings, String> _f$mainLanguage = Field(
    'mainLanguage',
    _$mainLanguage,
  );
  static String? _$selectedLanguage(LocalLanguageSettings v) =>
      v.selectedLanguage;
  static const Field<LocalLanguageSettings, String> _f$selectedLanguage = Field(
    'selectedLanguage',
    _$selectedLanguage,
  );
  static List<String> _$learnedLanguages(LocalLanguageSettings v) =>
      v.learnedLanguages;
  static const Field<LocalLanguageSettings, List<String>> _f$learnedLanguages =
      Field('learnedLanguages', _$learnedLanguages);

  @override
  final MappableFields<LocalLanguageSettings> fields = const {
    #mainLanguage: _f$mainLanguage,
    #selectedLanguage: _f$selectedLanguage,
    #learnedLanguages: _f$learnedLanguages,
  };

  static LocalLanguageSettings _instantiate(DecodingData data) {
    return LocalLanguageSettings(
      mainLanguage: data.dec(_f$mainLanguage),
      selectedLanguage: data.dec(_f$selectedLanguage),
      learnedLanguages: data.dec(_f$learnedLanguages),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalLanguageSettings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalLanguageSettings>(map);
  }

  static LocalLanguageSettings fromJson(String json) {
    return ensureInitialized().decodeJson<LocalLanguageSettings>(json);
  }
}

mixin LocalLanguageSettingsMappable {
  String toJson() {
    return LocalLanguageSettingsMapper.ensureInitialized()
        .encodeJson<LocalLanguageSettings>(this as LocalLanguageSettings);
  }

  Map<String, dynamic> toMap() {
    return LocalLanguageSettingsMapper.ensureInitialized()
        .encodeMap<LocalLanguageSettings>(this as LocalLanguageSettings);
  }

  LocalLanguageSettingsCopyWith<
    LocalLanguageSettings,
    LocalLanguageSettings,
    LocalLanguageSettings
  >
  get copyWith =>
      _LocalLanguageSettingsCopyWithImpl<
        LocalLanguageSettings,
        LocalLanguageSettings
      >(this as LocalLanguageSettings, $identity, $identity);
  @override
  String toString() {
    return LocalLanguageSettingsMapper.ensureInitialized().stringifyValue(
      this as LocalLanguageSettings,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalLanguageSettingsMapper.ensureInitialized().equalsValue(
      this as LocalLanguageSettings,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalLanguageSettingsMapper.ensureInitialized().hashValue(
      this as LocalLanguageSettings,
    );
  }
}

extension LocalLanguageSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalLanguageSettings, $Out> {
  LocalLanguageSettingsCopyWith<$R, LocalLanguageSettings, $Out>
  get $asLocalLanguageSettings => $base.as(
    (v, t, t2) => _LocalLanguageSettingsCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalLanguageSettingsCopyWith<
  $R,
  $In extends LocalLanguageSettings,
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
  LocalLanguageSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalLanguageSettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalLanguageSettings, $Out>
    implements LocalLanguageSettingsCopyWith<$R, LocalLanguageSettings, $Out> {
  _LocalLanguageSettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalLanguageSettings> $mapper =
      LocalLanguageSettingsMapper.ensureInitialized();
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
  LocalLanguageSettings $make(CopyWithData data) => LocalLanguageSettings(
    mainLanguage: data.get(#mainLanguage, or: $value.mainLanguage),
    selectedLanguage: data.get(#selectedLanguage, or: $value.selectedLanguage),
    learnedLanguages: data.get(#learnedLanguages, or: $value.learnedLanguages),
  );

  @override
  LocalLanguageSettingsCopyWith<$R2, LocalLanguageSettings, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalLanguageSettingsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

