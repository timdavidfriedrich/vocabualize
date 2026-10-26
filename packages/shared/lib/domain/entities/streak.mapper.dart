// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'streak.dart';

class StreakMapper extends ClassMapperBase<Streak> {
  StreakMapper._();

  static StreakMapper? _instance;
  static StreakMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StreakMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Streak';

  static int _$current(Streak v) => v.current;
  static const Field<Streak, int> _f$current = Field('current', _$current);
  static int _$longest(Streak v) => v.longest;
  static const Field<Streak, int> _f$longest = Field('longest', _$longest);
  static int _$freezes(Streak v) => v.freezes;
  static const Field<Streak, int> _f$freezes = Field('freezes', _$freezes);
  static int _$maxFreezes(Streak v) => v.maxFreezes;
  static const Field<Streak, int> _f$maxFreezes = Field(
    'maxFreezes',
    _$maxFreezes,
  );
  static int _$activeDaysPerFreeze(Streak v) => v.activeDaysPerFreeze;
  static const Field<Streak, int> _f$activeDaysPerFreeze = Field(
    'activeDaysPerFreeze',
    _$activeDaysPerFreeze,
  );
  static bool _$isTodayActive(Streak v) => v.isTodayActive;
  static const Field<Streak, bool> _f$isTodayActive = Field(
    'isTodayActive',
    _$isTodayActive,
  );
  static DateTime _$today(Streak v) => v.today;
  static const Field<Streak, DateTime> _f$today = Field('today', _$today);
  static Set<DateTime> _$activeDays(Streak v) => v.activeDays;
  static const Field<Streak, Set<DateTime>> _f$activeDays = Field(
    'activeDays',
    _$activeDays,
  );
  static Set<DateTime> _$frozenDays(Streak v) => v.frozenDays;
  static const Field<Streak, Set<DateTime>> _f$frozenDays = Field(
    'frozenDays',
    _$frozenDays,
  );

  @override
  final MappableFields<Streak> fields = const {
    #current: _f$current,
    #longest: _f$longest,
    #freezes: _f$freezes,
    #maxFreezes: _f$maxFreezes,
    #activeDaysPerFreeze: _f$activeDaysPerFreeze,
    #isTodayActive: _f$isTodayActive,
    #today: _f$today,
    #activeDays: _f$activeDays,
    #frozenDays: _f$frozenDays,
  };

  static Streak _instantiate(DecodingData data) {
    return Streak(
      current: data.dec(_f$current),
      longest: data.dec(_f$longest),
      freezes: data.dec(_f$freezes),
      maxFreezes: data.dec(_f$maxFreezes),
      activeDaysPerFreeze: data.dec(_f$activeDaysPerFreeze),
      isTodayActive: data.dec(_f$isTodayActive),
      today: data.dec(_f$today),
      activeDays: data.dec(_f$activeDays),
      frozenDays: data.dec(_f$frozenDays),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Streak fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Streak>(map);
  }

  static Streak fromJson(String json) {
    return ensureInitialized().decodeJson<Streak>(json);
  }
}

mixin StreakMappable {
  String toJson() {
    return StreakMapper.ensureInitialized().encodeJson<Streak>(this as Streak);
  }

  Map<String, dynamic> toMap() {
    return StreakMapper.ensureInitialized().encodeMap<Streak>(this as Streak);
  }

  StreakCopyWith<Streak, Streak, Streak> get copyWith =>
      _StreakCopyWithImpl<Streak, Streak>(this as Streak, $identity, $identity);
  @override
  String toString() {
    return StreakMapper.ensureInitialized().stringifyValue(this as Streak);
  }

  @override
  bool operator ==(Object other) {
    return StreakMapper.ensureInitialized().equalsValue(this as Streak, other);
  }

  @override
  int get hashCode {
    return StreakMapper.ensureInitialized().hashValue(this as Streak);
  }
}

extension StreakValueCopy<$R, $Out> on ObjectCopyWith<$R, Streak, $Out> {
  StreakCopyWith<$R, Streak, $Out> get $asStreak =>
      $base.as((v, t, t2) => _StreakCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StreakCopyWith<$R, $In extends Streak, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? current,
    int? longest,
    int? freezes,
    int? maxFreezes,
    int? activeDaysPerFreeze,
    bool? isTodayActive,
    DateTime? today,
    Set<DateTime>? activeDays,
    Set<DateTime>? frozenDays,
  });
  StreakCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StreakCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Streak, $Out>
    implements StreakCopyWith<$R, Streak, $Out> {
  _StreakCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Streak> $mapper = StreakMapper.ensureInitialized();
  @override
  $R call({
    int? current,
    int? longest,
    int? freezes,
    int? maxFreezes,
    int? activeDaysPerFreeze,
    bool? isTodayActive,
    DateTime? today,
    Set<DateTime>? activeDays,
    Set<DateTime>? frozenDays,
  }) => $apply(
    FieldCopyWithData({
      if (current != null) #current: current,
      if (longest != null) #longest: longest,
      if (freezes != null) #freezes: freezes,
      if (maxFreezes != null) #maxFreezes: maxFreezes,
      if (activeDaysPerFreeze != null)
        #activeDaysPerFreeze: activeDaysPerFreeze,
      if (isTodayActive != null) #isTodayActive: isTodayActive,
      if (today != null) #today: today,
      if (activeDays != null) #activeDays: activeDays,
      if (frozenDays != null) #frozenDays: frozenDays,
    }),
  );
  @override
  Streak $make(CopyWithData data) => Streak(
    current: data.get(#current, or: $value.current),
    longest: data.get(#longest, or: $value.longest),
    freezes: data.get(#freezes, or: $value.freezes),
    maxFreezes: data.get(#maxFreezes, or: $value.maxFreezes),
    activeDaysPerFreeze: data.get(
      #activeDaysPerFreeze,
      or: $value.activeDaysPerFreeze,
    ),
    isTodayActive: data.get(#isTodayActive, or: $value.isTodayActive),
    today: data.get(#today, or: $value.today),
    activeDays: data.get(#activeDays, or: $value.activeDays),
    frozenDays: data.get(#frozenDays, or: $value.frozenDays),
  );

  @override
  StreakCopyWith<$R2, Streak, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _StreakCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

