// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'progress.dart';

class ProgressMapper extends ClassMapperBase<Progress> {
  ProgressMapper._();

  static ProgressMapper? _instance;
  static ProgressMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProgressMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Progress';

  static Language _$language(Progress v) => v.language;
  static const Field<Progress, Language> _f$language = Field(
    'language',
    _$language,
  );
  static ProgressStage _$stage(Progress v) => v.stage;
  static const Field<Progress, ProgressStage> _f$stage = Field(
    'stage',
    _$stage,
  );
  static double _$level(Progress v) => v.level;
  static const Field<Progress, double> _f$level = Field('level', _$level);
  static int _$intervalMinutes(Progress v) => v.intervalMinutes;
  static const Field<Progress, int> _f$intervalMinutes = Field(
    'intervalMinutes',
    _$intervalMinutes,
  );
  static double _$ease(Progress v) => v.ease;
  static const Field<Progress, double> _f$ease = Field('ease', _$ease);
  static DateTime _$nextReviewAt(Progress v) => v.nextReviewAt;
  static const Field<Progress, DateTime> _f$nextReviewAt = Field(
    'nextReviewAt',
    _$nextReviewAt,
  );
  static DateTime _$createdAt(Progress v) => v.createdAt;
  static const Field<Progress, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<Progress> fields = const {
    #language: _f$language,
    #stage: _f$stage,
    #level: _f$level,
    #intervalMinutes: _f$intervalMinutes,
    #ease: _f$ease,
    #nextReviewAt: _f$nextReviewAt,
    #createdAt: _f$createdAt,
  };

  static Progress _instantiate(DecodingData data) {
    return Progress(
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

  static Progress fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Progress>(map);
  }

  static Progress fromJson(String json) {
    return ensureInitialized().decodeJson<Progress>(json);
  }
}

mixin ProgressMappable {
  String toJson() {
    return ProgressMapper.ensureInitialized().encodeJson<Progress>(
      this as Progress,
    );
  }

  Map<String, dynamic> toMap() {
    return ProgressMapper.ensureInitialized().encodeMap<Progress>(
      this as Progress,
    );
  }

  ProgressCopyWith<Progress, Progress, Progress> get copyWith =>
      _ProgressCopyWithImpl<Progress, Progress>(
        this as Progress,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProgressMapper.ensureInitialized().stringifyValue(this as Progress);
  }

  @override
  bool operator ==(Object other) {
    return ProgressMapper.ensureInitialized().equalsValue(
      this as Progress,
      other,
    );
  }

  @override
  int get hashCode {
    return ProgressMapper.ensureInitialized().hashValue(this as Progress);
  }
}

extension ProgressValueCopy<$R, $Out> on ObjectCopyWith<$R, Progress, $Out> {
  ProgressCopyWith<$R, Progress, $Out> get $asProgress =>
      $base.as((v, t, t2) => _ProgressCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProgressCopyWith<$R, $In extends Progress, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Language? language,
    ProgressStage? stage,
    double? level,
    int? intervalMinutes,
    double? ease,
    DateTime? nextReviewAt,
    DateTime? createdAt,
  });
  ProgressCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProgressCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Progress, $Out>
    implements ProgressCopyWith<$R, Progress, $Out> {
  _ProgressCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Progress> $mapper =
      ProgressMapper.ensureInitialized();
  @override
  $R call({
    Language? language,
    ProgressStage? stage,
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
  Progress $make(CopyWithData data) => Progress(
    language: data.get(#language, or: $value.language),
    stage: data.get(#stage, or: $value.stage),
    level: data.get(#level, or: $value.level),
    intervalMinutes: data.get(#intervalMinutes, or: $value.intervalMinutes),
    ease: data.get(#ease, or: $value.ease),
    nextReviewAt: data.get(#nextReviewAt, or: $value.nextReviewAt),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  ProgressCopyWith<$R2, Progress, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProgressCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

