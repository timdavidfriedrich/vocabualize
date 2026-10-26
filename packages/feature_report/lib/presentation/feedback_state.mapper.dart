// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'feedback_state.dart';

class FeedbackStateMapper extends ClassMapperBase<FeedbackState> {
  FeedbackStateMapper._();

  static FeedbackStateMapper? _instance;
  static FeedbackStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeedbackStateMapper._());
      FeedbackEditingMapper.ensureInitialized();
      FeedbackSentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FeedbackState';

  @override
  final MappableFields<FeedbackState> fields = const {};

  static FeedbackState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('FeedbackState');
  }

  @override
  final Function instantiate = _instantiate;

  static FeedbackState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FeedbackState>(map);
  }

  static FeedbackState fromJson(String json) {
    return ensureInitialized().decodeJson<FeedbackState>(json);
  }
}

mixin FeedbackStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  FeedbackStateCopyWith<FeedbackState, FeedbackState, FeedbackState>
  get copyWith;
}

abstract class FeedbackStateCopyWith<$R, $In extends FeedbackState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  FeedbackStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class FeedbackEditingMapper extends ClassMapperBase<FeedbackEditing> {
  FeedbackEditingMapper._();

  static FeedbackEditingMapper? _instance;
  static FeedbackEditingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeedbackEditingMapper._());
      FeedbackStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FeedbackEditing';

  static bool _$isSending(FeedbackEditing v) => v.isSending;
  static const Field<FeedbackEditing, bool> _f$isSending = Field(
    'isSending',
    _$isSending,
  );
  static AppError? _$error(FeedbackEditing v) => v.error;
  static const Field<FeedbackEditing, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<FeedbackEditing> fields = const {
    #isSending: _f$isSending,
    #error: _f$error,
  };

  static FeedbackEditing _instantiate(DecodingData data) {
    return FeedbackEditing(
      isSending: data.dec(_f$isSending),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FeedbackEditing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FeedbackEditing>(map);
  }

  static FeedbackEditing fromJson(String json) {
    return ensureInitialized().decodeJson<FeedbackEditing>(json);
  }
}

mixin FeedbackEditingMappable {
  String toJson() {
    return FeedbackEditingMapper.ensureInitialized()
        .encodeJson<FeedbackEditing>(this as FeedbackEditing);
  }

  Map<String, dynamic> toMap() {
    return FeedbackEditingMapper.ensureInitialized().encodeMap<FeedbackEditing>(
      this as FeedbackEditing,
    );
  }

  FeedbackEditingCopyWith<FeedbackEditing, FeedbackEditing, FeedbackEditing>
  get copyWith =>
      _FeedbackEditingCopyWithImpl<FeedbackEditing, FeedbackEditing>(
        this as FeedbackEditing,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return FeedbackEditingMapper.ensureInitialized().stringifyValue(
      this as FeedbackEditing,
    );
  }

  @override
  bool operator ==(Object other) {
    return FeedbackEditingMapper.ensureInitialized().equalsValue(
      this as FeedbackEditing,
      other,
    );
  }

  @override
  int get hashCode {
    return FeedbackEditingMapper.ensureInitialized().hashValue(
      this as FeedbackEditing,
    );
  }
}

extension FeedbackEditingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FeedbackEditing, $Out> {
  FeedbackEditingCopyWith<$R, FeedbackEditing, $Out> get $asFeedbackEditing =>
      $base.as((v, t, t2) => _FeedbackEditingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FeedbackEditingCopyWith<$R, $In extends FeedbackEditing, $Out>
    implements FeedbackStateCopyWith<$R, $In, $Out> {
  @override
  $R call({bool? isSending, AppError? error});
  FeedbackEditingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FeedbackEditingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FeedbackEditing, $Out>
    implements FeedbackEditingCopyWith<$R, FeedbackEditing, $Out> {
  _FeedbackEditingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FeedbackEditing> $mapper =
      FeedbackEditingMapper.ensureInitialized();
  @override
  $R call({bool? isSending, Object? error = $none}) => $apply(
    FieldCopyWithData({
      if (isSending != null) #isSending: isSending,
      if (error != $none) #error: error,
    }),
  );
  @override
  FeedbackEditing $make(CopyWithData data) => FeedbackEditing(
    isSending: data.get(#isSending, or: $value.isSending),
    error: data.get(#error, or: $value.error),
  );

  @override
  FeedbackEditingCopyWith<$R2, FeedbackEditing, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FeedbackEditingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FeedbackSentMapper extends ClassMapperBase<FeedbackSent> {
  FeedbackSentMapper._();

  static FeedbackSentMapper? _instance;
  static FeedbackSentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeedbackSentMapper._());
      FeedbackStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FeedbackSent';

  @override
  final MappableFields<FeedbackSent> fields = const {};

  static FeedbackSent _instantiate(DecodingData data) {
    return FeedbackSent();
  }

  @override
  final Function instantiate = _instantiate;

  static FeedbackSent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FeedbackSent>(map);
  }

  static FeedbackSent fromJson(String json) {
    return ensureInitialized().decodeJson<FeedbackSent>(json);
  }
}

mixin FeedbackSentMappable {
  String toJson() {
    return FeedbackSentMapper.ensureInitialized().encodeJson<FeedbackSent>(
      this as FeedbackSent,
    );
  }

  Map<String, dynamic> toMap() {
    return FeedbackSentMapper.ensureInitialized().encodeMap<FeedbackSent>(
      this as FeedbackSent,
    );
  }

  FeedbackSentCopyWith<FeedbackSent, FeedbackSent, FeedbackSent> get copyWith =>
      _FeedbackSentCopyWithImpl<FeedbackSent, FeedbackSent>(
        this as FeedbackSent,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return FeedbackSentMapper.ensureInitialized().stringifyValue(
      this as FeedbackSent,
    );
  }

  @override
  bool operator ==(Object other) {
    return FeedbackSentMapper.ensureInitialized().equalsValue(
      this as FeedbackSent,
      other,
    );
  }

  @override
  int get hashCode {
    return FeedbackSentMapper.ensureInitialized().hashValue(
      this as FeedbackSent,
    );
  }
}

extension FeedbackSentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FeedbackSent, $Out> {
  FeedbackSentCopyWith<$R, FeedbackSent, $Out> get $asFeedbackSent =>
      $base.as((v, t, t2) => _FeedbackSentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FeedbackSentCopyWith<$R, $In extends FeedbackSent, $Out>
    implements FeedbackStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  FeedbackSentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FeedbackSentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FeedbackSent, $Out>
    implements FeedbackSentCopyWith<$R, FeedbackSent, $Out> {
  _FeedbackSentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FeedbackSent> $mapper =
      FeedbackSentMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  FeedbackSent $make(CopyWithData data) => FeedbackSent();

  @override
  FeedbackSentCopyWith<$R2, FeedbackSent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FeedbackSentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

