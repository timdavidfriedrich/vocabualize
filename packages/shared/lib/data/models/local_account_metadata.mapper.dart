// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_account_metadata.dart';

class LocalAccountMetadataMapper extends ClassMapperBase<LocalAccountMetadata> {
  LocalAccountMetadataMapper._();

  static LocalAccountMetadataMapper? _instance;
  static LocalAccountMetadataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalAccountMetadataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalAccountMetadata';

  static String _$accountId(LocalAccountMetadata v) => v.accountId;
  static const Field<LocalAccountMetadata, String> _f$accountId = Field(
    'accountId',
    _$accountId,
  );
  static String? _$name(LocalAccountMetadata v) => v.name;
  static const Field<LocalAccountMetadata, String> _f$name = Field(
    'name',
    _$name,
  );
  static String? _$email(LocalAccountMetadata v) => v.email;
  static const Field<LocalAccountMetadata, String> _f$email = Field(
    'email',
    _$email,
  );
  static String? _$pictureUrl(LocalAccountMetadata v) => v.pictureUrl;
  static const Field<LocalAccountMetadata, String> _f$pictureUrl = Field(
    'pictureUrl',
    _$pictureUrl,
  );
  static String? _$pictureFileName(LocalAccountMetadata v) => v.pictureFileName;
  static const Field<LocalAccountMetadata, String> _f$pictureFileName = Field(
    'pictureFileName',
    _$pictureFileName,
  );
  static bool _$hasCompletedInitialSync(LocalAccountMetadata v) =>
      v.hasCompletedInitialSync;
  static const Field<LocalAccountMetadata, bool> _f$hasCompletedInitialSync =
      Field('hasCompletedInitialSync', _$hasCompletedInitialSync);

  @override
  final MappableFields<LocalAccountMetadata> fields = const {
    #accountId: _f$accountId,
    #name: _f$name,
    #email: _f$email,
    #pictureUrl: _f$pictureUrl,
    #pictureFileName: _f$pictureFileName,
    #hasCompletedInitialSync: _f$hasCompletedInitialSync,
  };

  static LocalAccountMetadata _instantiate(DecodingData data) {
    return LocalAccountMetadata(
      accountId: data.dec(_f$accountId),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      pictureUrl: data.dec(_f$pictureUrl),
      pictureFileName: data.dec(_f$pictureFileName),
      hasCompletedInitialSync: data.dec(_f$hasCompletedInitialSync),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalAccountMetadata fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalAccountMetadata>(map);
  }

  static LocalAccountMetadata fromJson(String json) {
    return ensureInitialized().decodeJson<LocalAccountMetadata>(json);
  }
}

mixin LocalAccountMetadataMappable {
  String toJson() {
    return LocalAccountMetadataMapper.ensureInitialized()
        .encodeJson<LocalAccountMetadata>(this as LocalAccountMetadata);
  }

  Map<String, dynamic> toMap() {
    return LocalAccountMetadataMapper.ensureInitialized()
        .encodeMap<LocalAccountMetadata>(this as LocalAccountMetadata);
  }

  LocalAccountMetadataCopyWith<
    LocalAccountMetadata,
    LocalAccountMetadata,
    LocalAccountMetadata
  >
  get copyWith =>
      _LocalAccountMetadataCopyWithImpl<
        LocalAccountMetadata,
        LocalAccountMetadata
      >(this as LocalAccountMetadata, $identity, $identity);
  @override
  String toString() {
    return LocalAccountMetadataMapper.ensureInitialized().stringifyValue(
      this as LocalAccountMetadata,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalAccountMetadataMapper.ensureInitialized().equalsValue(
      this as LocalAccountMetadata,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalAccountMetadataMapper.ensureInitialized().hashValue(
      this as LocalAccountMetadata,
    );
  }
}

extension LocalAccountMetadataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalAccountMetadata, $Out> {
  LocalAccountMetadataCopyWith<$R, LocalAccountMetadata, $Out>
  get $asLocalAccountMetadata => $base.as(
    (v, t, t2) => _LocalAccountMetadataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalAccountMetadataCopyWith<
  $R,
  $In extends LocalAccountMetadata,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? accountId,
    String? name,
    String? email,
    String? pictureUrl,
    String? pictureFileName,
    bool? hasCompletedInitialSync,
  });
  LocalAccountMetadataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalAccountMetadataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalAccountMetadata, $Out>
    implements LocalAccountMetadataCopyWith<$R, LocalAccountMetadata, $Out> {
  _LocalAccountMetadataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalAccountMetadata> $mapper =
      LocalAccountMetadataMapper.ensureInitialized();
  @override
  $R call({
    String? accountId,
    Object? name = $none,
    Object? email = $none,
    Object? pictureUrl = $none,
    Object? pictureFileName = $none,
    bool? hasCompletedInitialSync,
  }) => $apply(
    FieldCopyWithData({
      if (accountId != null) #accountId: accountId,
      if (name != $none) #name: name,
      if (email != $none) #email: email,
      if (pictureUrl != $none) #pictureUrl: pictureUrl,
      if (pictureFileName != $none) #pictureFileName: pictureFileName,
      if (hasCompletedInitialSync != null)
        #hasCompletedInitialSync: hasCompletedInitialSync,
    }),
  );
  @override
  LocalAccountMetadata $make(CopyWithData data) => LocalAccountMetadata(
    accountId: data.get(#accountId, or: $value.accountId),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    pictureUrl: data.get(#pictureUrl, or: $value.pictureUrl),
    pictureFileName: data.get(#pictureFileName, or: $value.pictureFileName),
    hasCompletedInitialSync: data.get(
      #hasCompletedInitialSync,
      or: $value.hasCompletedInitialSync,
    ),
  );

  @override
  LocalAccountMetadataCopyWith<$R2, LocalAccountMetadata, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalAccountMetadataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

