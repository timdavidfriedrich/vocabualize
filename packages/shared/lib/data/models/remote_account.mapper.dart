// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'remote_account.dart';

class RemoteAccountMapper extends ClassMapperBase<RemoteAccount> {
  RemoteAccountMapper._();

  static RemoteAccountMapper? _instance;
  static RemoteAccountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteAccountMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteAccount';

  static String _$id(RemoteAccount v) => v.id;
  static const Field<RemoteAccount, String> _f$id = Field('id', _$id);
  static String? _$fullName(RemoteAccount v) => v.fullName;
  static const Field<RemoteAccount, String> _f$fullName = Field(
    'fullName',
    _$fullName,
  );
  static String? _$email(RemoteAccount v) => v.email;
  static const Field<RemoteAccount, String> _f$email = Field('email', _$email);
  static String? _$pictureUrl(RemoteAccount v) => v.pictureUrl;
  static const Field<RemoteAccount, String> _f$pictureUrl = Field(
    'pictureUrl',
    _$pictureUrl,
  );

  @override
  final MappableFields<RemoteAccount> fields = const {
    #id: _f$id,
    #fullName: _f$fullName,
    #email: _f$email,
    #pictureUrl: _f$pictureUrl,
  };

  static RemoteAccount _instantiate(DecodingData data) {
    return RemoteAccount(
      id: data.dec(_f$id),
      fullName: data.dec(_f$fullName),
      email: data.dec(_f$email),
      pictureUrl: data.dec(_f$pictureUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteAccount fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteAccount>(map);
  }

  static RemoteAccount fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteAccount>(json);
  }
}

mixin RemoteAccountMappable {
  String toJson() {
    return RemoteAccountMapper.ensureInitialized().encodeJson<RemoteAccount>(
      this as RemoteAccount,
    );
  }

  Map<String, dynamic> toMap() {
    return RemoteAccountMapper.ensureInitialized().encodeMap<RemoteAccount>(
      this as RemoteAccount,
    );
  }

  RemoteAccountCopyWith<RemoteAccount, RemoteAccount, RemoteAccount>
  get copyWith => _RemoteAccountCopyWithImpl<RemoteAccount, RemoteAccount>(
    this as RemoteAccount,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return RemoteAccountMapper.ensureInitialized().stringifyValue(
      this as RemoteAccount,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteAccountMapper.ensureInitialized().equalsValue(
      this as RemoteAccount,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteAccountMapper.ensureInitialized().hashValue(
      this as RemoteAccount,
    );
  }
}

extension RemoteAccountValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteAccount, $Out> {
  RemoteAccountCopyWith<$R, RemoteAccount, $Out> get $asRemoteAccount =>
      $base.as((v, t, t2) => _RemoteAccountCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RemoteAccountCopyWith<$R, $In extends RemoteAccount, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? fullName, String? email, String? pictureUrl});
  RemoteAccountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RemoteAccountCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteAccount, $Out>
    implements RemoteAccountCopyWith<$R, RemoteAccount, $Out> {
  _RemoteAccountCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteAccount> $mapper =
      RemoteAccountMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    Object? fullName = $none,
    Object? email = $none,
    Object? pictureUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (fullName != $none) #fullName: fullName,
      if (email != $none) #email: email,
      if (pictureUrl != $none) #pictureUrl: pictureUrl,
    }),
  );
  @override
  RemoteAccount $make(CopyWithData data) => RemoteAccount(
    id: data.get(#id, or: $value.id),
    fullName: data.get(#fullName, or: $value.fullName),
    email: data.get(#email, or: $value.email),
    pictureUrl: data.get(#pictureUrl, or: $value.pictureUrl),
  );

  @override
  RemoteAccountCopyWith<$R2, RemoteAccount, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RemoteAccountCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

