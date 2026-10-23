// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_status.dart';

class AuthStatusMapper extends ClassMapperBase<AuthStatus> {
  AuthStatusMapper._();

  static AuthStatusMapper? _instance;
  static AuthStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthStatusMapper._());
      AuthUnknownMapper.ensureInitialized();
      AuthUnauthenticatedMapper.ensureInitialized();
      AuthAuthenticatedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthStatus';

  @override
  final MappableFields<AuthStatus> fields = const {};

  static AuthStatus _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('AuthStatus');
  }

  @override
  final Function instantiate = _instantiate;

  static AuthStatus fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthStatus>(map);
  }

  static AuthStatus fromJson(String json) {
    return ensureInitialized().decodeJson<AuthStatus>(json);
  }
}

mixin AuthStatusMappable {
  String toJson();
  Map<String, dynamic> toMap();
  AuthStatusCopyWith<AuthStatus, AuthStatus, AuthStatus> get copyWith;
}

abstract class AuthStatusCopyWith<$R, $In extends AuthStatus, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  AuthStatusCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class AuthUnknownMapper extends ClassMapperBase<AuthUnknown> {
  AuthUnknownMapper._();

  static AuthUnknownMapper? _instance;
  static AuthUnknownMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthUnknownMapper._());
      AuthStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthUnknown';

  @override
  final MappableFields<AuthUnknown> fields = const {};

  static AuthUnknown _instantiate(DecodingData data) {
    return AuthUnknown();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthUnknown fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthUnknown>(map);
  }

  static AuthUnknown fromJson(String json) {
    return ensureInitialized().decodeJson<AuthUnknown>(json);
  }
}

mixin AuthUnknownMappable {
  String toJson() {
    return AuthUnknownMapper.ensureInitialized().encodeJson<AuthUnknown>(
      this as AuthUnknown,
    );
  }

  Map<String, dynamic> toMap() {
    return AuthUnknownMapper.ensureInitialized().encodeMap<AuthUnknown>(
      this as AuthUnknown,
    );
  }

  AuthUnknownCopyWith<AuthUnknown, AuthUnknown, AuthUnknown> get copyWith =>
      _AuthUnknownCopyWithImpl<AuthUnknown, AuthUnknown>(
        this as AuthUnknown,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthUnknownMapper.ensureInitialized().stringifyValue(
      this as AuthUnknown,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthUnknownMapper.ensureInitialized().equalsValue(
      this as AuthUnknown,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthUnknownMapper.ensureInitialized().hashValue(this as AuthUnknown);
  }
}

extension AuthUnknownValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthUnknown, $Out> {
  AuthUnknownCopyWith<$R, AuthUnknown, $Out> get $asAuthUnknown =>
      $base.as((v, t, t2) => _AuthUnknownCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthUnknownCopyWith<$R, $In extends AuthUnknown, $Out>
    implements AuthStatusCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthUnknownCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthUnknownCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthUnknown, $Out>
    implements AuthUnknownCopyWith<$R, AuthUnknown, $Out> {
  _AuthUnknownCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthUnknown> $mapper =
      AuthUnknownMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthUnknown $make(CopyWithData data) => AuthUnknown();

  @override
  AuthUnknownCopyWith<$R2, AuthUnknown, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthUnknownCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthUnauthenticatedMapper extends ClassMapperBase<AuthUnauthenticated> {
  AuthUnauthenticatedMapper._();

  static AuthUnauthenticatedMapper? _instance;
  static AuthUnauthenticatedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthUnauthenticatedMapper._());
      AuthStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthUnauthenticated';

  @override
  final MappableFields<AuthUnauthenticated> fields = const {};

  static AuthUnauthenticated _instantiate(DecodingData data) {
    return AuthUnauthenticated();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthUnauthenticated fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthUnauthenticated>(map);
  }

  static AuthUnauthenticated fromJson(String json) {
    return ensureInitialized().decodeJson<AuthUnauthenticated>(json);
  }
}

mixin AuthUnauthenticatedMappable {
  String toJson() {
    return AuthUnauthenticatedMapper.ensureInitialized()
        .encodeJson<AuthUnauthenticated>(this as AuthUnauthenticated);
  }

  Map<String, dynamic> toMap() {
    return AuthUnauthenticatedMapper.ensureInitialized()
        .encodeMap<AuthUnauthenticated>(this as AuthUnauthenticated);
  }

  AuthUnauthenticatedCopyWith<
    AuthUnauthenticated,
    AuthUnauthenticated,
    AuthUnauthenticated
  >
  get copyWith =>
      _AuthUnauthenticatedCopyWithImpl<
        AuthUnauthenticated,
        AuthUnauthenticated
      >(this as AuthUnauthenticated, $identity, $identity);
  @override
  String toString() {
    return AuthUnauthenticatedMapper.ensureInitialized().stringifyValue(
      this as AuthUnauthenticated,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthUnauthenticatedMapper.ensureInitialized().equalsValue(
      this as AuthUnauthenticated,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthUnauthenticatedMapper.ensureInitialized().hashValue(
      this as AuthUnauthenticated,
    );
  }
}

extension AuthUnauthenticatedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthUnauthenticated, $Out> {
  AuthUnauthenticatedCopyWith<$R, AuthUnauthenticated, $Out>
  get $asAuthUnauthenticated => $base.as(
    (v, t, t2) => _AuthUnauthenticatedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthUnauthenticatedCopyWith<
  $R,
  $In extends AuthUnauthenticated,
  $Out
>
    implements AuthStatusCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthUnauthenticatedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthUnauthenticatedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthUnauthenticated, $Out>
    implements AuthUnauthenticatedCopyWith<$R, AuthUnauthenticated, $Out> {
  _AuthUnauthenticatedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthUnauthenticated> $mapper =
      AuthUnauthenticatedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthUnauthenticated $make(CopyWithData data) => AuthUnauthenticated();

  @override
  AuthUnauthenticatedCopyWith<$R2, AuthUnauthenticated, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AuthUnauthenticatedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthAuthenticatedMapper extends ClassMapperBase<AuthAuthenticated> {
  AuthAuthenticatedMapper._();

  static AuthAuthenticatedMapper? _instance;
  static AuthAuthenticatedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthAuthenticatedMapper._());
      AuthStatusMapper.ensureInitialized();
      AccountMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthAuthenticated';

  static Account _$account(AuthAuthenticated v) => v.account;
  static const Field<AuthAuthenticated, Account> _f$account = Field(
    'account',
    _$account,
  );

  @override
  final MappableFields<AuthAuthenticated> fields = const {#account: _f$account};

  static AuthAuthenticated _instantiate(DecodingData data) {
    return AuthAuthenticated(account: data.dec(_f$account));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthAuthenticated fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthAuthenticated>(map);
  }

  static AuthAuthenticated fromJson(String json) {
    return ensureInitialized().decodeJson<AuthAuthenticated>(json);
  }
}

mixin AuthAuthenticatedMappable {
  String toJson() {
    return AuthAuthenticatedMapper.ensureInitialized()
        .encodeJson<AuthAuthenticated>(this as AuthAuthenticated);
  }

  Map<String, dynamic> toMap() {
    return AuthAuthenticatedMapper.ensureInitialized()
        .encodeMap<AuthAuthenticated>(this as AuthAuthenticated);
  }

  AuthAuthenticatedCopyWith<
    AuthAuthenticated,
    AuthAuthenticated,
    AuthAuthenticated
  >
  get copyWith =>
      _AuthAuthenticatedCopyWithImpl<AuthAuthenticated, AuthAuthenticated>(
        this as AuthAuthenticated,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthAuthenticatedMapper.ensureInitialized().stringifyValue(
      this as AuthAuthenticated,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthAuthenticatedMapper.ensureInitialized().equalsValue(
      this as AuthAuthenticated,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthAuthenticatedMapper.ensureInitialized().hashValue(
      this as AuthAuthenticated,
    );
  }
}

extension AuthAuthenticatedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthAuthenticated, $Out> {
  AuthAuthenticatedCopyWith<$R, AuthAuthenticated, $Out>
  get $asAuthAuthenticated => $base.as(
    (v, t, t2) => _AuthAuthenticatedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthAuthenticatedCopyWith<
  $R,
  $In extends AuthAuthenticated,
  $Out
>
    implements AuthStatusCopyWith<$R, $In, $Out> {
  AccountCopyWith<$R, Account, Account> get account;
  @override
  $R call({Account? account});
  AuthAuthenticatedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthAuthenticatedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthAuthenticated, $Out>
    implements AuthAuthenticatedCopyWith<$R, AuthAuthenticated, $Out> {
  _AuthAuthenticatedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthAuthenticated> $mapper =
      AuthAuthenticatedMapper.ensureInitialized();
  @override
  AccountCopyWith<$R, Account, Account> get account =>
      $value.account.copyWith.$chain((v) => call(account: v));
  @override
  $R call({Account? account}) =>
      $apply(FieldCopyWithData({if (account != null) #account: account}));
  @override
  AuthAuthenticated $make(CopyWithData data) =>
      AuthAuthenticated(account: data.get(#account, or: $value.account));

  @override
  AuthAuthenticatedCopyWith<$R2, AuthAuthenticated, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthAuthenticatedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

