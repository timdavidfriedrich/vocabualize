// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_practice_reminder_setting.dart';

class LocalPracticeReminderSettingMapper
    extends ClassMapperBase<LocalPracticeReminderSetting> {
  LocalPracticeReminderSettingMapper._();

  static LocalPracticeReminderSettingMapper? _instance;
  static LocalPracticeReminderSettingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LocalPracticeReminderSettingMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'LocalPracticeReminderSetting';

  static bool _$isEnabled(LocalPracticeReminderSetting v) => v.isEnabled;
  static const Field<LocalPracticeReminderSetting, bool> _f$isEnabled = Field(
    'isEnabled',
    _$isEnabled,
  );
  static int _$hour(LocalPracticeReminderSetting v) => v.hour;
  static const Field<LocalPracticeReminderSetting, int> _f$hour = Field(
    'hour',
    _$hour,
  );
  static int _$minute(LocalPracticeReminderSetting v) => v.minute;
  static const Field<LocalPracticeReminderSetting, int> _f$minute = Field(
    'minute',
    _$minute,
  );

  @override
  final MappableFields<LocalPracticeReminderSetting> fields = const {
    #isEnabled: _f$isEnabled,
    #hour: _f$hour,
    #minute: _f$minute,
  };

  static LocalPracticeReminderSetting _instantiate(DecodingData data) {
    return LocalPracticeReminderSetting(
      isEnabled: data.dec(_f$isEnabled),
      hour: data.dec(_f$hour),
      minute: data.dec(_f$minute),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalPracticeReminderSetting fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalPracticeReminderSetting>(map);
  }

  static LocalPracticeReminderSetting fromJson(String json) {
    return ensureInitialized().decodeJson<LocalPracticeReminderSetting>(json);
  }
}

mixin LocalPracticeReminderSettingMappable {
  String toJson() {
    return LocalPracticeReminderSettingMapper.ensureInitialized()
        .encodeJson<LocalPracticeReminderSetting>(
          this as LocalPracticeReminderSetting,
        );
  }

  Map<String, dynamic> toMap() {
    return LocalPracticeReminderSettingMapper.ensureInitialized()
        .encodeMap<LocalPracticeReminderSetting>(
          this as LocalPracticeReminderSetting,
        );
  }

  LocalPracticeReminderSettingCopyWith<
    LocalPracticeReminderSetting,
    LocalPracticeReminderSetting,
    LocalPracticeReminderSetting
  >
  get copyWith =>
      _LocalPracticeReminderSettingCopyWithImpl<
        LocalPracticeReminderSetting,
        LocalPracticeReminderSetting
      >(this as LocalPracticeReminderSetting, $identity, $identity);
  @override
  String toString() {
    return LocalPracticeReminderSettingMapper.ensureInitialized()
        .stringifyValue(this as LocalPracticeReminderSetting);
  }

  @override
  bool operator ==(Object other) {
    return LocalPracticeReminderSettingMapper.ensureInitialized().equalsValue(
      this as LocalPracticeReminderSetting,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalPracticeReminderSettingMapper.ensureInitialized().hashValue(
      this as LocalPracticeReminderSetting,
    );
  }
}

extension LocalPracticeReminderSettingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalPracticeReminderSetting, $Out> {
  LocalPracticeReminderSettingCopyWith<$R, LocalPracticeReminderSetting, $Out>
  get $asLocalPracticeReminderSetting => $base.as(
    (v, t, t2) => _LocalPracticeReminderSettingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalPracticeReminderSettingCopyWith<
  $R,
  $In extends LocalPracticeReminderSetting,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? isEnabled, int? hour, int? minute});
  LocalPracticeReminderSettingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalPracticeReminderSettingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalPracticeReminderSetting, $Out>
    implements
        LocalPracticeReminderSettingCopyWith<
          $R,
          LocalPracticeReminderSetting,
          $Out
        > {
  _LocalPracticeReminderSettingCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<LocalPracticeReminderSetting> $mapper =
      LocalPracticeReminderSettingMapper.ensureInitialized();
  @override
  $R call({bool? isEnabled, int? hour, int? minute}) => $apply(
    FieldCopyWithData({
      if (isEnabled != null) #isEnabled: isEnabled,
      if (hour != null) #hour: hour,
      if (minute != null) #minute: minute,
    }),
  );
  @override
  LocalPracticeReminderSetting $make(CopyWithData data) =>
      LocalPracticeReminderSetting(
        isEnabled: data.get(#isEnabled, or: $value.isEnabled),
        hour: data.get(#hour, or: $value.hour),
        minute: data.get(#minute, or: $value.minute),
      );

  @override
  LocalPracticeReminderSettingCopyWith<$R2, LocalPracticeReminderSetting, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalPracticeReminderSettingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

