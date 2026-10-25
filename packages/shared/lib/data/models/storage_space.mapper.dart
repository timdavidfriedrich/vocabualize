// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'storage_space.dart';

class StorageSpaceMapper extends ClassMapperBase<StorageSpace> {
  StorageSpaceMapper._();

  static StorageSpaceMapper? _instance;
  static StorageSpaceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StorageSpaceMapper._());
      LocalOnlySpaceMapper.ensureInitialized();
      AccountSpaceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StorageSpace';

  @override
  final MappableFields<StorageSpace> fields = const {};

  static StorageSpace _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('StorageSpace');
  }

  @override
  final Function instantiate = _instantiate;

  static StorageSpace fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StorageSpace>(map);
  }

  static StorageSpace fromJson(String json) {
    return ensureInitialized().decodeJson<StorageSpace>(json);
  }
}

mixin StorageSpaceMappable {
  String toJson();
  Map<String, dynamic> toMap();
  StorageSpaceCopyWith<StorageSpace, StorageSpace, StorageSpace> get copyWith;
}

abstract class StorageSpaceCopyWith<$R, $In extends StorageSpace, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  StorageSpaceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class LocalOnlySpaceMapper extends ClassMapperBase<LocalOnlySpace> {
  LocalOnlySpaceMapper._();

  static LocalOnlySpaceMapper? _instance;
  static LocalOnlySpaceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalOnlySpaceMapper._());
      StorageSpaceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalOnlySpace';

  @override
  final MappableFields<LocalOnlySpace> fields = const {};

  static LocalOnlySpace _instantiate(DecodingData data) {
    return LocalOnlySpace();
  }

  @override
  final Function instantiate = _instantiate;

  static LocalOnlySpace fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalOnlySpace>(map);
  }

  static LocalOnlySpace fromJson(String json) {
    return ensureInitialized().decodeJson<LocalOnlySpace>(json);
  }
}

mixin LocalOnlySpaceMappable {
  String toJson() {
    return LocalOnlySpaceMapper.ensureInitialized().encodeJson<LocalOnlySpace>(
      this as LocalOnlySpace,
    );
  }

  Map<String, dynamic> toMap() {
    return LocalOnlySpaceMapper.ensureInitialized().encodeMap<LocalOnlySpace>(
      this as LocalOnlySpace,
    );
  }

  LocalOnlySpaceCopyWith<LocalOnlySpace, LocalOnlySpace, LocalOnlySpace>
  get copyWith => _LocalOnlySpaceCopyWithImpl<LocalOnlySpace, LocalOnlySpace>(
    this as LocalOnlySpace,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return LocalOnlySpaceMapper.ensureInitialized().stringifyValue(
      this as LocalOnlySpace,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalOnlySpaceMapper.ensureInitialized().equalsValue(
      this as LocalOnlySpace,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalOnlySpaceMapper.ensureInitialized().hashValue(
      this as LocalOnlySpace,
    );
  }
}

extension LocalOnlySpaceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalOnlySpace, $Out> {
  LocalOnlySpaceCopyWith<$R, LocalOnlySpace, $Out> get $asLocalOnlySpace =>
      $base.as((v, t, t2) => _LocalOnlySpaceCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocalOnlySpaceCopyWith<$R, $In extends LocalOnlySpace, $Out>
    implements StorageSpaceCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LocalOnlySpaceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalOnlySpaceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalOnlySpace, $Out>
    implements LocalOnlySpaceCopyWith<$R, LocalOnlySpace, $Out> {
  _LocalOnlySpaceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalOnlySpace> $mapper =
      LocalOnlySpaceMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LocalOnlySpace $make(CopyWithData data) => LocalOnlySpace();

  @override
  LocalOnlySpaceCopyWith<$R2, LocalOnlySpace, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocalOnlySpaceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AccountSpaceMapper extends ClassMapperBase<AccountSpace> {
  AccountSpaceMapper._();

  static AccountSpaceMapper? _instance;
  static AccountSpaceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AccountSpaceMapper._());
      StorageSpaceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AccountSpace';

  static UuidValue _$userId(AccountSpace v) => v.userId;
  static const Field<AccountSpace, UuidValue> _f$userId = Field(
    'userId',
    _$userId,
  );

  @override
  final MappableFields<AccountSpace> fields = const {#userId: _f$userId};

  static AccountSpace _instantiate(DecodingData data) {
    return AccountSpace(userId: data.dec(_f$userId));
  }

  @override
  final Function instantiate = _instantiate;

  static AccountSpace fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AccountSpace>(map);
  }

  static AccountSpace fromJson(String json) {
    return ensureInitialized().decodeJson<AccountSpace>(json);
  }
}

mixin AccountSpaceMappable {
  String toJson() {
    return AccountSpaceMapper.ensureInitialized().encodeJson<AccountSpace>(
      this as AccountSpace,
    );
  }

  Map<String, dynamic> toMap() {
    return AccountSpaceMapper.ensureInitialized().encodeMap<AccountSpace>(
      this as AccountSpace,
    );
  }

  AccountSpaceCopyWith<AccountSpace, AccountSpace, AccountSpace> get copyWith =>
      _AccountSpaceCopyWithImpl<AccountSpace, AccountSpace>(
        this as AccountSpace,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AccountSpaceMapper.ensureInitialized().stringifyValue(
      this as AccountSpace,
    );
  }

  @override
  bool operator ==(Object other) {
    return AccountSpaceMapper.ensureInitialized().equalsValue(
      this as AccountSpace,
      other,
    );
  }

  @override
  int get hashCode {
    return AccountSpaceMapper.ensureInitialized().hashValue(
      this as AccountSpace,
    );
  }
}

extension AccountSpaceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AccountSpace, $Out> {
  AccountSpaceCopyWith<$R, AccountSpace, $Out> get $asAccountSpace =>
      $base.as((v, t, t2) => _AccountSpaceCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AccountSpaceCopyWith<$R, $In extends AccountSpace, $Out>
    implements StorageSpaceCopyWith<$R, $In, $Out> {
  @override
  $R call({UuidValue? userId});
  AccountSpaceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AccountSpaceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AccountSpace, $Out>
    implements AccountSpaceCopyWith<$R, AccountSpace, $Out> {
  _AccountSpaceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AccountSpace> $mapper =
      AccountSpaceMapper.ensureInitialized();
  @override
  $R call({UuidValue? userId}) =>
      $apply(FieldCopyWithData({if (userId != null) #userId: userId}));
  @override
  AccountSpace $make(CopyWithData data) =>
      AccountSpace(userId: data.get(#userId, or: $value.userId));

  @override
  AccountSpaceCopyWith<$R2, AccountSpace, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AccountSpaceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

