// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings_state.dart';

class SettingsStateMapper extends ClassMapperBase<SettingsState> {
  SettingsStateMapper._();

  static SettingsStateMapper? _instance;
  static SettingsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsStateMapper._());
      SettingsLoadingMapper.ensureInitialized();
      SettingsLoadedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsState';

  @override
  final MappableFields<SettingsState> fields = const {};

  static SettingsState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('SettingsState');
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsState>(map);
  }

  static SettingsState fromJson(String json) {
    return ensureInitialized().decodeJson<SettingsState>(json);
  }
}

mixin SettingsStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SettingsStateCopyWith<SettingsState, SettingsState, SettingsState>
  get copyWith;
}

abstract class SettingsStateCopyWith<$R, $In extends SettingsState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  SettingsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SettingsLoadingMapper extends ClassMapperBase<SettingsLoading> {
  SettingsLoadingMapper._();

  static SettingsLoadingMapper? _instance;
  static SettingsLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsLoadingMapper._());
      SettingsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsLoading';

  @override
  final MappableFields<SettingsLoading> fields = const {};

  static SettingsLoading _instantiate(DecodingData data) {
    return SettingsLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsLoading>(map);
  }

  static SettingsLoading fromJson(String json) {
    return ensureInitialized().decodeJson<SettingsLoading>(json);
  }
}

mixin SettingsLoadingMappable {
  String toJson() {
    return SettingsLoadingMapper.ensureInitialized()
        .encodeJson<SettingsLoading>(this as SettingsLoading);
  }

  Map<String, dynamic> toMap() {
    return SettingsLoadingMapper.ensureInitialized().encodeMap<SettingsLoading>(
      this as SettingsLoading,
    );
  }

  SettingsLoadingCopyWith<SettingsLoading, SettingsLoading, SettingsLoading>
  get copyWith =>
      _SettingsLoadingCopyWithImpl<SettingsLoading, SettingsLoading>(
        this as SettingsLoading,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SettingsLoadingMapper.ensureInitialized().stringifyValue(
      this as SettingsLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return SettingsLoadingMapper.ensureInitialized().equalsValue(
      this as SettingsLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return SettingsLoadingMapper.ensureInitialized().hashValue(
      this as SettingsLoading,
    );
  }
}

extension SettingsLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsLoading, $Out> {
  SettingsLoadingCopyWith<$R, SettingsLoading, $Out> get $asSettingsLoading =>
      $base.as((v, t, t2) => _SettingsLoadingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SettingsLoadingCopyWith<$R, $In extends SettingsLoading, $Out>
    implements SettingsStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  SettingsLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SettingsLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingsLoading, $Out>
    implements SettingsLoadingCopyWith<$R, SettingsLoading, $Out> {
  _SettingsLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsLoading> $mapper =
      SettingsLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  SettingsLoading $make(CopyWithData data) => SettingsLoading();

  @override
  SettingsLoadingCopyWith<$R2, SettingsLoading, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SettingsLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SettingsLoadedMapper extends ClassMapperBase<SettingsLoaded> {
  SettingsLoadedMapper._();

  static SettingsLoadedMapper? _instance;
  static SettingsLoadedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsLoadedMapper._());
      SettingsStateMapper.ensureInitialized();
      AccountMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsLoaded';

  static Account _$account(SettingsLoaded v) => v.account;
  static const Field<SettingsLoaded, Account> _f$account = Field(
    'account',
    _$account,
  );
  static bool _$isSigningIn(SettingsLoaded v) => v.isSigningIn;
  static const Field<SettingsLoaded, bool> _f$isSigningIn = Field(
    'isSigningIn',
    _$isSigningIn,
  );
  static AppError? _$signInError(SettingsLoaded v) => v.signInError;
  static const Field<SettingsLoaded, AppError> _f$signInError = Field(
    'signInError',
    _$signInError,
  );

  @override
  final MappableFields<SettingsLoaded> fields = const {
    #account: _f$account,
    #isSigningIn: _f$isSigningIn,
    #signInError: _f$signInError,
  };

  static SettingsLoaded _instantiate(DecodingData data) {
    return SettingsLoaded(
      account: data.dec(_f$account),
      isSigningIn: data.dec(_f$isSigningIn),
      signInError: data.dec(_f$signInError),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsLoaded fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsLoaded>(map);
  }

  static SettingsLoaded fromJson(String json) {
    return ensureInitialized().decodeJson<SettingsLoaded>(json);
  }
}

mixin SettingsLoadedMappable {
  String toJson() {
    return SettingsLoadedMapper.ensureInitialized().encodeJson<SettingsLoaded>(
      this as SettingsLoaded,
    );
  }

  Map<String, dynamic> toMap() {
    return SettingsLoadedMapper.ensureInitialized().encodeMap<SettingsLoaded>(
      this as SettingsLoaded,
    );
  }

  SettingsLoadedCopyWith<SettingsLoaded, SettingsLoaded, SettingsLoaded>
  get copyWith => _SettingsLoadedCopyWithImpl<SettingsLoaded, SettingsLoaded>(
    this as SettingsLoaded,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return SettingsLoadedMapper.ensureInitialized().stringifyValue(
      this as SettingsLoaded,
    );
  }

  @override
  bool operator ==(Object other) {
    return SettingsLoadedMapper.ensureInitialized().equalsValue(
      this as SettingsLoaded,
      other,
    );
  }

  @override
  int get hashCode {
    return SettingsLoadedMapper.ensureInitialized().hashValue(
      this as SettingsLoaded,
    );
  }
}

extension SettingsLoadedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsLoaded, $Out> {
  SettingsLoadedCopyWith<$R, SettingsLoaded, $Out> get $asSettingsLoaded =>
      $base.as((v, t, t2) => _SettingsLoadedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SettingsLoadedCopyWith<$R, $In extends SettingsLoaded, $Out>
    implements SettingsStateCopyWith<$R, $In, $Out> {
  AccountCopyWith<$R, Account, Account> get account;
  @override
  $R call({Account? account, bool? isSigningIn, AppError? signInError});
  SettingsLoadedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SettingsLoadedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingsLoaded, $Out>
    implements SettingsLoadedCopyWith<$R, SettingsLoaded, $Out> {
  _SettingsLoadedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsLoaded> $mapper =
      SettingsLoadedMapper.ensureInitialized();
  @override
  AccountCopyWith<$R, Account, Account> get account =>
      $value.account.copyWith.$chain((v) => call(account: v));
  @override
  $R call({Account? account, bool? isSigningIn, Object? signInError = $none}) =>
      $apply(
        FieldCopyWithData({
          if (account != null) #account: account,
          if (isSigningIn != null) #isSigningIn: isSigningIn,
          if (signInError != $none) #signInError: signInError,
        }),
      );
  @override
  SettingsLoaded $make(CopyWithData data) => SettingsLoaded(
    account: data.get(#account, or: $value.account),
    isSigningIn: data.get(#isSigningIn, or: $value.isSigningIn),
    signInError: data.get(#signInError, or: $value.signInError),
  );

  @override
  SettingsLoadedCopyWith<$R2, SettingsLoaded, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SettingsLoadedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

