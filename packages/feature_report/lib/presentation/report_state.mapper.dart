// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'report_state.dart';

class ReportStateMapper extends ClassMapperBase<ReportState> {
  ReportStateMapper._();

  static ReportStateMapper? _instance;
  static ReportStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReportStateMapper._());
      ReportEditingMapper.ensureInitialized();
      ReportSentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ReportState';

  @override
  final MappableFields<ReportState> fields = const {};

  static ReportState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('ReportState');
  }

  @override
  final Function instantiate = _instantiate;

  static ReportState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReportState>(map);
  }

  static ReportState fromJson(String json) {
    return ensureInitialized().decodeJson<ReportState>(json);
  }
}

mixin ReportStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ReportStateCopyWith<ReportState, ReportState, ReportState> get copyWith;
}

abstract class ReportStateCopyWith<$R, $In extends ReportState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  ReportStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ReportEditingMapper extends ClassMapperBase<ReportEditing> {
  ReportEditingMapper._();

  static ReportEditingMapper? _instance;
  static ReportEditingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReportEditingMapper._());
      ReportStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ReportEditing';

  static bool _$isSending(ReportEditing v) => v.isSending;
  static const Field<ReportEditing, bool> _f$isSending = Field(
    'isSending',
    _$isSending,
  );
  static AppError? _$error(ReportEditing v) => v.error;
  static const Field<ReportEditing, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<ReportEditing> fields = const {
    #isSending: _f$isSending,
    #error: _f$error,
  };

  static ReportEditing _instantiate(DecodingData data) {
    return ReportEditing(
      isSending: data.dec(_f$isSending),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ReportEditing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReportEditing>(map);
  }

  static ReportEditing fromJson(String json) {
    return ensureInitialized().decodeJson<ReportEditing>(json);
  }
}

mixin ReportEditingMappable {
  String toJson() {
    return ReportEditingMapper.ensureInitialized().encodeJson<ReportEditing>(
      this as ReportEditing,
    );
  }

  Map<String, dynamic> toMap() {
    return ReportEditingMapper.ensureInitialized().encodeMap<ReportEditing>(
      this as ReportEditing,
    );
  }

  ReportEditingCopyWith<ReportEditing, ReportEditing, ReportEditing>
  get copyWith => _ReportEditingCopyWithImpl<ReportEditing, ReportEditing>(
    this as ReportEditing,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ReportEditingMapper.ensureInitialized().stringifyValue(
      this as ReportEditing,
    );
  }

  @override
  bool operator ==(Object other) {
    return ReportEditingMapper.ensureInitialized().equalsValue(
      this as ReportEditing,
      other,
    );
  }

  @override
  int get hashCode {
    return ReportEditingMapper.ensureInitialized().hashValue(
      this as ReportEditing,
    );
  }
}

extension ReportEditingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReportEditing, $Out> {
  ReportEditingCopyWith<$R, ReportEditing, $Out> get $asReportEditing =>
      $base.as((v, t, t2) => _ReportEditingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ReportEditingCopyWith<$R, $In extends ReportEditing, $Out>
    implements ReportStateCopyWith<$R, $In, $Out> {
  @override
  $R call({bool? isSending, AppError? error});
  ReportEditingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReportEditingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReportEditing, $Out>
    implements ReportEditingCopyWith<$R, ReportEditing, $Out> {
  _ReportEditingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReportEditing> $mapper =
      ReportEditingMapper.ensureInitialized();
  @override
  $R call({bool? isSending, Object? error = $none}) => $apply(
    FieldCopyWithData({
      if (isSending != null) #isSending: isSending,
      if (error != $none) #error: error,
    }),
  );
  @override
  ReportEditing $make(CopyWithData data) => ReportEditing(
    isSending: data.get(#isSending, or: $value.isSending),
    error: data.get(#error, or: $value.error),
  );

  @override
  ReportEditingCopyWith<$R2, ReportEditing, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ReportEditingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ReportSentMapper extends ClassMapperBase<ReportSent> {
  ReportSentMapper._();

  static ReportSentMapper? _instance;
  static ReportSentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReportSentMapper._());
      ReportStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ReportSent';

  @override
  final MappableFields<ReportSent> fields = const {};

  static ReportSent _instantiate(DecodingData data) {
    return ReportSent();
  }

  @override
  final Function instantiate = _instantiate;

  static ReportSent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReportSent>(map);
  }

  static ReportSent fromJson(String json) {
    return ensureInitialized().decodeJson<ReportSent>(json);
  }
}

mixin ReportSentMappable {
  String toJson() {
    return ReportSentMapper.ensureInitialized().encodeJson<ReportSent>(
      this as ReportSent,
    );
  }

  Map<String, dynamic> toMap() {
    return ReportSentMapper.ensureInitialized().encodeMap<ReportSent>(
      this as ReportSent,
    );
  }

  ReportSentCopyWith<ReportSent, ReportSent, ReportSent> get copyWith =>
      _ReportSentCopyWithImpl<ReportSent, ReportSent>(
        this as ReportSent,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ReportSentMapper.ensureInitialized().stringifyValue(
      this as ReportSent,
    );
  }

  @override
  bool operator ==(Object other) {
    return ReportSentMapper.ensureInitialized().equalsValue(
      this as ReportSent,
      other,
    );
  }

  @override
  int get hashCode {
    return ReportSentMapper.ensureInitialized().hashValue(this as ReportSent);
  }
}

extension ReportSentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReportSent, $Out> {
  ReportSentCopyWith<$R, ReportSent, $Out> get $asReportSent =>
      $base.as((v, t, t2) => _ReportSentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ReportSentCopyWith<$R, $In extends ReportSent, $Out>
    implements ReportStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ReportSentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReportSentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReportSent, $Out>
    implements ReportSentCopyWith<$R, ReportSent, $Out> {
  _ReportSentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReportSent> $mapper =
      ReportSentMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  ReportSent $make(CopyWithData data) => ReportSent();

  @override
  ReportSentCopyWith<$R2, ReportSent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ReportSentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

