// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vocabulary_image.dart';

class VocabularyImageMapper extends ClassMapperBase<VocabularyImage> {
  VocabularyImageMapper._();

  static VocabularyImageMapper? _instance;
  static VocabularyImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VocabularyImageMapper._());
      NoImageMapper.ensureInitialized();
      CustomImageMapper.ensureInitialized();
      StockImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'VocabularyImage';

  @override
  final MappableFields<VocabularyImage> fields = const {};

  static VocabularyImage _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('VocabularyImage');
  }

  @override
  final Function instantiate = _instantiate;

  static VocabularyImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VocabularyImage>(map);
  }

  static VocabularyImage fromJson(String json) {
    return ensureInitialized().decodeJson<VocabularyImage>(json);
  }
}

mixin VocabularyImageMappable {
  String toJson();
  Map<String, dynamic> toMap();
  VocabularyImageCopyWith<VocabularyImage, VocabularyImage, VocabularyImage>
  get copyWith;
}

abstract class VocabularyImageCopyWith<$R, $In extends VocabularyImage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  VocabularyImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class NoImageMapper extends ClassMapperBase<NoImage> {
  NoImageMapper._();

  static NoImageMapper? _instance;
  static NoImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoImageMapper._());
      VocabularyImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NoImage';

  @override
  final MappableFields<NoImage> fields = const {};

  static NoImage _instantiate(DecodingData data) {
    return NoImage();
  }

  @override
  final Function instantiate = _instantiate;

  static NoImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NoImage>(map);
  }

  static NoImage fromJson(String json) {
    return ensureInitialized().decodeJson<NoImage>(json);
  }
}

mixin NoImageMappable {
  String toJson() {
    return NoImageMapper.ensureInitialized().encodeJson<NoImage>(
      this as NoImage,
    );
  }

  Map<String, dynamic> toMap() {
    return NoImageMapper.ensureInitialized().encodeMap<NoImage>(
      this as NoImage,
    );
  }

  NoImageCopyWith<NoImage, NoImage, NoImage> get copyWith =>
      _NoImageCopyWithImpl<NoImage, NoImage>(
        this as NoImage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return NoImageMapper.ensureInitialized().stringifyValue(this as NoImage);
  }

  @override
  bool operator ==(Object other) {
    return NoImageMapper.ensureInitialized().equalsValue(
      this as NoImage,
      other,
    );
  }

  @override
  int get hashCode {
    return NoImageMapper.ensureInitialized().hashValue(this as NoImage);
  }
}

extension NoImageValueCopy<$R, $Out> on ObjectCopyWith<$R, NoImage, $Out> {
  NoImageCopyWith<$R, NoImage, $Out> get $asNoImage =>
      $base.as((v, t, t2) => _NoImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NoImageCopyWith<$R, $In extends NoImage, $Out>
    implements VocabularyImageCopyWith<$R, $In, $Out> {
  @override
  $R call();
  NoImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NoImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NoImage, $Out>
    implements NoImageCopyWith<$R, NoImage, $Out> {
  _NoImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NoImage> $mapper =
      NoImageMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  NoImage $make(CopyWithData data) => NoImage();

  @override
  NoImageCopyWith<$R2, NoImage, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NoImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CustomImageMapper extends ClassMapperBase<CustomImage> {
  CustomImageMapper._();

  static CustomImageMapper? _instance;
  static CustomImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomImageMapper._());
      VocabularyImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CustomImage';

  static String _$imageId(CustomImage v) => v.imageId;
  static const Field<CustomImage, String> _f$imageId = Field(
    'imageId',
    _$imageId,
  );

  @override
  final MappableFields<CustomImage> fields = const {#imageId: _f$imageId};

  static CustomImage _instantiate(DecodingData data) {
    return CustomImage(imageId: data.dec(_f$imageId));
  }

  @override
  final Function instantiate = _instantiate;

  static CustomImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomImage>(map);
  }

  static CustomImage fromJson(String json) {
    return ensureInitialized().decodeJson<CustomImage>(json);
  }
}

mixin CustomImageMappable {
  String toJson() {
    return CustomImageMapper.ensureInitialized().encodeJson<CustomImage>(
      this as CustomImage,
    );
  }

  Map<String, dynamic> toMap() {
    return CustomImageMapper.ensureInitialized().encodeMap<CustomImage>(
      this as CustomImage,
    );
  }

  CustomImageCopyWith<CustomImage, CustomImage, CustomImage> get copyWith =>
      _CustomImageCopyWithImpl<CustomImage, CustomImage>(
        this as CustomImage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CustomImageMapper.ensureInitialized().stringifyValue(
      this as CustomImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return CustomImageMapper.ensureInitialized().equalsValue(
      this as CustomImage,
      other,
    );
  }

  @override
  int get hashCode {
    return CustomImageMapper.ensureInitialized().hashValue(this as CustomImage);
  }
}

extension CustomImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CustomImage, $Out> {
  CustomImageCopyWith<$R, CustomImage, $Out> get $asCustomImage =>
      $base.as((v, t, t2) => _CustomImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CustomImageCopyWith<$R, $In extends CustomImage, $Out>
    implements VocabularyImageCopyWith<$R, $In, $Out> {
  @override
  $R call({String? imageId});
  CustomImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CustomImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CustomImage, $Out>
    implements CustomImageCopyWith<$R, CustomImage, $Out> {
  _CustomImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CustomImage> $mapper =
      CustomImageMapper.ensureInitialized();
  @override
  $R call({String? imageId}) =>
      $apply(FieldCopyWithData({if (imageId != null) #imageId: imageId}));
  @override
  CustomImage $make(CopyWithData data) =>
      CustomImage(imageId: data.get(#imageId, or: $value.imageId));

  @override
  CustomImageCopyWith<$R2, CustomImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CustomImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class StockImageMapper extends ClassMapperBase<StockImage> {
  StockImageMapper._();

  static StockImageMapper? _instance;
  static StockImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StockImageMapper._());
      VocabularyImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StockImage';

  static String _$id(StockImage v) => v.id;
  static const Field<StockImage, String> _f$id = Field('id', _$id);
  static String _$url(StockImage v) => v.url;
  static const Field<StockImage, String> _f$url = Field('url', _$url);
  static String _$thumbUrl(StockImage v) => v.thumbUrl;
  static const Field<StockImage, String> _f$thumbUrl = Field(
    'thumbUrl',
    _$thumbUrl,
  );
  static String? _$photographer(StockImage v) => v.photographer;
  static const Field<StockImage, String> _f$photographer = Field(
    'photographer',
    _$photographer,
  );
  static String? _$photographerUrl(StockImage v) => v.photographerUrl;
  static const Field<StockImage, String> _f$photographerUrl = Field(
    'photographerUrl',
    _$photographerUrl,
  );

  @override
  final MappableFields<StockImage> fields = const {
    #id: _f$id,
    #url: _f$url,
    #thumbUrl: _f$thumbUrl,
    #photographer: _f$photographer,
    #photographerUrl: _f$photographerUrl,
  };

  static StockImage _instantiate(DecodingData data) {
    return StockImage(
      id: data.dec(_f$id),
      url: data.dec(_f$url),
      thumbUrl: data.dec(_f$thumbUrl),
      photographer: data.dec(_f$photographer),
      photographerUrl: data.dec(_f$photographerUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StockImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StockImage>(map);
  }

  static StockImage fromJson(String json) {
    return ensureInitialized().decodeJson<StockImage>(json);
  }
}

mixin StockImageMappable {
  String toJson() {
    return StockImageMapper.ensureInitialized().encodeJson<StockImage>(
      this as StockImage,
    );
  }

  Map<String, dynamic> toMap() {
    return StockImageMapper.ensureInitialized().encodeMap<StockImage>(
      this as StockImage,
    );
  }

  StockImageCopyWith<StockImage, StockImage, StockImage> get copyWith =>
      _StockImageCopyWithImpl<StockImage, StockImage>(
        this as StockImage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return StockImageMapper.ensureInitialized().stringifyValue(
      this as StockImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return StockImageMapper.ensureInitialized().equalsValue(
      this as StockImage,
      other,
    );
  }

  @override
  int get hashCode {
    return StockImageMapper.ensureInitialized().hashValue(this as StockImage);
  }
}

extension StockImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StockImage, $Out> {
  StockImageCopyWith<$R, StockImage, $Out> get $asStockImage =>
      $base.as((v, t, t2) => _StockImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StockImageCopyWith<$R, $In extends StockImage, $Out>
    implements VocabularyImageCopyWith<$R, $In, $Out> {
  @override
  $R call({
    String? id,
    String? url,
    String? thumbUrl,
    String? photographer,
    String? photographerUrl,
  });
  StockImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StockImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StockImage, $Out>
    implements StockImageCopyWith<$R, StockImage, $Out> {
  _StockImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StockImage> $mapper =
      StockImageMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? url,
    String? thumbUrl,
    Object? photographer = $none,
    Object? photographerUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (url != null) #url: url,
      if (thumbUrl != null) #thumbUrl: thumbUrl,
      if (photographer != $none) #photographer: photographer,
      if (photographerUrl != $none) #photographerUrl: photographerUrl,
    }),
  );
  @override
  StockImage $make(CopyWithData data) => StockImage(
    id: data.get(#id, or: $value.id),
    url: data.get(#url, or: $value.url),
    thumbUrl: data.get(#thumbUrl, or: $value.thumbUrl),
    photographer: data.get(#photographer, or: $value.photographer),
    photographerUrl: data.get(#photographerUrl, or: $value.photographerUrl),
  );

  @override
  StockImageCopyWith<$R2, StockImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StockImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

