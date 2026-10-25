// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'collection_preview.dart';

class CollectionPreviewMapper extends ClassMapperBase<CollectionPreview> {
  CollectionPreviewMapper._();

  static CollectionPreviewMapper? _instance;
  static CollectionPreviewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CollectionPreviewMapper._());
      TagMapper.ensureInitialized();
      VocabularyImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CollectionPreview';

  static Tag _$tag(CollectionPreview v) => v.tag;
  static const Field<CollectionPreview, Tag> _f$tag = Field('tag', _$tag);
  static List<VocabularyImage> _$images(CollectionPreview v) => v.images;
  static const Field<CollectionPreview, List<VocabularyImage>> _f$images =
      Field('images', _$images);

  @override
  final MappableFields<CollectionPreview> fields = const {
    #tag: _f$tag,
    #images: _f$images,
  };

  static CollectionPreview _instantiate(DecodingData data) {
    return CollectionPreview(
      tag: data.dec(_f$tag),
      images: data.dec(_f$images),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CollectionPreview fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CollectionPreview>(map);
  }

  static CollectionPreview fromJson(String json) {
    return ensureInitialized().decodeJson<CollectionPreview>(json);
  }
}

mixin CollectionPreviewMappable {
  String toJson() {
    return CollectionPreviewMapper.ensureInitialized()
        .encodeJson<CollectionPreview>(this as CollectionPreview);
  }

  Map<String, dynamic> toMap() {
    return CollectionPreviewMapper.ensureInitialized()
        .encodeMap<CollectionPreview>(this as CollectionPreview);
  }

  CollectionPreviewCopyWith<
    CollectionPreview,
    CollectionPreview,
    CollectionPreview
  >
  get copyWith =>
      _CollectionPreviewCopyWithImpl<CollectionPreview, CollectionPreview>(
        this as CollectionPreview,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CollectionPreviewMapper.ensureInitialized().stringifyValue(
      this as CollectionPreview,
    );
  }

  @override
  bool operator ==(Object other) {
    return CollectionPreviewMapper.ensureInitialized().equalsValue(
      this as CollectionPreview,
      other,
    );
  }

  @override
  int get hashCode {
    return CollectionPreviewMapper.ensureInitialized().hashValue(
      this as CollectionPreview,
    );
  }
}

extension CollectionPreviewValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CollectionPreview, $Out> {
  CollectionPreviewCopyWith<$R, CollectionPreview, $Out>
  get $asCollectionPreview => $base.as(
    (v, t, t2) => _CollectionPreviewCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CollectionPreviewCopyWith<
  $R,
  $In extends CollectionPreview,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  TagCopyWith<$R, Tag, Tag> get tag;
  ListCopyWith<
    $R,
    VocabularyImage,
    VocabularyImageCopyWith<$R, VocabularyImage, VocabularyImage>
  >
  get images;
  $R call({Tag? tag, List<VocabularyImage>? images});
  CollectionPreviewCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CollectionPreviewCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CollectionPreview, $Out>
    implements CollectionPreviewCopyWith<$R, CollectionPreview, $Out> {
  _CollectionPreviewCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CollectionPreview> $mapper =
      CollectionPreviewMapper.ensureInitialized();
  @override
  TagCopyWith<$R, Tag, Tag> get tag =>
      $value.tag.copyWith.$chain((v) => call(tag: v));
  @override
  ListCopyWith<
    $R,
    VocabularyImage,
    VocabularyImageCopyWith<$R, VocabularyImage, VocabularyImage>
  >
  get images => ListCopyWith(
    $value.images,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(images: v),
  );
  @override
  $R call({Tag? tag, List<VocabularyImage>? images}) => $apply(
    FieldCopyWithData({
      if (tag != null) #tag: tag,
      if (images != null) #images: images,
    }),
  );
  @override
  CollectionPreview $make(CopyWithData data) => CollectionPreview(
    tag: data.get(#tag, or: $value.tag),
    images: data.get(#images, or: $value.images),
  );

  @override
  CollectionPreviewCopyWith<$R2, CollectionPreview, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CollectionPreviewCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

