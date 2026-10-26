// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'reminder_notification.dart';

class ReminderNotificationMapper extends ClassMapperBase<ReminderNotification> {
  ReminderNotificationMapper._();

  static ReminderNotificationMapper? _instance;
  static ReminderNotificationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReminderNotificationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ReminderNotification';

  static DateTime _$at(ReminderNotification v) => v.at;
  static const Field<ReminderNotification, DateTime> _f$at = Field('at', _$at);
  static String _$title(ReminderNotification v) => v.title;
  static const Field<ReminderNotification, String> _f$title = Field(
    'title',
    _$title,
  );
  static String _$body(ReminderNotification v) => v.body;
  static const Field<ReminderNotification, String> _f$body = Field(
    'body',
    _$body,
  );
  static String _$channelName(ReminderNotification v) => v.channelName;
  static const Field<ReminderNotification, String> _f$channelName = Field(
    'channelName',
    _$channelName,
  );

  @override
  final MappableFields<ReminderNotification> fields = const {
    #at: _f$at,
    #title: _f$title,
    #body: _f$body,
    #channelName: _f$channelName,
  };

  static ReminderNotification _instantiate(DecodingData data) {
    return ReminderNotification(
      at: data.dec(_f$at),
      title: data.dec(_f$title),
      body: data.dec(_f$body),
      channelName: data.dec(_f$channelName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ReminderNotification fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReminderNotification>(map);
  }

  static ReminderNotification fromJson(String json) {
    return ensureInitialized().decodeJson<ReminderNotification>(json);
  }
}

mixin ReminderNotificationMappable {
  String toJson() {
    return ReminderNotificationMapper.ensureInitialized()
        .encodeJson<ReminderNotification>(this as ReminderNotification);
  }

  Map<String, dynamic> toMap() {
    return ReminderNotificationMapper.ensureInitialized()
        .encodeMap<ReminderNotification>(this as ReminderNotification);
  }

  ReminderNotificationCopyWith<
    ReminderNotification,
    ReminderNotification,
    ReminderNotification
  >
  get copyWith =>
      _ReminderNotificationCopyWithImpl<
        ReminderNotification,
        ReminderNotification
      >(this as ReminderNotification, $identity, $identity);
  @override
  String toString() {
    return ReminderNotificationMapper.ensureInitialized().stringifyValue(
      this as ReminderNotification,
    );
  }

  @override
  bool operator ==(Object other) {
    return ReminderNotificationMapper.ensureInitialized().equalsValue(
      this as ReminderNotification,
      other,
    );
  }

  @override
  int get hashCode {
    return ReminderNotificationMapper.ensureInitialized().hashValue(
      this as ReminderNotification,
    );
  }
}

extension ReminderNotificationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReminderNotification, $Out> {
  ReminderNotificationCopyWith<$R, ReminderNotification, $Out>
  get $asReminderNotification => $base.as(
    (v, t, t2) => _ReminderNotificationCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ReminderNotificationCopyWith<
  $R,
  $In extends ReminderNotification,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({DateTime? at, String? title, String? body, String? channelName});
  ReminderNotificationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ReminderNotificationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReminderNotification, $Out>
    implements ReminderNotificationCopyWith<$R, ReminderNotification, $Out> {
  _ReminderNotificationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReminderNotification> $mapper =
      ReminderNotificationMapper.ensureInitialized();
  @override
  $R call({DateTime? at, String? title, String? body, String? channelName}) =>
      $apply(
        FieldCopyWithData({
          if (at != null) #at: at,
          if (title != null) #title: title,
          if (body != null) #body: body,
          if (channelName != null) #channelName: channelName,
        }),
      );
  @override
  ReminderNotification $make(CopyWithData data) => ReminderNotification(
    at: data.get(#at, or: $value.at),
    title: data.get(#title, or: $value.title),
    body: data.get(#body, or: $value.body),
    channelName: data.get(#channelName, or: $value.channelName),
  );

  @override
  ReminderNotificationCopyWith<$R2, ReminderNotification, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ReminderNotificationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

