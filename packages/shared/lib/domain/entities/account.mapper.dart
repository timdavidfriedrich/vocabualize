// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'account.dart';

class AccountMapper extends ClassMapperBase<Account> {
  AccountMapper._();

  static AccountMapper? _instance;
  static AccountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AccountMapper._());
      LocalAccountMapper.ensureInitialized();
      GoogleAccountMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Account';

  @override
  final MappableFields<Account> fields = const {};

  static Account _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('Account');
  }

  @override
  final Function instantiate = _instantiate;

  static Account fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Account>(map);
  }

  static Account fromJson(String json) {
    return ensureInitialized().decodeJson<Account>(json);
  }
}

mixin AccountMappable {
  String toJson();
  Map<String, dynamic> toMap();
  AccountCopyWith<Account, Account, Account> get copyWith;
}

abstract class AccountCopyWith<$R, $In extends Account, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  AccountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class LocalAccountMapper extends ClassMapperBase<LocalAccount> {
  LocalAccountMapper._();

  static LocalAccountMapper? _instance;
  static LocalAccountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalAccountMapper._());
      AccountMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalAccount';

  @override
  final MappableFields<LocalAccount> fields = const {};

  static LocalAccount _instantiate(DecodingData data) {
    return LocalAccount();
  }

  @override
  final Function instantiate = _instantiate;

  static LocalAccount fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalAccount>(map);
  }

  static LocalAccount fromJson(String json) {
    return ensureInitialized().decodeJson<LocalAccount>(json);
  }
}

mixin LocalAccountMappable {
  String toJson() {
    return LocalAccountMapper.ensureInitialized().encodeJson<LocalAccount>(
      this as LocalAccount,
    );
  }

  Map<String, dynamic> toMap() {
    return LocalAccountMapper.ensureInitialized().encodeMap<LocalAccount>(
      this as LocalAccount,
    );
  }

  LocalAccountCopyWith<LocalAccount, LocalAccount, LocalAccount> get copyWith =>
      _LocalAccountCopyWithImpl<LocalAccount, LocalAccount>(
        this as LocalAccount,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LocalAccountMapper.ensureInitialized().stringifyValue(
      this as LocalAccount,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalAccountMapper.ensureInitialized().equalsValue(
      this as LocalAccount,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalAccountMapper.ensureInitialized().hashValue(
      this as LocalAccount,
    );
  }
}

extension LocalAccountValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalAccount, $Out> {
  LocalAccountCopyWith<$R, LocalAccount, $Out> get $asLocalAccount =>
      $base.as((v, t, t2) => _LocalAccountCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocalAccountCopyWith<$R, $In extends LocalAccount, $Out>
    implements AccountCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LocalAccountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocalAccountCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalAccount, $Out>
    implements LocalAccountCopyWith<$R, LocalAccount, $Out> {
  _LocalAccountCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalAccount> $mapper =
      LocalAccountMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LocalAccount $make(CopyWithData data) => LocalAccount();

  @override
  LocalAccountCopyWith<$R2, LocalAccount, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocalAccountCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class GoogleAccountMapper extends ClassMapperBase<GoogleAccount> {
  GoogleAccountMapper._();

  static GoogleAccountMapper? _instance;
  static GoogleAccountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GoogleAccountMapper._());
      AccountMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GoogleAccount';

  static String _$id(GoogleAccount v) => v.id;
  static const Field<GoogleAccount, String> _f$id = Field('id', _$id);
  static String? _$name(GoogleAccount v) => v.name;
  static const Field<GoogleAccount, String> _f$name = Field('name', _$name);
  static String? _$email(GoogleAccount v) => v.email;
  static const Field<GoogleAccount, String> _f$email = Field('email', _$email);
  static String? _$picturePath(GoogleAccount v) => v.picturePath;
  static const Field<GoogleAccount, String> _f$picturePath = Field(
    'picturePath',
    _$picturePath,
  );

  @override
  final MappableFields<GoogleAccount> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #picturePath: _f$picturePath,
  };

  static GoogleAccount _instantiate(DecodingData data) {
    return GoogleAccount(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      picturePath: data.dec(_f$picturePath),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GoogleAccount fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GoogleAccount>(map);
  }

  static GoogleAccount fromJson(String json) {
    return ensureInitialized().decodeJson<GoogleAccount>(json);
  }
}

mixin GoogleAccountMappable {
  String toJson() {
    return GoogleAccountMapper.ensureInitialized().encodeJson<GoogleAccount>(
      this as GoogleAccount,
    );
  }

  Map<String, dynamic> toMap() {
    return GoogleAccountMapper.ensureInitialized().encodeMap<GoogleAccount>(
      this as GoogleAccount,
    );
  }

  GoogleAccountCopyWith<GoogleAccount, GoogleAccount, GoogleAccount>
  get copyWith => _GoogleAccountCopyWithImpl<GoogleAccount, GoogleAccount>(
    this as GoogleAccount,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return GoogleAccountMapper.ensureInitialized().stringifyValue(
      this as GoogleAccount,
    );
  }

  @override
  bool operator ==(Object other) {
    return GoogleAccountMapper.ensureInitialized().equalsValue(
      this as GoogleAccount,
      other,
    );
  }

  @override
  int get hashCode {
    return GoogleAccountMapper.ensureInitialized().hashValue(
      this as GoogleAccount,
    );
  }
}

extension GoogleAccountValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GoogleAccount, $Out> {
  GoogleAccountCopyWith<$R, GoogleAccount, $Out> get $asGoogleAccount =>
      $base.as((v, t, t2) => _GoogleAccountCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GoogleAccountCopyWith<$R, $In extends GoogleAccount, $Out>
    implements AccountCopyWith<$R, $In, $Out> {
  @override
  $R call({String? id, String? name, String? email, String? picturePath});
  GoogleAccountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GoogleAccountCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GoogleAccount, $Out>
    implements GoogleAccountCopyWith<$R, GoogleAccount, $Out> {
  _GoogleAccountCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GoogleAccount> $mapper =
      GoogleAccountMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    Object? name = $none,
    Object? email = $none,
    Object? picturePath = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != $none) #name: name,
      if (email != $none) #email: email,
      if (picturePath != $none) #picturePath: picturePath,
    }),
  );
  @override
  GoogleAccount $make(CopyWithData data) => GoogleAccount(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    picturePath: data.get(#picturePath, or: $value.picturePath),
  );

  @override
  GoogleAccountCopyWith<$R2, GoogleAccount, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GoogleAccountCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

