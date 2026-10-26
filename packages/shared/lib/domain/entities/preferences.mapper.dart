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
      PracticeReminderMapper.ensureInitialized();
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
  static bool _$areImagesHidden(Preferences v) => v.areImagesHidden;
  static const Field<Preferences, bool> _f$areImagesHidden = Field(
    'areImagesHidden',
    _$areImagesHidden,
  );
  static PracticeReminder _$practiceReminder(Preferences v) =>
      v.practiceReminder;
  static const Field<Preferences, PracticeReminder> _f$practiceReminder = Field(
    'practiceReminder',
    _$practiceReminder,
  );

  @override
  final MappableFields<Preferences> fields = const {
    #isTypeAnswerDisabled: _f$isTypeAnswerDisabled,
    #areImagesHidden: _f$areImagesHidden,
    #practiceReminder: _f$practiceReminder,
  };

  static Preferences _instantiate(DecodingData data) {
    return Preferences(
      isTypeAnswerDisabled: data.dec(_f$isTypeAnswerDisabled),
      areImagesHidden: data.dec(_f$areImagesHidden),
      practiceReminder: data.dec(_f$practiceReminder),
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
  PracticeReminderCopyWith<$R, PracticeReminder, PracticeReminder>
  get practiceReminder;
  $R call({
    bool? isTypeAnswerDisabled,
    bool? areImagesHidden,
    PracticeReminder? practiceReminder,
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
  PracticeReminderCopyWith<$R, PracticeReminder, PracticeReminder>
  get practiceReminder =>
      $value.practiceReminder.copyWith.$chain((v) => call(practiceReminder: v));
  @override
  $R call({
    bool? isTypeAnswerDisabled,
    bool? areImagesHidden,
    PracticeReminder? practiceReminder,
  }) => $apply(
    FieldCopyWithData({
      if (isTypeAnswerDisabled != null)
        #isTypeAnswerDisabled: isTypeAnswerDisabled,
      if (areImagesHidden != null) #areImagesHidden: areImagesHidden,
      if (practiceReminder != null) #practiceReminder: practiceReminder,
    }),
  );
  @override
  Preferences $make(CopyWithData data) => Preferences(
    isTypeAnswerDisabled: data.get(
      #isTypeAnswerDisabled,
      or: $value.isTypeAnswerDisabled,
    ),
    areImagesHidden: data.get(#areImagesHidden, or: $value.areImagesHidden),
    practiceReminder: data.get(#practiceReminder, or: $value.practiceReminder),
  );

  @override
  PreferencesCopyWith<$R2, Preferences, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PreferencesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PracticeReminderMapper extends ClassMapperBase<PracticeReminder> {
  PracticeReminderMapper._();

  static PracticeReminderMapper? _instance;
  static PracticeReminderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PracticeReminderMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PracticeReminder';

  static bool _$isEnabled(PracticeReminder v) => v.isEnabled;
  static const Field<PracticeReminder, bool> _f$isEnabled = Field(
    'isEnabled',
    _$isEnabled,
  );
  static int _$hour(PracticeReminder v) => v.hour;
  static const Field<PracticeReminder, int> _f$hour = Field('hour', _$hour);
  static int _$minute(PracticeReminder v) => v.minute;
  static const Field<PracticeReminder, int> _f$minute = Field(
    'minute',
    _$minute,
  );

  @override
  final MappableFields<PracticeReminder> fields = const {
    #isEnabled: _f$isEnabled,
    #hour: _f$hour,
    #minute: _f$minute,
  };

  static PracticeReminder _instantiate(DecodingData data) {
    return PracticeReminder(
      isEnabled: data.dec(_f$isEnabled),
      hour: data.dec(_f$hour),
      minute: data.dec(_f$minute),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PracticeReminder fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PracticeReminder>(map);
  }

  static PracticeReminder fromJson(String json) {
    return ensureInitialized().decodeJson<PracticeReminder>(json);
  }
}

mixin PracticeReminderMappable {
  String toJson() {
    return PracticeReminderMapper.ensureInitialized()
        .encodeJson<PracticeReminder>(this as PracticeReminder);
  }

  Map<String, dynamic> toMap() {
    return PracticeReminderMapper.ensureInitialized()
        .encodeMap<PracticeReminder>(this as PracticeReminder);
  }

  PracticeReminderCopyWith<PracticeReminder, PracticeReminder, PracticeReminder>
  get copyWith =>
      _PracticeReminderCopyWithImpl<PracticeReminder, PracticeReminder>(
        this as PracticeReminder,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PracticeReminderMapper.ensureInitialized().stringifyValue(
      this as PracticeReminder,
    );
  }

  @override
  bool operator ==(Object other) {
    return PracticeReminderMapper.ensureInitialized().equalsValue(
      this as PracticeReminder,
      other,
    );
  }

  @override
  int get hashCode {
    return PracticeReminderMapper.ensureInitialized().hashValue(
      this as PracticeReminder,
    );
  }
}

extension PracticeReminderValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PracticeReminder, $Out> {
  PracticeReminderCopyWith<$R, PracticeReminder, $Out>
  get $asPracticeReminder =>
      $base.as((v, t, t2) => _PracticeReminderCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PracticeReminderCopyWith<$R, $In extends PracticeReminder, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? isEnabled, int? hour, int? minute});
  PracticeReminderCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PracticeReminderCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PracticeReminder, $Out>
    implements PracticeReminderCopyWith<$R, PracticeReminder, $Out> {
  _PracticeReminderCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PracticeReminder> $mapper =
      PracticeReminderMapper.ensureInitialized();
  @override
  $R call({bool? isEnabled, int? hour, int? minute}) => $apply(
    FieldCopyWithData({
      if (isEnabled != null) #isEnabled: isEnabled,
      if (hour != null) #hour: hour,
      if (minute != null) #minute: minute,
    }),
  );
  @override
  PracticeReminder $make(CopyWithData data) => PracticeReminder(
    isEnabled: data.get(#isEnabled, or: $value.isEnabled),
    hour: data.get(#hour, or: $value.hour),
    minute: data.get(#minute, or: $value.minute),
  );

  @override
  PracticeReminderCopyWith<$R2, PracticeReminder, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PracticeReminderCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

