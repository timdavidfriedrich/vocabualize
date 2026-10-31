// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'language_setup.dart';

class LanguageSetupMapper extends ClassMapperBase<LanguageSetup> {
  LanguageSetupMapper._();

  static LanguageSetupMapper? _instance;
  static LanguageSetupMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageSetupMapper._());
      LearnedLanguageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageSetup';

  static Language _$main(LanguageSetup v) => v.main;
  static const Field<LanguageSetup, Language> _f$main = Field('main', _$main);
  static List<LearnedLanguage> _$learned(LanguageSetup v) => v.learned;
  static const Field<LanguageSetup, List<LearnedLanguage>> _f$learned = Field(
    'learned',
    _$learned,
  );
  static Language _$selected(LanguageSetup v) => v.selected;
  static const Field<LanguageSetup, Language> _f$selected = Field(
    'selected',
    _$selected,
  );

  @override
  final MappableFields<LanguageSetup> fields = const {
    #main: _f$main,
    #learned: _f$learned,
    #selected: _f$selected,
  };

  static LanguageSetup _instantiate(DecodingData data) {
    return LanguageSetup(
      main: data.dec(_f$main),
      learned: data.dec(_f$learned),
      selected: data.dec(_f$selected),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageSetup fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageSetup>(map);
  }

  static LanguageSetup fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageSetup>(json);
  }
}

mixin LanguageSetupMappable {
  String toJson() {
    return LanguageSetupMapper.ensureInitialized().encodeJson<LanguageSetup>(
      this as LanguageSetup,
    );
  }

  Map<String, dynamic> toMap() {
    return LanguageSetupMapper.ensureInitialized().encodeMap<LanguageSetup>(
      this as LanguageSetup,
    );
  }

  LanguageSetupCopyWith<LanguageSetup, LanguageSetup, LanguageSetup>
  get copyWith => _LanguageSetupCopyWithImpl<LanguageSetup, LanguageSetup>(
    this as LanguageSetup,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return LanguageSetupMapper.ensureInitialized().stringifyValue(
      this as LanguageSetup,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageSetupMapper.ensureInitialized().equalsValue(
      this as LanguageSetup,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageSetupMapper.ensureInitialized().hashValue(
      this as LanguageSetup,
    );
  }
}

extension LanguageSetupValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageSetup, $Out> {
  LanguageSetupCopyWith<$R, LanguageSetup, $Out> get $asLanguageSetup =>
      $base.as((v, t, t2) => _LanguageSetupCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LanguageSetupCopyWith<$R, $In extends LanguageSetup, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    LearnedLanguage,
    LearnedLanguageCopyWith<$R, LearnedLanguage, LearnedLanguage>
  >
  get learned;
  $R call({Language? main, List<LearnedLanguage>? learned, Language? selected});
  LanguageSetupCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LanguageSetupCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageSetup, $Out>
    implements LanguageSetupCopyWith<$R, LanguageSetup, $Out> {
  _LanguageSetupCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageSetup> $mapper =
      LanguageSetupMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    LearnedLanguage,
    LearnedLanguageCopyWith<$R, LearnedLanguage, LearnedLanguage>
  >
  get learned => ListCopyWith(
    $value.learned,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(learned: v),
  );
  @override
  $R call({
    Language? main,
    List<LearnedLanguage>? learned,
    Language? selected,
  }) => $apply(
    FieldCopyWithData({
      if (main != null) #main: main,
      if (learned != null) #learned: learned,
      if (selected != null) #selected: selected,
    }),
  );
  @override
  LanguageSetup $make(CopyWithData data) => LanguageSetup(
    main: data.get(#main, or: $value.main),
    learned: data.get(#learned, or: $value.learned),
    selected: data.get(#selected, or: $value.selected),
  );

  @override
  LanguageSetupCopyWith<$R2, LanguageSetup, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanguageSetupCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LearnedLanguageMapper extends ClassMapperBase<LearnedLanguage> {
  LearnedLanguageMapper._();

  static LearnedLanguageMapper? _instance;
  static LearnedLanguageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LearnedLanguageMapper._());
      NewWordLimitMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LearnedLanguage';

  static Language _$language(LearnedLanguage v) => v.language;
  static const Field<LearnedLanguage, Language> _f$language = Field(
    'language',
    _$language,
  );
  static Language? _$askMeIn(LearnedLanguage v) => v.askMeIn;
  static const Field<LearnedLanguage, Language> _f$askMeIn = Field(
    'askMeIn',
    _$askMeIn,
  );
  static VocabularyLevel _$askMeInFromLevel(LearnedLanguage v) =>
      v.askMeInFromLevel;
  static const Field<LearnedLanguage, VocabularyLevel> _f$askMeInFromLevel =
      Field('askMeInFromLevel', _$askMeInFromLevel);
  static NewWordLimit _$newWords(LearnedLanguage v) => v.newWords;
  static const Field<LearnedLanguage, NewWordLimit> _f$newWords = Field(
    'newWords',
    _$newWords,
  );
  static bool _$isPaused(LearnedLanguage v) => v.isPaused;
  static const Field<LearnedLanguage, bool> _f$isPaused = Field(
    'isPaused',
    _$isPaused,
  );

  @override
  final MappableFields<LearnedLanguage> fields = const {
    #language: _f$language,
    #askMeIn: _f$askMeIn,
    #askMeInFromLevel: _f$askMeInFromLevel,
    #newWords: _f$newWords,
    #isPaused: _f$isPaused,
  };

  static LearnedLanguage _instantiate(DecodingData data) {
    return LearnedLanguage(
      language: data.dec(_f$language),
      askMeIn: data.dec(_f$askMeIn),
      askMeInFromLevel: data.dec(_f$askMeInFromLevel),
      newWords: data.dec(_f$newWords),
      isPaused: data.dec(_f$isPaused),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LearnedLanguage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LearnedLanguage>(map);
  }

  static LearnedLanguage fromJson(String json) {
    return ensureInitialized().decodeJson<LearnedLanguage>(json);
  }
}

mixin LearnedLanguageMappable {
  String toJson() {
    return LearnedLanguageMapper.ensureInitialized()
        .encodeJson<LearnedLanguage>(this as LearnedLanguage);
  }

  Map<String, dynamic> toMap() {
    return LearnedLanguageMapper.ensureInitialized().encodeMap<LearnedLanguage>(
      this as LearnedLanguage,
    );
  }

  LearnedLanguageCopyWith<LearnedLanguage, LearnedLanguage, LearnedLanguage>
  get copyWith =>
      _LearnedLanguageCopyWithImpl<LearnedLanguage, LearnedLanguage>(
        this as LearnedLanguage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LearnedLanguageMapper.ensureInitialized().stringifyValue(
      this as LearnedLanguage,
    );
  }

  @override
  bool operator ==(Object other) {
    return LearnedLanguageMapper.ensureInitialized().equalsValue(
      this as LearnedLanguage,
      other,
    );
  }

  @override
  int get hashCode {
    return LearnedLanguageMapper.ensureInitialized().hashValue(
      this as LearnedLanguage,
    );
  }
}

extension LearnedLanguageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LearnedLanguage, $Out> {
  LearnedLanguageCopyWith<$R, LearnedLanguage, $Out> get $asLearnedLanguage =>
      $base.as((v, t, t2) => _LearnedLanguageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LearnedLanguageCopyWith<$R, $In extends LearnedLanguage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  NewWordLimitCopyWith<$R, NewWordLimit, NewWordLimit> get newWords;
  $R call({
    Language? language,
    Language? askMeIn,
    VocabularyLevel? askMeInFromLevel,
    NewWordLimit? newWords,
    bool? isPaused,
  });
  LearnedLanguageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LearnedLanguageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LearnedLanguage, $Out>
    implements LearnedLanguageCopyWith<$R, LearnedLanguage, $Out> {
  _LearnedLanguageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LearnedLanguage> $mapper =
      LearnedLanguageMapper.ensureInitialized();
  @override
  NewWordLimitCopyWith<$R, NewWordLimit, NewWordLimit> get newWords =>
      $value.newWords.copyWith.$chain((v) => call(newWords: v));
  @override
  $R call({
    Language? language,
    Object? askMeIn = $none,
    VocabularyLevel? askMeInFromLevel,
    NewWordLimit? newWords,
    bool? isPaused,
  }) => $apply(
    FieldCopyWithData({
      if (language != null) #language: language,
      if (askMeIn != $none) #askMeIn: askMeIn,
      if (askMeInFromLevel != null) #askMeInFromLevel: askMeInFromLevel,
      if (newWords != null) #newWords: newWords,
      if (isPaused != null) #isPaused: isPaused,
    }),
  );
  @override
  LearnedLanguage $make(CopyWithData data) => LearnedLanguage(
    language: data.get(#language, or: $value.language),
    askMeIn: data.get(#askMeIn, or: $value.askMeIn),
    askMeInFromLevel: data.get(#askMeInFromLevel, or: $value.askMeInFromLevel),
    newWords: data.get(#newWords, or: $value.newWords),
    isPaused: data.get(#isPaused, or: $value.isPaused),
  );

  @override
  LearnedLanguageCopyWith<$R2, LearnedLanguage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LearnedLanguageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class NewWordLimitMapper extends ClassMapperBase<NewWordLimit> {
  NewWordLimitMapper._();

  static NewWordLimitMapper? _instance;
  static NewWordLimitMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NewWordLimitMapper._());
      NewWordsUpToMapper.ensureInitialized();
      AllNewWordsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NewWordLimit';

  @override
  final MappableFields<NewWordLimit> fields = const {};

  static NewWordLimit _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('NewWordLimit');
  }

  @override
  final Function instantiate = _instantiate;

  static NewWordLimit fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NewWordLimit>(map);
  }

  static NewWordLimit fromJson(String json) {
    return ensureInitialized().decodeJson<NewWordLimit>(json);
  }
}

mixin NewWordLimitMappable {
  String toJson();
  Map<String, dynamic> toMap();
  NewWordLimitCopyWith<NewWordLimit, NewWordLimit, NewWordLimit> get copyWith;
}

abstract class NewWordLimitCopyWith<$R, $In extends NewWordLimit, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  NewWordLimitCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class NewWordsUpToMapper extends ClassMapperBase<NewWordsUpTo> {
  NewWordsUpToMapper._();

  static NewWordsUpToMapper? _instance;
  static NewWordsUpToMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NewWordsUpToMapper._());
      NewWordLimitMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NewWordsUpTo';

  static int _$count(NewWordsUpTo v) => v.count;
  static const Field<NewWordsUpTo, int> _f$count = Field('count', _$count);

  @override
  final MappableFields<NewWordsUpTo> fields = const {#count: _f$count};

  static NewWordsUpTo _instantiate(DecodingData data) {
    return NewWordsUpTo(count: data.dec(_f$count));
  }

  @override
  final Function instantiate = _instantiate;

  static NewWordsUpTo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NewWordsUpTo>(map);
  }

  static NewWordsUpTo fromJson(String json) {
    return ensureInitialized().decodeJson<NewWordsUpTo>(json);
  }
}

mixin NewWordsUpToMappable {
  String toJson() {
    return NewWordsUpToMapper.ensureInitialized().encodeJson<NewWordsUpTo>(
      this as NewWordsUpTo,
    );
  }

  Map<String, dynamic> toMap() {
    return NewWordsUpToMapper.ensureInitialized().encodeMap<NewWordsUpTo>(
      this as NewWordsUpTo,
    );
  }

  NewWordsUpToCopyWith<NewWordsUpTo, NewWordsUpTo, NewWordsUpTo> get copyWith =>
      _NewWordsUpToCopyWithImpl<NewWordsUpTo, NewWordsUpTo>(
        this as NewWordsUpTo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return NewWordsUpToMapper.ensureInitialized().stringifyValue(
      this as NewWordsUpTo,
    );
  }

  @override
  bool operator ==(Object other) {
    return NewWordsUpToMapper.ensureInitialized().equalsValue(
      this as NewWordsUpTo,
      other,
    );
  }

  @override
  int get hashCode {
    return NewWordsUpToMapper.ensureInitialized().hashValue(
      this as NewWordsUpTo,
    );
  }
}

extension NewWordsUpToValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NewWordsUpTo, $Out> {
  NewWordsUpToCopyWith<$R, NewWordsUpTo, $Out> get $asNewWordsUpTo =>
      $base.as((v, t, t2) => _NewWordsUpToCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NewWordsUpToCopyWith<$R, $In extends NewWordsUpTo, $Out>
    implements NewWordLimitCopyWith<$R, $In, $Out> {
  @override
  $R call({int? count});
  NewWordsUpToCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NewWordsUpToCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NewWordsUpTo, $Out>
    implements NewWordsUpToCopyWith<$R, NewWordsUpTo, $Out> {
  _NewWordsUpToCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NewWordsUpTo> $mapper =
      NewWordsUpToMapper.ensureInitialized();
  @override
  $R call({int? count}) =>
      $apply(FieldCopyWithData({if (count != null) #count: count}));
  @override
  NewWordsUpTo $make(CopyWithData data) =>
      NewWordsUpTo(count: data.get(#count, or: $value.count));

  @override
  NewWordsUpToCopyWith<$R2, NewWordsUpTo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _NewWordsUpToCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AllNewWordsMapper extends ClassMapperBase<AllNewWords> {
  AllNewWordsMapper._();

  static AllNewWordsMapper? _instance;
  static AllNewWordsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AllNewWordsMapper._());
      NewWordLimitMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AllNewWords';

  @override
  final MappableFields<AllNewWords> fields = const {};

  static AllNewWords _instantiate(DecodingData data) {
    return AllNewWords();
  }

  @override
  final Function instantiate = _instantiate;

  static AllNewWords fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AllNewWords>(map);
  }

  static AllNewWords fromJson(String json) {
    return ensureInitialized().decodeJson<AllNewWords>(json);
  }
}

mixin AllNewWordsMappable {
  String toJson() {
    return AllNewWordsMapper.ensureInitialized().encodeJson<AllNewWords>(
      this as AllNewWords,
    );
  }

  Map<String, dynamic> toMap() {
    return AllNewWordsMapper.ensureInitialized().encodeMap<AllNewWords>(
      this as AllNewWords,
    );
  }

  AllNewWordsCopyWith<AllNewWords, AllNewWords, AllNewWords> get copyWith =>
      _AllNewWordsCopyWithImpl<AllNewWords, AllNewWords>(
        this as AllNewWords,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AllNewWordsMapper.ensureInitialized().stringifyValue(
      this as AllNewWords,
    );
  }

  @override
  bool operator ==(Object other) {
    return AllNewWordsMapper.ensureInitialized().equalsValue(
      this as AllNewWords,
      other,
    );
  }

  @override
  int get hashCode {
    return AllNewWordsMapper.ensureInitialized().hashValue(this as AllNewWords);
  }
}

extension AllNewWordsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AllNewWords, $Out> {
  AllNewWordsCopyWith<$R, AllNewWords, $Out> get $asAllNewWords =>
      $base.as((v, t, t2) => _AllNewWordsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AllNewWordsCopyWith<$R, $In extends AllNewWords, $Out>
    implements NewWordLimitCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AllNewWordsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AllNewWordsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AllNewWords, $Out>
    implements AllNewWordsCopyWith<$R, AllNewWords, $Out> {
  _AllNewWordsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AllNewWords> $mapper =
      AllNewWordsMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AllNewWords $make(CopyWithData data) => AllNewWords();

  @override
  AllNewWordsCopyWith<$R2, AllNewWords, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AllNewWordsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

