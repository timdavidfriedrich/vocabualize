// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'preferences.dart';

class PreferencesMapper extends ClassMapperBase<Preferences> {
  PreferencesMapper._();

  static PreferencesMapper? _instance;
  static PreferencesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PreferencesMapper._());
      DailyReminderMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Preferences';

  static bool _$isTypeAnswerDisabled(Preferences v) => v.isTypeAnswerDisabled;
  static const Field<Preferences, bool> _f$isTypeAnswerDisabled = Field(
    'isTypeAnswerDisabled',
    _$isTypeAnswerDisabled,
  );
  static bool _$isStrictCorrectionEnabled(Preferences v) =>
      v.isStrictCorrectionEnabled;
  static const Field<Preferences, bool> _f$isStrictCorrectionEnabled = Field(
    'isStrictCorrectionEnabled',
    _$isStrictCorrectionEnabled,
  );
  static bool _$areImagesHidden(Preferences v) => v.areImagesHidden;
  static const Field<Preferences, bool> _f$areImagesHidden = Field(
    'areImagesHidden',
    _$areImagesHidden,
  );
  static AppearanceMode _$appearanceMode(Preferences v) => v.appearanceMode;
  static const Field<Preferences, AppearanceMode> _f$appearanceMode = Field(
    'appearanceMode',
    _$appearanceMode,
  );
  static DailyReminder _$practiceReminder(Preferences v) => v.practiceReminder;
  static const Field<Preferences, DailyReminder> _f$practiceReminder = Field(
    'practiceReminder',
    _$practiceReminder,
  );
  static DailyReminder _$streakReminder(Preferences v) => v.streakReminder;
  static const Field<Preferences, DailyReminder> _f$streakReminder = Field(
    'streakReminder',
    _$streakReminder,
  );

  @override
  final MappableFields<Preferences> fields = const {
    #isTypeAnswerDisabled: _f$isTypeAnswerDisabled,
    #isStrictCorrectionEnabled: _f$isStrictCorrectionEnabled,
    #areImagesHidden: _f$areImagesHidden,
    #appearanceMode: _f$appearanceMode,
    #practiceReminder: _f$practiceReminder,
    #streakReminder: _f$streakReminder,
  };

  static Preferences _instantiate(DecodingData data) {
    return Preferences(
      isTypeAnswerDisabled: data.dec(_f$isTypeAnswerDisabled),
      isStrictCorrectionEnabled: data.dec(_f$isStrictCorrectionEnabled),
      areImagesHidden: data.dec(_f$areImagesHidden),
      appearanceMode: data.dec(_f$appearanceMode),
      practiceReminder: data.dec(_f$practiceReminder),
      streakReminder: data.dec(_f$streakReminder),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Preferences fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Preferences>(map);
  }

  static Preferences fromJson(String json) {
    return ensureInitialized().decodeJson<Preferences>(json);
  }
}

mixin PreferencesMappable {
  String toJson() {
    return PreferencesMapper.ensureInitialized().encodeJson<Preferences>(
      this as Preferences,
    );
  }

  Map<String, dynamic> toMap() {
    return PreferencesMapper.ensureInitialized().encodeMap<Preferences>(
      this as Preferences,
    );
  }

  PreferencesCopyWith<Preferences, Preferences, Preferences> get copyWith =>
      _PreferencesCopyWithImpl<Preferences, Preferences>(
        this as Preferences,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PreferencesMapper.ensureInitialized().stringifyValue(
      this as Preferences,
    );
  }

  @override
  bool operator ==(Object other) {
    return PreferencesMapper.ensureInitialized().equalsValue(
      this as Preferences,
      other,
    );
  }

  @override
  int get hashCode {
    return PreferencesMapper.ensureInitialized().hashValue(this as Preferences);
  }
}

extension PreferencesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Preferences, $Out> {
  PreferencesCopyWith<$R, Preferences, $Out> get $asPreferences =>
      $base.as((v, t, t2) => _PreferencesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PreferencesCopyWith<$R, $In extends Preferences, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  DailyReminderCopyWith<$R, DailyReminder, DailyReminder> get practiceReminder;
  DailyReminderCopyWith<$R, DailyReminder, DailyReminder> get streakReminder;
  $R call({
    bool? isTypeAnswerDisabled,
    bool? isStrictCorrectionEnabled,
    bool? areImagesHidden,
    AppearanceMode? appearanceMode,
    DailyReminder? practiceReminder,
    DailyReminder? streakReminder,
  });
  PreferencesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PreferencesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Preferences, $Out>
    implements PreferencesCopyWith<$R, Preferences, $Out> {
  _PreferencesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Preferences> $mapper =
      PreferencesMapper.ensureInitialized();
  @override
  DailyReminderCopyWith<$R, DailyReminder, DailyReminder>
  get practiceReminder =>
      $value.practiceReminder.copyWith.$chain((v) => call(practiceReminder: v));
  @override
  DailyReminderCopyWith<$R, DailyReminder, DailyReminder> get streakReminder =>
      $value.streakReminder.copyWith.$chain((v) => call(streakReminder: v));
  @override
  $R call({
    bool? isTypeAnswerDisabled,
    bool? isStrictCorrectionEnabled,
    bool? areImagesHidden,
    AppearanceMode? appearanceMode,
    DailyReminder? practiceReminder,
    DailyReminder? streakReminder,
  }) => $apply(
    FieldCopyWithData({
      if (isTypeAnswerDisabled != null)
        #isTypeAnswerDisabled: isTypeAnswerDisabled,
      if (isStrictCorrectionEnabled != null)
        #isStrictCorrectionEnabled: isStrictCorrectionEnabled,
      if (areImagesHidden != null) #areImagesHidden: areImagesHidden,
      if (appearanceMode != null) #appearanceMode: appearanceMode,
      if (practiceReminder != null) #practiceReminder: practiceReminder,
      if (streakReminder != null) #streakReminder: streakReminder,
    }),
  );
  @override
  Preferences $make(CopyWithData data) => Preferences(
    isTypeAnswerDisabled: data.get(
      #isTypeAnswerDisabled,
      or: $value.isTypeAnswerDisabled,
    ),
    isStrictCorrectionEnabled: data.get(
      #isStrictCorrectionEnabled,
      or: $value.isStrictCorrectionEnabled,
    ),
    areImagesHidden: data.get(#areImagesHidden, or: $value.areImagesHidden),
    appearanceMode: data.get(#appearanceMode, or: $value.appearanceMode),
    practiceReminder: data.get(#practiceReminder, or: $value.practiceReminder),
    streakReminder: data.get(#streakReminder, or: $value.streakReminder),
  );

  @override
  PreferencesCopyWith<$R2, Preferences, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PreferencesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DailyReminderMapper extends ClassMapperBase<DailyReminder> {
  DailyReminderMapper._();

  static DailyReminderMapper? _instance;
  static DailyReminderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DailyReminderMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DailyReminder';

  static bool _$isEnabled(DailyReminder v) => v.isEnabled;
  static const Field<DailyReminder, bool> _f$isEnabled = Field(
    'isEnabled',
    _$isEnabled,
  );
  static int _$hour(DailyReminder v) => v.hour;
  static const Field<DailyReminder, int> _f$hour = Field('hour', _$hour);
  static int _$minute(DailyReminder v) => v.minute;
  static const Field<DailyReminder, int> _f$minute = Field('minute', _$minute);

  @override
  final MappableFields<DailyReminder> fields = const {
    #isEnabled: _f$isEnabled,
    #hour: _f$hour,
    #minute: _f$minute,
  };

  static DailyReminder _instantiate(DecodingData data) {
    return DailyReminder(
      isEnabled: data.dec(_f$isEnabled),
      hour: data.dec(_f$hour),
      minute: data.dec(_f$minute),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DailyReminder fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DailyReminder>(map);
  }

  static DailyReminder fromJson(String json) {
    return ensureInitialized().decodeJson<DailyReminder>(json);
  }
}

mixin DailyReminderMappable {
  String toJson() {
    return DailyReminderMapper.ensureInitialized().encodeJson<DailyReminder>(
      this as DailyReminder,
    );
  }

  Map<String, dynamic> toMap() {
    return DailyReminderMapper.ensureInitialized().encodeMap<DailyReminder>(
      this as DailyReminder,
    );
  }

  DailyReminderCopyWith<DailyReminder, DailyReminder, DailyReminder>
  get copyWith => _DailyReminderCopyWithImpl<DailyReminder, DailyReminder>(
    this as DailyReminder,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DailyReminderMapper.ensureInitialized().stringifyValue(
      this as DailyReminder,
    );
  }

  @override
  bool operator ==(Object other) {
    return DailyReminderMapper.ensureInitialized().equalsValue(
      this as DailyReminder,
      other,
    );
  }

  @override
  int get hashCode {
    return DailyReminderMapper.ensureInitialized().hashValue(
      this as DailyReminder,
    );
  }
}

extension DailyReminderValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DailyReminder, $Out> {
  DailyReminderCopyWith<$R, DailyReminder, $Out> get $asDailyReminder =>
      $base.as((v, t, t2) => _DailyReminderCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DailyReminderCopyWith<$R, $In extends DailyReminder, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? isEnabled, int? hour, int? minute});
  DailyReminderCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DailyReminderCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DailyReminder, $Out>
    implements DailyReminderCopyWith<$R, DailyReminder, $Out> {
  _DailyReminderCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DailyReminder> $mapper =
      DailyReminderMapper.ensureInitialized();
  @override
  $R call({bool? isEnabled, int? hour, int? minute}) => $apply(
    FieldCopyWithData({
      if (isEnabled != null) #isEnabled: isEnabled,
      if (hour != null) #hour: hour,
      if (minute != null) #minute: minute,
    }),
  );
  @override
  DailyReminder $make(CopyWithData data) => DailyReminder(
    isEnabled: data.get(#isEnabled, or: $value.isEnabled),
    hour: data.get(#hour, or: $value.hour),
    minute: data.get(#minute, or: $value.minute),
  );

  @override
  DailyReminderCopyWith<$R2, DailyReminder, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DailyReminderCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

