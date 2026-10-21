// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_article.dart';

class LocalArticleMapper extends ClassMapperBase<LocalArticle> {
  LocalArticleMapper._();

  static LocalArticleMapper? _instance;
  static LocalArticleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalArticleMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalArticle';

  static String _$id(LocalArticle v) => v.id;
  static const Field<LocalArticle, String> _f$id = Field('id', _$id);
  static String _$title(LocalArticle v) => v.title;
  static const Field<LocalArticle, String> _f$title = Field('title', _$title);
  static String _$status(LocalArticle v) => v.status;
  static const Field<LocalArticle, String> _f$status = Field(
    'status',
    _$status,
  );

  @override
  final MappableFields<LocalArticle> fields = const {
    #id: _f$id,
    #title: _f$title,
    #status: _f$status,
  };

  static LocalArticle _instantiate(DecodingData data) {
    return LocalArticle(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      status: data.dec(_f$status),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalArticle fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalArticle>(map);
  }

  static LocalArticle fromJson(String json) {
    return ensureInitialized().decodeJson<LocalArticle>(json);
  }
}

mixin LocalArticleMappable {
  String toJson() {
    return LocalArticleMapper.ensureInitialized().encodeJson<LocalArticle>(
      this as LocalArticle,
    );
  }

  Map<String, dynamic> toMap() {
    return LocalArticleMapper.ensureInitialized().encodeMap<LocalArticle>(
      this as LocalArticle,
    );
  }

  LocalArticleCopyWith<LocalArticle, LocalArticle, LocalArticle> get copyWith =>
      _LocalArticleCopyWithImpl<LocalArticle, LocalArticle>(
        this as LocalArticle,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LocalArticleMapper.ensureInitialized().stringifyValue(
      this as LocalArticle,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalArticleMapper.ensureInitialized().equalsValue(
      this as LocalArticle,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalArticleMapper.ensureInitialized().hashValue(
      this as LocalArticle,
    );
  }
}

extension LocalArticleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalArticle, $Out> {
  LocalArticleCopyWith<$R, LocalArticle, $Out> get $asLocalArticle =>
      $base.as((v, t, t2) => _LocalArticleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocalArticleCopyWith<$R, $In extends LocalArticle, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? title, String? status});
  LocalArticleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocalArticleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalArticle, $Out>
    implements LocalArticleCopyWith<$R, LocalArticle, $Out> {
  _LocalArticleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalArticle> $mapper =
      LocalArticleMapper.ensureInitialized();
  @override
  $R call({String? id, String? title, String? status}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (status != null) #status: status,
    }),
  );
  @override
  LocalArticle $make(CopyWithData data) => LocalArticle(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    status: data.get(#status, or: $value.status),
  );

  @override
  LocalArticleCopyWith<$R2, LocalArticle, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocalArticleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

