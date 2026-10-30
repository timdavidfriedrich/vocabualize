// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'image_label.dart';

class ImageLabelMapper extends ClassMapperBase<ImageLabel> {
  ImageLabelMapper._();

  static ImageLabelMapper? _instance;
  static ImageLabelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageLabelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ImageLabel';

  static String _$text(ImageLabel v) => v.text;
  static const Field<ImageLabel, String> _f$text = Field('text', _$text);
  static String _$context(ImageLabel v) => v.context;
  static const Field<ImageLabel, String> _f$context = Field(
    'context',
    _$context,
  );

  @override
  final MappableFields<ImageLabel> fields = const {
    #text: _f$text,
    #context: _f$context,
  };

  static ImageLabel _instantiate(DecodingData data) {
    return ImageLabel(text: data.dec(_f$text), context: data.dec(_f$context));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageLabel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageLabel>(map);
  }

  static ImageLabel fromJson(String json) {
    return ensureInitialized().decodeJson<ImageLabel>(json);
  }
}

mixin ImageLabelMappable {
  String toJson() {
    return ImageLabelMapper.ensureInitialized().encodeJson<ImageLabel>(
      this as ImageLabel,
    );
  }

  Map<String, dynamic> toMap() {
    return ImageLabelMapper.ensureInitialized().encodeMap<ImageLabel>(
      this as ImageLabel,
    );
  }

  ImageLabelCopyWith<ImageLabel, ImageLabel, ImageLabel> get copyWith =>
      _ImageLabelCopyWithImpl<ImageLabel, ImageLabel>(
        this as ImageLabel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ImageLabelMapper.ensureInitialized().stringifyValue(
      this as ImageLabel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ImageLabelMapper.ensureInitialized().equalsValue(
      this as ImageLabel,
      other,
    );
  }

  @override
  int get hashCode {
    return ImageLabelMapper.ensureInitialized().hashValue(this as ImageLabel);
  }
}

extension ImageLabelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageLabel, $Out> {
  ImageLabelCopyWith<$R, ImageLabel, $Out> get $asImageLabel =>
      $base.as((v, t, t2) => _ImageLabelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ImageLabelCopyWith<$R, $In extends ImageLabel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? text, String? context});
  ImageLabelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageLabelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageLabel, $Out>
    implements ImageLabelCopyWith<$R, ImageLabel, $Out> {
  _ImageLabelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageLabel> $mapper =
      ImageLabelMapper.ensureInitialized();
  @override
  $R call({String? text, String? context}) => $apply(
    FieldCopyWithData({
      if (text != null) #text: text,
      if (context != null) #context: context,
    }),
  );
  @override
  ImageLabel $make(CopyWithData data) => ImageLabel(
    text: data.get(#text, or: $value.text),
    context: data.get(#context, or: $value.context),
  );

  @override
  ImageLabelCopyWith<$R2, ImageLabel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ImageLabelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

