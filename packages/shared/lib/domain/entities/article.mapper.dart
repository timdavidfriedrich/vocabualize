// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'article.dart';

class ArticleStatusMapper extends EnumMapper<ArticleStatus> {
  ArticleStatusMapper._();

  static ArticleStatusMapper? _instance;
  static ArticleStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ArticleStatusMapper._());
    }
    return _instance!;
  }

  static ArticleStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ArticleStatus decode(dynamic value) {
    switch (value) {
      case r'draft':
        return ArticleStatus.draft;
      case r'published':
        return ArticleStatus.published;
      case r'unknown':
        return ArticleStatus.unknown;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ArticleStatus self) {
    switch (self) {
      case ArticleStatus.draft:
        return r'draft';
      case ArticleStatus.published:
        return r'published';
      case ArticleStatus.unknown:
        return r'unknown';
    }
  }
}

extension ArticleStatusMapperExtension on ArticleStatus {
  String toValue() {
    ArticleStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ArticleStatus>(this) as String;
  }
}

class ArticleMapper extends ClassMapperBase<Article> {
  ArticleMapper._();

  static ArticleMapper? _instance;
  static ArticleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ArticleMapper._());
      ArticleStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Article';

  static String _$id(Article v) => v.id;
  static const Field<Article, String> _f$id = Field('id', _$id);
  static String _$title(Article v) => v.title;
  static const Field<Article, String> _f$title = Field('title', _$title);
  static ArticleStatus _$status(Article v) => v.status;
  static const Field<Article, ArticleStatus> _f$status = Field(
    'status',
    _$status,
  );

  @override
  final MappableFields<Article> fields = const {
    #id: _f$id,
    #title: _f$title,
    #status: _f$status,
  };

  static Article _instantiate(DecodingData data) {
    return Article(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      status: data.dec(_f$status),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Article fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Article>(map);
  }

  static Article fromJson(String json) {
    return ensureInitialized().decodeJson<Article>(json);
  }
}

mixin ArticleMappable {
  String toJson() {
    return ArticleMapper.ensureInitialized().encodeJson<Article>(
      this as Article,
    );
  }

  Map<String, dynamic> toMap() {
    return ArticleMapper.ensureInitialized().encodeMap<Article>(
      this as Article,
    );
  }

  ArticleCopyWith<Article, Article, Article> get copyWith =>
      _ArticleCopyWithImpl<Article, Article>(
        this as Article,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ArticleMapper.ensureInitialized().stringifyValue(this as Article);
  }

  @override
  bool operator ==(Object other) {
    return ArticleMapper.ensureInitialized().equalsValue(
      this as Article,
      other,
    );
  }

  @override
  int get hashCode {
    return ArticleMapper.ensureInitialized().hashValue(this as Article);
  }
}

extension ArticleValueCopy<$R, $Out> on ObjectCopyWith<$R, Article, $Out> {
  ArticleCopyWith<$R, Article, $Out> get $asArticle =>
      $base.as((v, t, t2) => _ArticleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ArticleCopyWith<$R, $In extends Article, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? title, ArticleStatus? status});
  ArticleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ArticleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Article, $Out>
    implements ArticleCopyWith<$R, Article, $Out> {
  _ArticleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Article> $mapper =
      ArticleMapper.ensureInitialized();
  @override
  $R call({String? id, String? title, ArticleStatus? status}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (status != null) #status: status,
    }),
  );
  @override
  Article $make(CopyWithData data) => Article(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    status: data.get(#status, or: $value.status),
  );

  @override
  ArticleCopyWith<$R2, Article, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ArticleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

