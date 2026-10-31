// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'custom_practice_state.dart';

class CustomPracticeStateMapper extends ClassMapperBase<CustomPracticeState> {
  CustomPracticeStateMapper._();

  static CustomPracticeStateMapper? _instance;
  static CustomPracticeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomPracticeStateMapper._());
      CustomPracticeLoadingMapper.ensureInitialized();
      CustomPracticeEditingMapper.ensureInitialized();
      CustomPracticeLaunchedMapper.ensureInitialized();
      CustomPracticeFailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CustomPracticeState';

  @override
  final MappableFields<CustomPracticeState> fields = const {};

  static CustomPracticeState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('CustomPracticeState');
  }

  @override
  final Function instantiate = _instantiate;

  static CustomPracticeState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomPracticeState>(map);
  }

  static CustomPracticeState fromJson(String json) {
    return ensureInitialized().decodeJson<CustomPracticeState>(json);
  }
}

mixin CustomPracticeStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  CustomPracticeStateCopyWith<
    CustomPracticeState,
    CustomPracticeState,
    CustomPracticeState
  >
  get copyWith;
}

abstract class CustomPracticeStateCopyWith<
  $R,
  $In extends CustomPracticeState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  CustomPracticeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class CustomPracticeLoadingMapper
    extends ClassMapperBase<CustomPracticeLoading> {
  CustomPracticeLoadingMapper._();

  static CustomPracticeLoadingMapper? _instance;
  static CustomPracticeLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomPracticeLoadingMapper._());
      CustomPracticeStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CustomPracticeLoading';

  @override
  final MappableFields<CustomPracticeLoading> fields = const {};

  static CustomPracticeLoading _instantiate(DecodingData data) {
    return CustomPracticeLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static CustomPracticeLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomPracticeLoading>(map);
  }

  static CustomPracticeLoading fromJson(String json) {
    return ensureInitialized().decodeJson<CustomPracticeLoading>(json);
  }
}

mixin CustomPracticeLoadingMappable {
  String toJson() {
    return CustomPracticeLoadingMapper.ensureInitialized()
        .encodeJson<CustomPracticeLoading>(this as CustomPracticeLoading);
  }

  Map<String, dynamic> toMap() {
    return CustomPracticeLoadingMapper.ensureInitialized()
        .encodeMap<CustomPracticeLoading>(this as CustomPracticeLoading);
  }

  CustomPracticeLoadingCopyWith<
    CustomPracticeLoading,
    CustomPracticeLoading,
    CustomPracticeLoading
  >
  get copyWith =>
      _CustomPracticeLoadingCopyWithImpl<
        CustomPracticeLoading,
        CustomPracticeLoading
      >(this as CustomPracticeLoading, $identity, $identity);
  @override
  String toString() {
    return CustomPracticeLoadingMapper.ensureInitialized().stringifyValue(
      this as CustomPracticeLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return CustomPracticeLoadingMapper.ensureInitialized().equalsValue(
      this as CustomPracticeLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return CustomPracticeLoadingMapper.ensureInitialized().hashValue(
      this as CustomPracticeLoading,
    );
  }
}

extension CustomPracticeLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CustomPracticeLoading, $Out> {
  CustomPracticeLoadingCopyWith<$R, CustomPracticeLoading, $Out>
  get $asCustomPracticeLoading => $base.as(
    (v, t, t2) => _CustomPracticeLoadingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CustomPracticeLoadingCopyWith<
  $R,
  $In extends CustomPracticeLoading,
  $Out
>
    implements CustomPracticeStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  CustomPracticeLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CustomPracticeLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CustomPracticeLoading, $Out>
    implements CustomPracticeLoadingCopyWith<$R, CustomPracticeLoading, $Out> {
  _CustomPracticeLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CustomPracticeLoading> $mapper =
      CustomPracticeLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  CustomPracticeLoading $make(CopyWithData data) => CustomPracticeLoading();

  @override
  CustomPracticeLoadingCopyWith<$R2, CustomPracticeLoading, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CustomPracticeLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CustomPracticeEditingMapper
    extends ClassMapperBase<CustomPracticeEditing> {
  CustomPracticeEditingMapper._();

  static CustomPracticeEditingMapper? _instance;
  static CustomPracticeEditingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomPracticeEditingMapper._());
      CustomPracticeStateMapper.ensureInitialized();
      LanguageSetupMapper.ensureInitialized();
      TagMapper.ensureInitialized();
      CustomPracticeFilterMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CustomPracticeEditing';

  static LanguageSetup _$setup(CustomPracticeEditing v) => v.setup;
  static const Field<CustomPracticeEditing, LanguageSetup> _f$setup = Field(
    'setup',
    _$setup,
  );
  static List<Tag> _$tags(CustomPracticeEditing v) => v.tags;
  static const Field<CustomPracticeEditing, List<Tag>> _f$tags = Field(
    'tags',
    _$tags,
  );
  static CustomPracticeFilter _$filter(CustomPracticeEditing v) => v.filter;
  static const Field<CustomPracticeEditing, CustomPracticeFilter> _f$filter =
      Field('filter', _$filter);
  static bool _$isChoosingCollections(CustomPracticeEditing v) =>
      v.isChoosingCollections;
  static const Field<CustomPracticeEditing, bool> _f$isChoosingCollections =
      Field('isChoosingCollections', _$isChoosingCollections);
  static int? _$count(CustomPracticeEditing v) => v.count;
  static const Field<CustomPracticeEditing, int> _f$count = Field(
    'count',
    _$count,
  );
  static bool _$hasUnfinishedSession(CustomPracticeEditing v) =>
      v.hasUnfinishedSession;
  static const Field<CustomPracticeEditing, bool> _f$hasUnfinishedSession =
      Field('hasUnfinishedSession', _$hasUnfinishedSession);
  static bool _$isStarting(CustomPracticeEditing v) => v.isStarting;
  static const Field<CustomPracticeEditing, bool> _f$isStarting = Field(
    'isStarting',
    _$isStarting,
  );
  static AppError? _$error(CustomPracticeEditing v) => v.error;
  static const Field<CustomPracticeEditing, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<CustomPracticeEditing> fields = const {
    #setup: _f$setup,
    #tags: _f$tags,
    #filter: _f$filter,
    #isChoosingCollections: _f$isChoosingCollections,
    #count: _f$count,
    #hasUnfinishedSession: _f$hasUnfinishedSession,
    #isStarting: _f$isStarting,
    #error: _f$error,
  };

  static CustomPracticeEditing _instantiate(DecodingData data) {
    return CustomPracticeEditing(
      setup: data.dec(_f$setup),
      tags: data.dec(_f$tags),
      filter: data.dec(_f$filter),
      isChoosingCollections: data.dec(_f$isChoosingCollections),
      count: data.dec(_f$count),
      hasUnfinishedSession: data.dec(_f$hasUnfinishedSession),
      isStarting: data.dec(_f$isStarting),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CustomPracticeEditing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomPracticeEditing>(map);
  }

  static CustomPracticeEditing fromJson(String json) {
    return ensureInitialized().decodeJson<CustomPracticeEditing>(json);
  }
}

mixin CustomPracticeEditingMappable {
  String toJson() {
    return CustomPracticeEditingMapper.ensureInitialized()
        .encodeJson<CustomPracticeEditing>(this as CustomPracticeEditing);
  }

  Map<String, dynamic> toMap() {
    return CustomPracticeEditingMapper.ensureInitialized()
        .encodeMap<CustomPracticeEditing>(this as CustomPracticeEditing);
  }

  CustomPracticeEditingCopyWith<
    CustomPracticeEditing,
    CustomPracticeEditing,
    CustomPracticeEditing
  >
  get copyWith =>
      _CustomPracticeEditingCopyWithImpl<
        CustomPracticeEditing,
        CustomPracticeEditing
      >(this as CustomPracticeEditing, $identity, $identity);
  @override
  String toString() {
    return CustomPracticeEditingMapper.ensureInitialized().stringifyValue(
      this as CustomPracticeEditing,
    );
  }

  @override
  bool operator ==(Object other) {
    return CustomPracticeEditingMapper.ensureInitialized().equalsValue(
      this as CustomPracticeEditing,
      other,
    );
  }

  @override
  int get hashCode {
    return CustomPracticeEditingMapper.ensureInitialized().hashValue(
      this as CustomPracticeEditing,
    );
  }
}

extension CustomPracticeEditingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CustomPracticeEditing, $Out> {
  CustomPracticeEditingCopyWith<$R, CustomPracticeEditing, $Out>
  get $asCustomPracticeEditing => $base.as(
    (v, t, t2) => _CustomPracticeEditingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CustomPracticeEditingCopyWith<
  $R,
  $In extends CustomPracticeEditing,
  $Out
>
    implements CustomPracticeStateCopyWith<$R, $In, $Out> {
  LanguageSetupCopyWith<$R, LanguageSetup, LanguageSetup> get setup;
  ListCopyWith<$R, Tag, TagCopyWith<$R, Tag, Tag>> get tags;
  CustomPracticeFilterCopyWith<$R, CustomPracticeFilter, CustomPracticeFilter>
  get filter;
  @override
  $R call({
    LanguageSetup? setup,
    List<Tag>? tags,
    CustomPracticeFilter? filter,
    bool? isChoosingCollections,
    int? count,
    bool? hasUnfinishedSession,
    bool? isStarting,
    AppError? error,
  });
  CustomPracticeEditingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CustomPracticeEditingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CustomPracticeEditing, $Out>
    implements CustomPracticeEditingCopyWith<$R, CustomPracticeEditing, $Out> {
  _CustomPracticeEditingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CustomPracticeEditing> $mapper =
      CustomPracticeEditingMapper.ensureInitialized();
  @override
  LanguageSetupCopyWith<$R, LanguageSetup, LanguageSetup> get setup =>
      $value.setup.copyWith.$chain((v) => call(setup: v));
  @override
  ListCopyWith<$R, Tag, TagCopyWith<$R, Tag, Tag>> get tags => ListCopyWith(
    $value.tags,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(tags: v),
  );
  @override
  CustomPracticeFilterCopyWith<$R, CustomPracticeFilter, CustomPracticeFilter>
  get filter => $value.filter.copyWith.$chain((v) => call(filter: v));
  @override
  $R call({
    LanguageSetup? setup,
    List<Tag>? tags,
    CustomPracticeFilter? filter,
    bool? isChoosingCollections,
    Object? count = $none,
    bool? hasUnfinishedSession,
    bool? isStarting,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (setup != null) #setup: setup,
      if (tags != null) #tags: tags,
      if (filter != null) #filter: filter,
      if (isChoosingCollections != null)
        #isChoosingCollections: isChoosingCollections,
      if (count != $none) #count: count,
      if (hasUnfinishedSession != null)
        #hasUnfinishedSession: hasUnfinishedSession,
      if (isStarting != null) #isStarting: isStarting,
      if (error != $none) #error: error,
    }),
  );
  @override
  CustomPracticeEditing $make(CopyWithData data) => CustomPracticeEditing(
    setup: data.get(#setup, or: $value.setup),
    tags: data.get(#tags, or: $value.tags),
    filter: data.get(#filter, or: $value.filter),
    isChoosingCollections: data.get(
      #isChoosingCollections,
      or: $value.isChoosingCollections,
    ),
    count: data.get(#count, or: $value.count),
    hasUnfinishedSession: data.get(
      #hasUnfinishedSession,
      or: $value.hasUnfinishedSession,
    ),
    isStarting: data.get(#isStarting, or: $value.isStarting),
    error: data.get(#error, or: $value.error),
  );

  @override
  CustomPracticeEditingCopyWith<$R2, CustomPracticeEditing, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CustomPracticeEditingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CustomPracticeLaunchedMapper
    extends ClassMapperBase<CustomPracticeLaunched> {
  CustomPracticeLaunchedMapper._();

  static CustomPracticeLaunchedMapper? _instance;
  static CustomPracticeLaunchedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomPracticeLaunchedMapper._());
      CustomPracticeStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CustomPracticeLaunched';

  @override
  final MappableFields<CustomPracticeLaunched> fields = const {};

  static CustomPracticeLaunched _instantiate(DecodingData data) {
    return CustomPracticeLaunched();
  }

  @override
  final Function instantiate = _instantiate;

  static CustomPracticeLaunched fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomPracticeLaunched>(map);
  }

  static CustomPracticeLaunched fromJson(String json) {
    return ensureInitialized().decodeJson<CustomPracticeLaunched>(json);
  }
}

mixin CustomPracticeLaunchedMappable {
  String toJson() {
    return CustomPracticeLaunchedMapper.ensureInitialized()
        .encodeJson<CustomPracticeLaunched>(this as CustomPracticeLaunched);
  }

  Map<String, dynamic> toMap() {
    return CustomPracticeLaunchedMapper.ensureInitialized()
        .encodeMap<CustomPracticeLaunched>(this as CustomPracticeLaunched);
  }

  CustomPracticeLaunchedCopyWith<
    CustomPracticeLaunched,
    CustomPracticeLaunched,
    CustomPracticeLaunched
  >
  get copyWith =>
      _CustomPracticeLaunchedCopyWithImpl<
        CustomPracticeLaunched,
        CustomPracticeLaunched
      >(this as CustomPracticeLaunched, $identity, $identity);
  @override
  String toString() {
    return CustomPracticeLaunchedMapper.ensureInitialized().stringifyValue(
      this as CustomPracticeLaunched,
    );
  }

  @override
  bool operator ==(Object other) {
    return CustomPracticeLaunchedMapper.ensureInitialized().equalsValue(
      this as CustomPracticeLaunched,
      other,
    );
  }

  @override
  int get hashCode {
    return CustomPracticeLaunchedMapper.ensureInitialized().hashValue(
      this as CustomPracticeLaunched,
    );
  }
}

extension CustomPracticeLaunchedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CustomPracticeLaunched, $Out> {
  CustomPracticeLaunchedCopyWith<$R, CustomPracticeLaunched, $Out>
  get $asCustomPracticeLaunched => $base.as(
    (v, t, t2) => _CustomPracticeLaunchedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CustomPracticeLaunchedCopyWith<
  $R,
  $In extends CustomPracticeLaunched,
  $Out
>
    implements CustomPracticeStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  CustomPracticeLaunchedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CustomPracticeLaunchedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CustomPracticeLaunched, $Out>
    implements
        CustomPracticeLaunchedCopyWith<$R, CustomPracticeLaunched, $Out> {
  _CustomPracticeLaunchedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CustomPracticeLaunched> $mapper =
      CustomPracticeLaunchedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  CustomPracticeLaunched $make(CopyWithData data) => CustomPracticeLaunched();

  @override
  CustomPracticeLaunchedCopyWith<$R2, CustomPracticeLaunched, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CustomPracticeLaunchedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CustomPracticeFailureMapper
    extends ClassMapperBase<CustomPracticeFailure> {
  CustomPracticeFailureMapper._();

  static CustomPracticeFailureMapper? _instance;
  static CustomPracticeFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomPracticeFailureMapper._());
      CustomPracticeStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CustomPracticeFailure';

  static AppError _$error(CustomPracticeFailure v) => v.error;
  static const Field<CustomPracticeFailure, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<CustomPracticeFailure> fields = const {#error: _f$error};

  static CustomPracticeFailure _instantiate(DecodingData data) {
    return CustomPracticeFailure(error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static CustomPracticeFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomPracticeFailure>(map);
  }

  static CustomPracticeFailure fromJson(String json) {
    return ensureInitialized().decodeJson<CustomPracticeFailure>(json);
  }
}

mixin CustomPracticeFailureMappable {
  String toJson() {
    return CustomPracticeFailureMapper.ensureInitialized()
        .encodeJson<CustomPracticeFailure>(this as CustomPracticeFailure);
  }

  Map<String, dynamic> toMap() {
    return CustomPracticeFailureMapper.ensureInitialized()
        .encodeMap<CustomPracticeFailure>(this as CustomPracticeFailure);
  }

  CustomPracticeFailureCopyWith<
    CustomPracticeFailure,
    CustomPracticeFailure,
    CustomPracticeFailure
  >
  get copyWith =>
      _CustomPracticeFailureCopyWithImpl<
        CustomPracticeFailure,
        CustomPracticeFailure
      >(this as CustomPracticeFailure, $identity, $identity);
  @override
  String toString() {
    return CustomPracticeFailureMapper.ensureInitialized().stringifyValue(
      this as CustomPracticeFailure,
    );
  }

  @override
  bool operator ==(Object other) {
    return CustomPracticeFailureMapper.ensureInitialized().equalsValue(
      this as CustomPracticeFailure,
      other,
    );
  }

  @override
  int get hashCode {
    return CustomPracticeFailureMapper.ensureInitialized().hashValue(
      this as CustomPracticeFailure,
    );
  }
}

extension CustomPracticeFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CustomPracticeFailure, $Out> {
  CustomPracticeFailureCopyWith<$R, CustomPracticeFailure, $Out>
  get $asCustomPracticeFailure => $base.as(
    (v, t, t2) => _CustomPracticeFailureCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CustomPracticeFailureCopyWith<
  $R,
  $In extends CustomPracticeFailure,
  $Out
>
    implements CustomPracticeStateCopyWith<$R, $In, $Out> {
  @override
  $R call({AppError? error});
  CustomPracticeFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CustomPracticeFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CustomPracticeFailure, $Out>
    implements CustomPracticeFailureCopyWith<$R, CustomPracticeFailure, $Out> {
  _CustomPracticeFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CustomPracticeFailure> $mapper =
      CustomPracticeFailureMapper.ensureInitialized();
  @override
  $R call({AppError? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  CustomPracticeFailure $make(CopyWithData data) =>
      CustomPracticeFailure(error: data.get(#error, or: $value.error));

  @override
  CustomPracticeFailureCopyWith<$R2, CustomPracticeFailure, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CustomPracticeFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

