// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'practice_state.dart';

class PracticeStateMapper extends ClassMapperBase<PracticeState> {
  PracticeStateMapper._();

  static PracticeStateMapper? _instance;
  static PracticeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PracticeStateMapper._());
      PracticeLoadingMapper.ensureInitialized();
      PracticeActiveMapper.ensureInitialized();
      PracticeDoneMapper.ensureInitialized();
      PracticeFailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PracticeState';

  @override
  final MappableFields<PracticeState> fields = const {};

  static PracticeState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('PracticeState');
  }

  @override
  final Function instantiate = _instantiate;

  static PracticeState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PracticeState>(map);
  }

  static PracticeState fromJson(String json) {
    return ensureInitialized().decodeJson<PracticeState>(json);
  }
}

mixin PracticeStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  PracticeStateCopyWith<PracticeState, PracticeState, PracticeState>
  get copyWith;
}

abstract class PracticeStateCopyWith<$R, $In extends PracticeState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  PracticeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class PracticeLoadingMapper extends ClassMapperBase<PracticeLoading> {
  PracticeLoadingMapper._();

  static PracticeLoadingMapper? _instance;
  static PracticeLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PracticeLoadingMapper._());
      PracticeStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PracticeLoading';

  @override
  final MappableFields<PracticeLoading> fields = const {};

  static PracticeLoading _instantiate(DecodingData data) {
    return PracticeLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static PracticeLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PracticeLoading>(map);
  }

  static PracticeLoading fromJson(String json) {
    return ensureInitialized().decodeJson<PracticeLoading>(json);
  }
}

mixin PracticeLoadingMappable {
  String toJson() {
    return PracticeLoadingMapper.ensureInitialized()
        .encodeJson<PracticeLoading>(this as PracticeLoading);
  }

  Map<String, dynamic> toMap() {
    return PracticeLoadingMapper.ensureInitialized().encodeMap<PracticeLoading>(
      this as PracticeLoading,
    );
  }

  PracticeLoadingCopyWith<PracticeLoading, PracticeLoading, PracticeLoading>
  get copyWith =>
      _PracticeLoadingCopyWithImpl<PracticeLoading, PracticeLoading>(
        this as PracticeLoading,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PracticeLoadingMapper.ensureInitialized().stringifyValue(
      this as PracticeLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return PracticeLoadingMapper.ensureInitialized().equalsValue(
      this as PracticeLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return PracticeLoadingMapper.ensureInitialized().hashValue(
      this as PracticeLoading,
    );
  }
}

extension PracticeLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PracticeLoading, $Out> {
  PracticeLoadingCopyWith<$R, PracticeLoading, $Out> get $asPracticeLoading =>
      $base.as((v, t, t2) => _PracticeLoadingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PracticeLoadingCopyWith<$R, $In extends PracticeLoading, $Out>
    implements PracticeStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  PracticeLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PracticeLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PracticeLoading, $Out>
    implements PracticeLoadingCopyWith<$R, PracticeLoading, $Out> {
  _PracticeLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PracticeLoading> $mapper =
      PracticeLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  PracticeLoading $make(CopyWithData data) => PracticeLoading();

  @override
  PracticeLoadingCopyWith<$R2, PracticeLoading, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PracticeLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PracticeActiveMapper extends ClassMapperBase<PracticeActive> {
  PracticeActiveMapper._();

  static PracticeActiveMapper? _instance;
  static PracticeActiveMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PracticeActiveMapper._());
      PracticeStateMapper.ensureInitialized();
      VocabularyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PracticeActive';

  static DateTime _$dueBy(PracticeActive v) => v.dueBy;
  static const Field<PracticeActive, DateTime> _f$dueBy = Field(
    'dueBy',
    _$dueBy,
  );
  static String? _$tagId(PracticeActive v) => v.tagId;
  static const Field<PracticeActive, String> _f$tagId = Field('tagId', _$tagId);
  static int _$totalCount(PracticeActive v) => v.totalCount;
  static const Field<PracticeActive, int> _f$totalCount = Field(
    'totalCount',
    _$totalCount,
  );
  static int _$doneCount(PracticeActive v) => v.doneCount;
  static const Field<PracticeActive, int> _f$doneCount = Field(
    'doneCount',
    _$doneCount,
  );
  static List<Vocabulary> _$queue(PracticeActive v) => v.queue;
  static const Field<PracticeActive, List<Vocabulary>> _f$queue = Field(
    'queue',
    _$queue,
  );
  static bool _$showsLanguages(PracticeActive v) => v.showsLanguages;
  static const Field<PracticeActive, bool> _f$showsLanguages = Field(
    'showsLanguages',
    _$showsLanguages,
  );
  static String? _$typedAnswer(PracticeActive v) => v.typedAnswer;
  static const Field<PracticeActive, String> _f$typedAnswer = Field(
    'typedAnswer',
    _$typedAnswer,
  );
  static PracticeAnswer? _$grade(PracticeActive v) => v.grade;
  static const Field<PracticeActive, PracticeAnswer> _f$grade = Field(
    'grade',
    _$grade,
  );
  static bool _$isSolutionShown(PracticeActive v) => v.isSolutionShown;
  static const Field<PracticeActive, bool> _f$isSolutionShown = Field(
    'isSolutionShown',
    _$isSolutionShown,
  );
  static bool _$isBusy(PracticeActive v) => v.isBusy;
  static const Field<PracticeActive, bool> _f$isBusy = Field(
    'isBusy',
    _$isBusy,
  );
  static AppError? _$error(PracticeActive v) => v.error;
  static const Field<PracticeActive, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<PracticeActive> fields = const {
    #dueBy: _f$dueBy,
    #tagId: _f$tagId,
    #totalCount: _f$totalCount,
    #doneCount: _f$doneCount,
    #queue: _f$queue,
    #showsLanguages: _f$showsLanguages,
    #typedAnswer: _f$typedAnswer,
    #grade: _f$grade,
    #isSolutionShown: _f$isSolutionShown,
    #isBusy: _f$isBusy,
    #error: _f$error,
  };

  static PracticeActive _instantiate(DecodingData data) {
    return PracticeActive(
      dueBy: data.dec(_f$dueBy),
      tagId: data.dec(_f$tagId),
      totalCount: data.dec(_f$totalCount),
      doneCount: data.dec(_f$doneCount),
      queue: data.dec(_f$queue),
      showsLanguages: data.dec(_f$showsLanguages),
      typedAnswer: data.dec(_f$typedAnswer),
      grade: data.dec(_f$grade),
      isSolutionShown: data.dec(_f$isSolutionShown),
      isBusy: data.dec(_f$isBusy),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PracticeActive fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PracticeActive>(map);
  }

  static PracticeActive fromJson(String json) {
    return ensureInitialized().decodeJson<PracticeActive>(json);
  }
}

mixin PracticeActiveMappable {
  String toJson() {
    return PracticeActiveMapper.ensureInitialized().encodeJson<PracticeActive>(
      this as PracticeActive,
    );
  }

  Map<String, dynamic> toMap() {
    return PracticeActiveMapper.ensureInitialized().encodeMap<PracticeActive>(
      this as PracticeActive,
    );
  }

  PracticeActiveCopyWith<PracticeActive, PracticeActive, PracticeActive>
  get copyWith => _PracticeActiveCopyWithImpl<PracticeActive, PracticeActive>(
    this as PracticeActive,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PracticeActiveMapper.ensureInitialized().stringifyValue(
      this as PracticeActive,
    );
  }

  @override
  bool operator ==(Object other) {
    return PracticeActiveMapper.ensureInitialized().equalsValue(
      this as PracticeActive,
      other,
    );
  }

  @override
  int get hashCode {
    return PracticeActiveMapper.ensureInitialized().hashValue(
      this as PracticeActive,
    );
  }
}

extension PracticeActiveValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PracticeActive, $Out> {
  PracticeActiveCopyWith<$R, PracticeActive, $Out> get $asPracticeActive =>
      $base.as((v, t, t2) => _PracticeActiveCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PracticeActiveCopyWith<$R, $In extends PracticeActive, $Out>
    implements PracticeStateCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>
  get queue;
  @override
  $R call({
    DateTime? dueBy,
    String? tagId,
    int? totalCount,
    int? doneCount,
    List<Vocabulary>? queue,
    bool? showsLanguages,
    String? typedAnswer,
    PracticeAnswer? grade,
    bool? isSolutionShown,
    bool? isBusy,
    AppError? error,
  });
  PracticeActiveCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PracticeActiveCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PracticeActive, $Out>
    implements PracticeActiveCopyWith<$R, PracticeActive, $Out> {
  _PracticeActiveCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PracticeActive> $mapper =
      PracticeActiveMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Vocabulary, VocabularyCopyWith<$R, Vocabulary, Vocabulary>>
  get queue => ListCopyWith(
    $value.queue,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(queue: v),
  );
  @override
  $R call({
    DateTime? dueBy,
    Object? tagId = $none,
    int? totalCount,
    int? doneCount,
    List<Vocabulary>? queue,
    bool? showsLanguages,
    Object? typedAnswer = $none,
    Object? grade = $none,
    bool? isSolutionShown,
    bool? isBusy,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (dueBy != null) #dueBy: dueBy,
      if (tagId != $none) #tagId: tagId,
      if (totalCount != null) #totalCount: totalCount,
      if (doneCount != null) #doneCount: doneCount,
      if (queue != null) #queue: queue,
      if (showsLanguages != null) #showsLanguages: showsLanguages,
      if (typedAnswer != $none) #typedAnswer: typedAnswer,
      if (grade != $none) #grade: grade,
      if (isSolutionShown != null) #isSolutionShown: isSolutionShown,
      if (isBusy != null) #isBusy: isBusy,
      if (error != $none) #error: error,
    }),
  );
  @override
  PracticeActive $make(CopyWithData data) => PracticeActive(
    dueBy: data.get(#dueBy, or: $value.dueBy),
    tagId: data.get(#tagId, or: $value.tagId),
    totalCount: data.get(#totalCount, or: $value.totalCount),
    doneCount: data.get(#doneCount, or: $value.doneCount),
    queue: data.get(#queue, or: $value.queue),
    showsLanguages: data.get(#showsLanguages, or: $value.showsLanguages),
    typedAnswer: data.get(#typedAnswer, or: $value.typedAnswer),
    grade: data.get(#grade, or: $value.grade),
    isSolutionShown: data.get(#isSolutionShown, or: $value.isSolutionShown),
    isBusy: data.get(#isBusy, or: $value.isBusy),
    error: data.get(#error, or: $value.error),
  );

  @override
  PracticeActiveCopyWith<$R2, PracticeActive, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PracticeActiveCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PracticeDoneMapper extends ClassMapperBase<PracticeDone> {
  PracticeDoneMapper._();

  static PracticeDoneMapper? _instance;
  static PracticeDoneMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PracticeDoneMapper._());
      PracticeStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PracticeDone';

  @override
  final MappableFields<PracticeDone> fields = const {};

  static PracticeDone _instantiate(DecodingData data) {
    return PracticeDone();
  }

  @override
  final Function instantiate = _instantiate;

  static PracticeDone fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PracticeDone>(map);
  }

  static PracticeDone fromJson(String json) {
    return ensureInitialized().decodeJson<PracticeDone>(json);
  }
}

mixin PracticeDoneMappable {
  String toJson() {
    return PracticeDoneMapper.ensureInitialized().encodeJson<PracticeDone>(
      this as PracticeDone,
    );
  }

  Map<String, dynamic> toMap() {
    return PracticeDoneMapper.ensureInitialized().encodeMap<PracticeDone>(
      this as PracticeDone,
    );
  }

  PracticeDoneCopyWith<PracticeDone, PracticeDone, PracticeDone> get copyWith =>
      _PracticeDoneCopyWithImpl<PracticeDone, PracticeDone>(
        this as PracticeDone,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PracticeDoneMapper.ensureInitialized().stringifyValue(
      this as PracticeDone,
    );
  }

  @override
  bool operator ==(Object other) {
    return PracticeDoneMapper.ensureInitialized().equalsValue(
      this as PracticeDone,
      other,
    );
  }

  @override
  int get hashCode {
    return PracticeDoneMapper.ensureInitialized().hashValue(
      this as PracticeDone,
    );
  }
}

extension PracticeDoneValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PracticeDone, $Out> {
  PracticeDoneCopyWith<$R, PracticeDone, $Out> get $asPracticeDone =>
      $base.as((v, t, t2) => _PracticeDoneCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PracticeDoneCopyWith<$R, $In extends PracticeDone, $Out>
    implements PracticeStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  PracticeDoneCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PracticeDoneCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PracticeDone, $Out>
    implements PracticeDoneCopyWith<$R, PracticeDone, $Out> {
  _PracticeDoneCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PracticeDone> $mapper =
      PracticeDoneMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  PracticeDone $make(CopyWithData data) => PracticeDone();

  @override
  PracticeDoneCopyWith<$R2, PracticeDone, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PracticeDoneCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PracticeFailureMapper extends ClassMapperBase<PracticeFailure> {
  PracticeFailureMapper._();

  static PracticeFailureMapper? _instance;
  static PracticeFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PracticeFailureMapper._());
      PracticeStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PracticeFailure';

  static AppError _$error(PracticeFailure v) => v.error;
  static const Field<PracticeFailure, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<PracticeFailure> fields = const {#error: _f$error};

  static PracticeFailure _instantiate(DecodingData data) {
    return PracticeFailure(error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static PracticeFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PracticeFailure>(map);
  }

  static PracticeFailure fromJson(String json) {
    return ensureInitialized().decodeJson<PracticeFailure>(json);
  }
}

mixin PracticeFailureMappable {
  String toJson() {
    return PracticeFailureMapper.ensureInitialized()
        .encodeJson<PracticeFailure>(this as PracticeFailure);
  }

  Map<String, dynamic> toMap() {
    return PracticeFailureMapper.ensureInitialized().encodeMap<PracticeFailure>(
      this as PracticeFailure,
    );
  }

  PracticeFailureCopyWith<PracticeFailure, PracticeFailure, PracticeFailure>
  get copyWith =>
      _PracticeFailureCopyWithImpl<PracticeFailure, PracticeFailure>(
        this as PracticeFailure,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PracticeFailureMapper.ensureInitialized().stringifyValue(
      this as PracticeFailure,
    );
  }

  @override
  bool operator ==(Object other) {
    return PracticeFailureMapper.ensureInitialized().equalsValue(
      this as PracticeFailure,
      other,
    );
  }

  @override
  int get hashCode {
    return PracticeFailureMapper.ensureInitialized().hashValue(
      this as PracticeFailure,
    );
  }
}

extension PracticeFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PracticeFailure, $Out> {
  PracticeFailureCopyWith<$R, PracticeFailure, $Out> get $asPracticeFailure =>
      $base.as((v, t, t2) => _PracticeFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PracticeFailureCopyWith<$R, $In extends PracticeFailure, $Out>
    implements PracticeStateCopyWith<$R, $In, $Out> {
  @override
  $R call({AppError? error});
  PracticeFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PracticeFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PracticeFailure, $Out>
    implements PracticeFailureCopyWith<$R, PracticeFailure, $Out> {
  _PracticeFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PracticeFailure> $mapper =
      PracticeFailureMapper.ensureInitialized();
  @override
  $R call({AppError? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  PracticeFailure $make(CopyWithData data) =>
      PracticeFailure(error: data.get(#error, or: $value.error));

  @override
  PracticeFailureCopyWith<$R2, PracticeFailure, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PracticeFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

