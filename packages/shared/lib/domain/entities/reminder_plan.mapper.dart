// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'reminder_plan.dart';

class ReminderPlanMapper extends ClassMapperBase<ReminderPlan> {
  ReminderPlanMapper._();

  static ReminderPlanMapper? _instance;
  static ReminderPlanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReminderPlanMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ReminderPlan';

  static bool _$isPermitted(ReminderPlan v) => v.isPermitted;
  static const Field<ReminderPlan, bool> _f$isPermitted = Field(
    'isPermitted',
    _$isPermitted,
  );
  static List<DateTime>? _$practiceTimes(ReminderPlan v) => v.practiceTimes;
  static const Field<ReminderPlan, List<DateTime>> _f$practiceTimes = Field(
    'practiceTimes',
    _$practiceTimes,
  );
  static List<DateTime>? _$streakTimes(ReminderPlan v) => v.streakTimes;
  static const Field<ReminderPlan, List<DateTime>> _f$streakTimes = Field(
    'streakTimes',
    _$streakTimes,
  );
  static int _$streakCount(ReminderPlan v) => v.streakCount;
  static const Field<ReminderPlan, int> _f$streakCount = Field(
    'streakCount',
    _$streakCount,
  );

  @override
  final MappableFields<ReminderPlan> fields = const {
    #isPermitted: _f$isPermitted,
    #practiceTimes: _f$practiceTimes,
    #streakTimes: _f$streakTimes,
    #streakCount: _f$streakCount,
  };

  static ReminderPlan _instantiate(DecodingData data) {
    return ReminderPlan(
      isPermitted: data.dec(_f$isPermitted),
      practiceTimes: data.dec(_f$practiceTimes),
      streakTimes: data.dec(_f$streakTimes),
      streakCount: data.dec(_f$streakCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ReminderPlan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReminderPlan>(map);
  }

  static ReminderPlan fromJson(String json) {
    return ensureInitialized().decodeJson<ReminderPlan>(json);
  }
}

mixin ReminderPlanMappable {
  String toJson() {
    return ReminderPlanMapper.ensureInitialized().encodeJson<ReminderPlan>(
      this as ReminderPlan,
    );
  }

  Map<String, dynamic> toMap() {
    return ReminderPlanMapper.ensureInitialized().encodeMap<ReminderPlan>(
      this as ReminderPlan,
    );
  }

  ReminderPlanCopyWith<ReminderPlan, ReminderPlan, ReminderPlan> get copyWith =>
      _ReminderPlanCopyWithImpl<ReminderPlan, ReminderPlan>(
        this as ReminderPlan,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ReminderPlanMapper.ensureInitialized().stringifyValue(
      this as ReminderPlan,
    );
  }

  @override
  bool operator ==(Object other) {
    return ReminderPlanMapper.ensureInitialized().equalsValue(
      this as ReminderPlan,
      other,
    );
  }

  @override
  int get hashCode {
    return ReminderPlanMapper.ensureInitialized().hashValue(
      this as ReminderPlan,
    );
  }
}

extension ReminderPlanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReminderPlan, $Out> {
  ReminderPlanCopyWith<$R, ReminderPlan, $Out> get $asReminderPlan =>
      $base.as((v, t, t2) => _ReminderPlanCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ReminderPlanCopyWith<$R, $In extends ReminderPlan, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>?
  get practiceTimes;
  ListCopyWith<$R, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>?
  get streakTimes;
  $R call({
    bool? isPermitted,
    List<DateTime>? practiceTimes,
    List<DateTime>? streakTimes,
    int? streakCount,
  });
  ReminderPlanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReminderPlanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReminderPlan, $Out>
    implements ReminderPlanCopyWith<$R, ReminderPlan, $Out> {
  _ReminderPlanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReminderPlan> $mapper =
      ReminderPlanMapper.ensureInitialized();
  @override
  ListCopyWith<$R, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>?
  get practiceTimes => $value.practiceTimes != null
      ? ListCopyWith(
          $value.practiceTimes!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(practiceTimes: v),
        )
      : null;
  @override
  ListCopyWith<$R, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>?
  get streakTimes => $value.streakTimes != null
      ? ListCopyWith(
          $value.streakTimes!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(streakTimes: v),
        )
      : null;
  @override
  $R call({
    bool? isPermitted,
    Object? practiceTimes = $none,
    Object? streakTimes = $none,
    int? streakCount,
  }) => $apply(
    FieldCopyWithData({
      if (isPermitted != null) #isPermitted: isPermitted,
      if (practiceTimes != $none) #practiceTimes: practiceTimes,
      if (streakTimes != $none) #streakTimes: streakTimes,
      if (streakCount != null) #streakCount: streakCount,
    }),
  );
  @override
  ReminderPlan $make(CopyWithData data) => ReminderPlan(
    isPermitted: data.get(#isPermitted, or: $value.isPermitted),
    practiceTimes: data.get(#practiceTimes, or: $value.practiceTimes),
    streakTimes: data.get(#streakTimes, or: $value.streakTimes),
    streakCount: data.get(#streakCount, or: $value.streakCount),
  );

  @override
  ReminderPlanCopyWith<$R2, ReminderPlan, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ReminderPlanCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

