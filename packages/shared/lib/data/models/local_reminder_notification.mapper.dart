// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_reminder_notification.dart';

class LocalReminderNotificationMapper
    extends ClassMapperBase<LocalReminderNotification> {
  LocalReminderNotificationMapper._();

  static LocalReminderNotificationMapper? _instance;
  static LocalReminderNotificationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LocalReminderNotificationMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'LocalReminderNotification';

  static DateTime _$at(LocalReminderNotification v) => v.at;
  static const Field<LocalReminderNotification, DateTime> _f$at = Field(
    'at',
    _$at,
  );
  static String _$title(LocalReminderNotification v) => v.title;
  static const Field<LocalReminderNotification, String> _f$title = Field(
    'title',
    _$title,
  );
  static String _$body(LocalReminderNotification v) => v.body;
  static const Field<LocalReminderNotification, String> _f$body = Field(
    'body',
    _$body,
  );
  static String _$channelName(LocalReminderNotification v) => v.channelName;
  static const Field<LocalReminderNotification, String> _f$channelName = Field(
    'channelName',
    _$channelName,
  );

  @override
  final MappableFields<LocalReminderNotification> fields = const {
    #at: _f$at,
    #title: _f$title,
    #body: _f$body,
    #channelName: _f$channelName,
  };

  static LocalReminderNotification _instantiate(DecodingData data) {
    return LocalReminderNotification(
      at: data.dec(_f$at),
      title: data.dec(_f$title),
      body: data.dec(_f$body),
      channelName: data.dec(_f$channelName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalReminderNotification fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalReminderNotification>(map);
  }

  static LocalReminderNotification fromJson(String json) {
    return ensureInitialized().decodeJson<LocalReminderNotification>(json);
  }
}

mixin LocalReminderNotificationMappable {
  String toJson() {
    return LocalReminderNotificationMapper.ensureInitialized()
        .encodeJson<LocalReminderNotification>(
          this as LocalReminderNotification,
        );
  }

  Map<String, dynamic> toMap() {
    return LocalReminderNotificationMapper.ensureInitialized()
        .encodeMap<LocalReminderNotification>(
          this as LocalReminderNotification,
        );
  }

  LocalReminderNotificationCopyWith<
    LocalReminderNotification,
    LocalReminderNotification,
    LocalReminderNotification
  >
  get copyWith =>
      _LocalReminderNotificationCopyWithImpl<
        LocalReminderNotification,
        LocalReminderNotification
      >(this as LocalReminderNotification, $identity, $identity);
  @override
  String toString() {
    return LocalReminderNotificationMapper.ensureInitialized().stringifyValue(
      this as LocalReminderNotification,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalReminderNotificationMapper.ensureInitialized().equalsValue(
      this as LocalReminderNotification,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalReminderNotificationMapper.ensureInitialized().hashValue(
      this as LocalReminderNotification,
    );
  }
}

extension LocalReminderNotificationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalReminderNotification, $Out> {
  LocalReminderNotificationCopyWith<$R, LocalReminderNotification, $Out>
  get $asLocalReminderNotification => $base.as(
    (v, t, t2) => _LocalReminderNotificationCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalReminderNotificationCopyWith<
  $R,
  $In extends LocalReminderNotification,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({DateTime? at, String? title, String? body, String? channelName});
  LocalReminderNotificationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalReminderNotificationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalReminderNotification, $Out>
    implements
        LocalReminderNotificationCopyWith<$R, LocalReminderNotification, $Out> {
  _LocalReminderNotificationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalReminderNotification> $mapper =
      LocalReminderNotificationMapper.ensureInitialized();
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
  LocalReminderNotification $make(CopyWithData data) =>
      LocalReminderNotification(
        at: data.get(#at, or: $value.at),
        title: data.get(#title, or: $value.title),
        body: data.get(#body, or: $value.body),
        channelName: data.get(#channelName, or: $value.channelName),
      );

  @override
  LocalReminderNotificationCopyWith<$R2, LocalReminderNotification, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalReminderNotificationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

