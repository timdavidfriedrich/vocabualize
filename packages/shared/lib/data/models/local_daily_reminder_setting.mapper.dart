// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_daily_reminder_setting.dart';

class LocalDailyReminderSettingMapper
    extends ClassMapperBase<LocalDailyReminderSetting> {
  LocalDailyReminderSettingMapper._();

  static LocalDailyReminderSettingMapper? _instance;
  static LocalDailyReminderSettingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LocalDailyReminderSettingMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'LocalDailyReminderSetting';

  static bool _$isEnabled(LocalDailyReminderSetting v) => v.isEnabled;
  static const Field<LocalDailyReminderSetting, bool> _f$isEnabled = Field(
    'isEnabled',
    _$isEnabled,
  );
  static int _$hour(LocalDailyReminderSetting v) => v.hour;
  static const Field<LocalDailyReminderSetting, int> _f$hour = Field(
    'hour',
    _$hour,
  );
  static int _$minute(LocalDailyReminderSetting v) => v.minute;
  static const Field<LocalDailyReminderSetting, int> _f$minute = Field(
    'minute',
    _$minute,
  );

  @override
  final MappableFields<LocalDailyReminderSetting> fields = const {
    #isEnabled: _f$isEnabled,
    #hour: _f$hour,
    #minute: _f$minute,
  };

  static LocalDailyReminderSetting _instantiate(DecodingData data) {
    return LocalDailyReminderSetting(
      isEnabled: data.dec(_f$isEnabled),
      hour: data.dec(_f$hour),
      minute: data.dec(_f$minute),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalDailyReminderSetting fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalDailyReminderSetting>(map);
  }

  static LocalDailyReminderSetting fromJson(String json) {
    return ensureInitialized().decodeJson<LocalDailyReminderSetting>(json);
  }
}

mixin LocalDailyReminderSettingMappable {
  String toJson() {
    return LocalDailyReminderSettingMapper.ensureInitialized()
        .encodeJson<LocalDailyReminderSetting>(
          this as LocalDailyReminderSetting,
        );
  }

  Map<String, dynamic> toMap() {
    return LocalDailyReminderSettingMapper.ensureInitialized()
        .encodeMap<LocalDailyReminderSetting>(
          this as LocalDailyReminderSetting,
        );
  }

  LocalDailyReminderSettingCopyWith<
    LocalDailyReminderSetting,
    LocalDailyReminderSetting,
    LocalDailyReminderSetting
  >
  get copyWith =>
      _LocalDailyReminderSettingCopyWithImpl<
        LocalDailyReminderSetting,
        LocalDailyReminderSetting
      >(this as LocalDailyReminderSetting, $identity, $identity);
  @override
  String toString() {
    return LocalDailyReminderSettingMapper.ensureInitialized().stringifyValue(
      this as LocalDailyReminderSetting,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalDailyReminderSettingMapper.ensureInitialized().equalsValue(
      this as LocalDailyReminderSetting,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalDailyReminderSettingMapper.ensureInitialized().hashValue(
      this as LocalDailyReminderSetting,
    );
  }
}

extension LocalDailyReminderSettingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalDailyReminderSetting, $Out> {
  LocalDailyReminderSettingCopyWith<$R, LocalDailyReminderSetting, $Out>
  get $asLocalDailyReminderSetting => $base.as(
    (v, t, t2) => _LocalDailyReminderSettingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalDailyReminderSettingCopyWith<
  $R,
  $In extends LocalDailyReminderSetting,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? isEnabled, int? hour, int? minute});
  LocalDailyReminderSettingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalDailyReminderSettingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalDailyReminderSetting, $Out>
    implements
        LocalDailyReminderSettingCopyWith<$R, LocalDailyReminderSetting, $Out> {
  _LocalDailyReminderSettingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalDailyReminderSetting> $mapper =
      LocalDailyReminderSettingMapper.ensureInitialized();
  @override
  $R call({bool? isEnabled, int? hour, int? minute}) => $apply(
    FieldCopyWithData({
      if (isEnabled != null) #isEnabled: isEnabled,
      if (hour != null) #hour: hour,
      if (minute != null) #minute: minute,
    }),
  );
  @override
  LocalDailyReminderSetting $make(CopyWithData data) =>
      LocalDailyReminderSetting(
        isEnabled: data.get(#isEnabled, or: $value.isEnabled),
        hour: data.get(#hour, or: $value.hour),
        minute: data.get(#minute, or: $value.minute),
      );

  @override
  LocalDailyReminderSettingCopyWith<$R2, LocalDailyReminderSetting, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalDailyReminderSettingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

