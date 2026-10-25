// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vocabulary_image_change.dart';

class VocabularyImageChangeMapper
    extends ClassMapperBase<VocabularyImageChange> {
  VocabularyImageChangeMapper._();

  static VocabularyImageChangeMapper? _instance;
  static VocabularyImageChangeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VocabularyImageChangeMapper._());
      KeepImageMapper.ensureInitialized();
      RemoveImageMapper.ensureInitialized();
      ReplaceImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'VocabularyImageChange';

  @override
  final MappableFields<VocabularyImageChange> fields = const {};

  static VocabularyImageChange _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('VocabularyImageChange');
  }

  @override
  final Function instantiate = _instantiate;

  static VocabularyImageChange fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VocabularyImageChange>(map);
  }

  static VocabularyImageChange fromJson(String json) {
    return ensureInitialized().decodeJson<VocabularyImageChange>(json);
  }
}

mixin VocabularyImageChangeMappable {
  String toJson();
  Map<String, dynamic> toMap();
  VocabularyImageChangeCopyWith<
    VocabularyImageChange,
    VocabularyImageChange,
    VocabularyImageChange
  >
  get copyWith;
}

abstract class VocabularyImageChangeCopyWith<
  $R,
  $In extends VocabularyImageChange,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  VocabularyImageChangeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class KeepImageMapper extends ClassMapperBase<KeepImage> {
  KeepImageMapper._();

  static KeepImageMapper? _instance;
  static KeepImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = KeepImageMapper._());
      VocabularyImageChangeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'KeepImage';

  @override
  final MappableFields<KeepImage> fields = const {};

  static KeepImage _instantiate(DecodingData data) {
    return KeepImage();
  }

  @override
  final Function instantiate = _instantiate;

  static KeepImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<KeepImage>(map);
  }

  static KeepImage fromJson(String json) {
    return ensureInitialized().decodeJson<KeepImage>(json);
  }
}

mixin KeepImageMappable {
  String toJson() {
    return KeepImageMapper.ensureInitialized().encodeJson<KeepImage>(
      this as KeepImage,
    );
  }

  Map<String, dynamic> toMap() {
    return KeepImageMapper.ensureInitialized().encodeMap<KeepImage>(
      this as KeepImage,
    );
  }

  KeepImageCopyWith<KeepImage, KeepImage, KeepImage> get copyWith =>
      _KeepImageCopyWithImpl<KeepImage, KeepImage>(
        this as KeepImage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return KeepImageMapper.ensureInitialized().stringifyValue(
      this as KeepImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return KeepImageMapper.ensureInitialized().equalsValue(
      this as KeepImage,
      other,
    );
  }

  @override
  int get hashCode {
    return KeepImageMapper.ensureInitialized().hashValue(this as KeepImage);
  }
}

extension KeepImageValueCopy<$R, $Out> on ObjectCopyWith<$R, KeepImage, $Out> {
  KeepImageCopyWith<$R, KeepImage, $Out> get $asKeepImage =>
      $base.as((v, t, t2) => _KeepImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class KeepImageCopyWith<$R, $In extends KeepImage, $Out>
    implements VocabularyImageChangeCopyWith<$R, $In, $Out> {
  @override
  $R call();
  KeepImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _KeepImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, KeepImage, $Out>
    implements KeepImageCopyWith<$R, KeepImage, $Out> {
  _KeepImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<KeepImage> $mapper =
      KeepImageMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  KeepImage $make(CopyWithData data) => KeepImage();

  @override
  KeepImageCopyWith<$R2, KeepImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _KeepImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemoveImageMapper extends ClassMapperBase<RemoveImage> {
  RemoveImageMapper._();

  static RemoveImageMapper? _instance;
  static RemoveImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoveImageMapper._());
      VocabularyImageChangeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RemoveImage';

  @override
  final MappableFields<RemoveImage> fields = const {};

  static RemoveImage _instantiate(DecodingData data) {
    return RemoveImage();
  }

  @override
  final Function instantiate = _instantiate;

  static RemoveImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoveImage>(map);
  }

  static RemoveImage fromJson(String json) {
    return ensureInitialized().decodeJson<RemoveImage>(json);
  }
}

mixin RemoveImageMappable {
  String toJson() {
    return RemoveImageMapper.ensureInitialized().encodeJson<RemoveImage>(
      this as RemoveImage,
    );
  }

  Map<String, dynamic> toMap() {
    return RemoveImageMapper.ensureInitialized().encodeMap<RemoveImage>(
      this as RemoveImage,
    );
  }

  RemoveImageCopyWith<RemoveImage, RemoveImage, RemoveImage> get copyWith =>
      _RemoveImageCopyWithImpl<RemoveImage, RemoveImage>(
        this as RemoveImage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return RemoveImageMapper.ensureInitialized().stringifyValue(
      this as RemoveImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoveImageMapper.ensureInitialized().equalsValue(
      this as RemoveImage,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoveImageMapper.ensureInitialized().hashValue(this as RemoveImage);
  }
}

extension RemoveImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoveImage, $Out> {
  RemoveImageCopyWith<$R, RemoveImage, $Out> get $asRemoveImage =>
      $base.as((v, t, t2) => _RemoveImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RemoveImageCopyWith<$R, $In extends RemoveImage, $Out>
    implements VocabularyImageChangeCopyWith<$R, $In, $Out> {
  @override
  $R call();
  RemoveImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RemoveImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoveImage, $Out>
    implements RemoveImageCopyWith<$R, RemoveImage, $Out> {
  _RemoveImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoveImage> $mapper =
      RemoveImageMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  RemoveImage $make(CopyWithData data) => RemoveImage();

  @override
  RemoveImageCopyWith<$R2, RemoveImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RemoveImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ReplaceImageMapper extends ClassMapperBase<ReplaceImage> {
  ReplaceImageMapper._();

  static ReplaceImageMapper? _instance;
  static ReplaceImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReplaceImageMapper._());
      VocabularyImageChangeMapper.ensureInitialized();
      ProcessedImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ReplaceImage';

  static ProcessedImage _$image(ReplaceImage v) => v.image;
  static const Field<ReplaceImage, ProcessedImage> _f$image = Field(
    'image',
    _$image,
  );

  @override
  final MappableFields<ReplaceImage> fields = const {#image: _f$image};

  static ReplaceImage _instantiate(DecodingData data) {
    return ReplaceImage(image: data.dec(_f$image));
  }

  @override
  final Function instantiate = _instantiate;

  static ReplaceImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReplaceImage>(map);
  }

  static ReplaceImage fromJson(String json) {
    return ensureInitialized().decodeJson<ReplaceImage>(json);
  }
}

mixin ReplaceImageMappable {
  String toJson() {
    return ReplaceImageMapper.ensureInitialized().encodeJson<ReplaceImage>(
      this as ReplaceImage,
    );
  }

  Map<String, dynamic> toMap() {
    return ReplaceImageMapper.ensureInitialized().encodeMap<ReplaceImage>(
      this as ReplaceImage,
    );
  }

  ReplaceImageCopyWith<ReplaceImage, ReplaceImage, ReplaceImage> get copyWith =>
      _ReplaceImageCopyWithImpl<ReplaceImage, ReplaceImage>(
        this as ReplaceImage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ReplaceImageMapper.ensureInitialized().stringifyValue(
      this as ReplaceImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return ReplaceImageMapper.ensureInitialized().equalsValue(
      this as ReplaceImage,
      other,
    );
  }

  @override
  int get hashCode {
    return ReplaceImageMapper.ensureInitialized().hashValue(
      this as ReplaceImage,
    );
  }
}

extension ReplaceImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReplaceImage, $Out> {
  ReplaceImageCopyWith<$R, ReplaceImage, $Out> get $asReplaceImage =>
      $base.as((v, t, t2) => _ReplaceImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ReplaceImageCopyWith<$R, $In extends ReplaceImage, $Out>
    implements VocabularyImageChangeCopyWith<$R, $In, $Out> {
  ProcessedImageCopyWith<$R, ProcessedImage, ProcessedImage> get image;
  @override
  $R call({ProcessedImage? image});
  ReplaceImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReplaceImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReplaceImage, $Out>
    implements ReplaceImageCopyWith<$R, ReplaceImage, $Out> {
  _ReplaceImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReplaceImage> $mapper =
      ReplaceImageMapper.ensureInitialized();
  @override
  ProcessedImageCopyWith<$R, ProcessedImage, ProcessedImage> get image =>
      $value.image.copyWith.$chain((v) => call(image: v));
  @override
  $R call({ProcessedImage? image}) =>
      $apply(FieldCopyWithData({if (image != null) #image: image}));
  @override
  ReplaceImage $make(CopyWithData data) =>
      ReplaceImage(image: data.get(#image, or: $value.image));

  @override
  ReplaceImageCopyWith<$R2, ReplaceImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ReplaceImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

