// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'sign_in_result.dart';

class SignInResultMapper extends ClassMapperBase<SignInResult> {
  SignInResultMapper._();

  static SignInResultMapper? _instance;
  static SignInResultMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SignInResultMapper._());
      SignedInMapper.ensureInitialized();
      AccountConflictMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SignInResult';

  @override
  final MappableFields<SignInResult> fields = const {};

  static SignInResult _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('SignInResult');
  }

  @override
  final Function instantiate = _instantiate;

  static SignInResult fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SignInResult>(map);
  }

  static SignInResult fromJson(String json) {
    return ensureInitialized().decodeJson<SignInResult>(json);
  }
}

mixin SignInResultMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SignInResultCopyWith<SignInResult, SignInResult, SignInResult> get copyWith;
}

abstract class SignInResultCopyWith<$R, $In extends SignInResult, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  SignInResultCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SignedInMapper extends ClassMapperBase<SignedIn> {
  SignedInMapper._();

  static SignedInMapper? _instance;
  static SignedInMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SignedInMapper._());
      SignInResultMapper.ensureInitialized();
      AccountMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SignedIn';

  static Account _$account(SignedIn v) => v.account;
  static const Field<SignedIn, Account> _f$account = Field(
    'account',
    _$account,
  );

  @override
  final MappableFields<SignedIn> fields = const {#account: _f$account};

  static SignedIn _instantiate(DecodingData data) {
    return SignedIn(account: data.dec(_f$account));
  }

  @override
  final Function instantiate = _instantiate;

  static SignedIn fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SignedIn>(map);
  }

  static SignedIn fromJson(String json) {
    return ensureInitialized().decodeJson<SignedIn>(json);
  }
}

mixin SignedInMappable {
  String toJson() {
    return SignedInMapper.ensureInitialized().encodeJson<SignedIn>(
      this as SignedIn,
    );
  }

  Map<String, dynamic> toMap() {
    return SignedInMapper.ensureInitialized().encodeMap<SignedIn>(
      this as SignedIn,
    );
  }

  SignedInCopyWith<SignedIn, SignedIn, SignedIn> get copyWith =>
      _SignedInCopyWithImpl<SignedIn, SignedIn>(
        this as SignedIn,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SignedInMapper.ensureInitialized().stringifyValue(this as SignedIn);
  }

  @override
  bool operator ==(Object other) {
    return SignedInMapper.ensureInitialized().equalsValue(
      this as SignedIn,
      other,
    );
  }

  @override
  int get hashCode {
    return SignedInMapper.ensureInitialized().hashValue(this as SignedIn);
  }
}

extension SignedInValueCopy<$R, $Out> on ObjectCopyWith<$R, SignedIn, $Out> {
  SignedInCopyWith<$R, SignedIn, $Out> get $asSignedIn =>
      $base.as((v, t, t2) => _SignedInCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SignedInCopyWith<$R, $In extends SignedIn, $Out>
    implements SignInResultCopyWith<$R, $In, $Out> {
  AccountCopyWith<$R, Account, Account> get account;
  @override
  $R call({Account? account});
  SignedInCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SignedInCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SignedIn, $Out>
    implements SignedInCopyWith<$R, SignedIn, $Out> {
  _SignedInCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SignedIn> $mapper =
      SignedInMapper.ensureInitialized();
  @override
  AccountCopyWith<$R, Account, Account> get account =>
      $value.account.copyWith.$chain((v) => call(account: v));
  @override
  $R call({Account? account}) =>
      $apply(FieldCopyWithData({if (account != null) #account: account}));
  @override
  SignedIn $make(CopyWithData data) =>
      SignedIn(account: data.get(#account, or: $value.account));

  @override
  SignedInCopyWith<$R2, SignedIn, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SignedInCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AccountConflictMapper extends ClassMapperBase<AccountConflict> {
  AccountConflictMapper._();

  static AccountConflictMapper? _instance;
  static AccountConflictMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AccountConflictMapper._());
      SignInResultMapper.ensureInitialized();
      GoogleAccountMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AccountConflict';

  static GoogleAccount _$previous(AccountConflict v) => v.previous;
  static const Field<AccountConflict, GoogleAccount> _f$previous = Field(
    'previous',
    _$previous,
  );
  static GoogleAccount _$next(AccountConflict v) => v.next;
  static const Field<AccountConflict, GoogleAccount> _f$next = Field(
    'next',
    _$next,
  );

  @override
  final MappableFields<AccountConflict> fields = const {
    #previous: _f$previous,
    #next: _f$next,
  };

  static AccountConflict _instantiate(DecodingData data) {
    return AccountConflict(
      previous: data.dec(_f$previous),
      next: data.dec(_f$next),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AccountConflict fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AccountConflict>(map);
  }

  static AccountConflict fromJson(String json) {
    return ensureInitialized().decodeJson<AccountConflict>(json);
  }
}

mixin AccountConflictMappable {
  String toJson() {
    return AccountConflictMapper.ensureInitialized()
        .encodeJson<AccountConflict>(this as AccountConflict);
  }

  Map<String, dynamic> toMap() {
    return AccountConflictMapper.ensureInitialized().encodeMap<AccountConflict>(
      this as AccountConflict,
    );
  }

  AccountConflictCopyWith<AccountConflict, AccountConflict, AccountConflict>
  get copyWith =>
      _AccountConflictCopyWithImpl<AccountConflict, AccountConflict>(
        this as AccountConflict,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AccountConflictMapper.ensureInitialized().stringifyValue(
      this as AccountConflict,
    );
  }

  @override
  bool operator ==(Object other) {
    return AccountConflictMapper.ensureInitialized().equalsValue(
      this as AccountConflict,
      other,
    );
  }

  @override
  int get hashCode {
    return AccountConflictMapper.ensureInitialized().hashValue(
      this as AccountConflict,
    );
  }
}

extension AccountConflictValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AccountConflict, $Out> {
  AccountConflictCopyWith<$R, AccountConflict, $Out> get $asAccountConflict =>
      $base.as((v, t, t2) => _AccountConflictCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AccountConflictCopyWith<$R, $In extends AccountConflict, $Out>
    implements SignInResultCopyWith<$R, $In, $Out> {
  GoogleAccountCopyWith<$R, GoogleAccount, GoogleAccount> get previous;
  GoogleAccountCopyWith<$R, GoogleAccount, GoogleAccount> get next;
  @override
  $R call({GoogleAccount? previous, GoogleAccount? next});
  AccountConflictCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AccountConflictCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AccountConflict, $Out>
    implements AccountConflictCopyWith<$R, AccountConflict, $Out> {
  _AccountConflictCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AccountConflict> $mapper =
      AccountConflictMapper.ensureInitialized();
  @override
  GoogleAccountCopyWith<$R, GoogleAccount, GoogleAccount> get previous =>
      $value.previous.copyWith.$chain((v) => call(previous: v));
  @override
  GoogleAccountCopyWith<$R, GoogleAccount, GoogleAccount> get next =>
      $value.next.copyWith.$chain((v) => call(next: v));
  @override
  $R call({GoogleAccount? previous, GoogleAccount? next}) => $apply(
    FieldCopyWithData({
      if (previous != null) #previous: previous,
      if (next != null) #next: next,
    }),
  );
  @override
  AccountConflict $make(CopyWithData data) => AccountConflict(
    previous: data.get(#previous, or: $value.previous),
    next: data.get(#next, or: $value.next),
  );

  @override
  AccountConflictCopyWith<$R2, AccountConflict, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AccountConflictCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

