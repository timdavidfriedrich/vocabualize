// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'image_crop.dart';

class ImageCropMapper extends ClassMapperBase<ImageCrop> {
  ImageCropMapper._();

  static ImageCropMapper? _instance;
  static ImageCropMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageCropMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ImageCrop';

  static double _$left(ImageCrop v) => v.left;
  static const Field<ImageCrop, double> _f$left = Field('left', _$left);
  static double _$top(ImageCrop v) => v.top;
  static const Field<ImageCrop, double> _f$top = Field('top', _$top);
  static double _$width(ImageCrop v) => v.width;
  static const Field<ImageCrop, double> _f$width = Field('width', _$width);
  static double _$height(ImageCrop v) => v.height;
  static const Field<ImageCrop, double> _f$height = Field('height', _$height);

  @override
  final MappableFields<ImageCrop> fields = const {
    #left: _f$left,
    #top: _f$top,
    #width: _f$width,
    #height: _f$height,
  };

  static ImageCrop _instantiate(DecodingData data) {
    return ImageCrop(
      left: data.dec(_f$left),
      top: data.dec(_f$top),
      width: data.dec(_f$width),
      height: data.dec(_f$height),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ImageCrop fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageCrop>(map);
  }

  static ImageCrop fromJson(String json) {
    return ensureInitialized().decodeJson<ImageCrop>(json);
  }
}

mixin ImageCropMappable {
  String toJson() {
    return ImageCropMapper.ensureInitialized().encodeJson<ImageCrop>(
      this as ImageCrop,
    );
  }

  Map<String, dynamic> toMap() {
    return ImageCropMapper.ensureInitialized().encodeMap<ImageCrop>(
      this as ImageCrop,
    );
  }

  ImageCropCopyWith<ImageCrop, ImageCrop, ImageCrop> get copyWith =>
      _ImageCropCopyWithImpl<ImageCrop, ImageCrop>(
        this as ImageCrop,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ImageCropMapper.ensureInitialized().stringifyValue(
      this as ImageCrop,
    );
  }

  @override
  bool operator ==(Object other) {
    return ImageCropMapper.ensureInitialized().equalsValue(
      this as ImageCrop,
      other,
    );
  }

  @override
  int get hashCode {
    return ImageCropMapper.ensureInitialized().hashValue(this as ImageCrop);
  }
}

extension ImageCropValueCopy<$R, $Out> on ObjectCopyWith<$R, ImageCrop, $Out> {
  ImageCropCopyWith<$R, ImageCrop, $Out> get $asImageCrop =>
      $base.as((v, t, t2) => _ImageCropCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ImageCropCopyWith<$R, $In extends ImageCrop, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? left, double? top, double? width, double? height});
  ImageCropCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageCropCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageCrop, $Out>
    implements ImageCropCopyWith<$R, ImageCrop, $Out> {
  _ImageCropCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageCrop> $mapper =
      ImageCropMapper.ensureInitialized();
  @override
  $R call({double? left, double? top, double? width, double? height}) => $apply(
    FieldCopyWithData({
      if (left != null) #left: left,
      if (top != null) #top: top,
      if (width != null) #width: width,
      if (height != null) #height: height,
    }),
  );
  @override
  ImageCrop $make(CopyWithData data) => ImageCrop(
    left: data.get(#left, or: $value.left),
    top: data.get(#top, or: $value.top),
    width: data.get(#width, or: $value.width),
    height: data.get(#height, or: $value.height),
  );

  @override
  ImageCropCopyWith<$R2, ImageCrop, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ImageCropCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

