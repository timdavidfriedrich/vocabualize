// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'processed_image.dart';

class ProcessedImageMapper extends ClassMapperBase<ProcessedImage> {
  ProcessedImageMapper._();

  static ProcessedImageMapper? _instance;
  static ProcessedImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProcessedImageMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProcessedImage';

  static Uint8List _$fullBytes(ProcessedImage v) => v.fullBytes;
  static const Field<ProcessedImage, Uint8List> _f$fullBytes = Field(
    'fullBytes',
    _$fullBytes,
  );
  static Uint8List _$thumbnailBytes(ProcessedImage v) => v.thumbnailBytes;
  static const Field<ProcessedImage, Uint8List> _f$thumbnailBytes = Field(
    'thumbnailBytes',
    _$thumbnailBytes,
  );
  static String? _$photographer(ProcessedImage v) => v.photographer;
  static const Field<ProcessedImage, String> _f$photographer = Field(
    'photographer',
    _$photographer,
  );
  static String? _$photographerUrl(ProcessedImage v) => v.photographerUrl;
  static const Field<ProcessedImage, String> _f$photographerUrl = Field(
    'photographerUrl',
    _$photographerUrl,
  );

  @override
  final MappableFields<ProcessedImage> fields = const {
    #fullBytes: _f$fullBytes,
    #thumbnailBytes: _f$thumbnailBytes,
    #photographer: _f$photographer,
    #photographerUrl: _f$photographerUrl,
  };

  static ProcessedImage _instantiate(DecodingData data) {
    return ProcessedImage(
      fullBytes: data.dec(_f$fullBytes),
      thumbnailBytes: data.dec(_f$thumbnailBytes),
      photographer: data.dec(_f$photographer),
      photographerUrl: data.dec(_f$photographerUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProcessedImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProcessedImage>(map);
  }

  static ProcessedImage fromJson(String json) {
    return ensureInitialized().decodeJson<ProcessedImage>(json);
  }
}

mixin ProcessedImageMappable {
  String toJson() {
    return ProcessedImageMapper.ensureInitialized().encodeJson<ProcessedImage>(
      this as ProcessedImage,
    );
  }

  Map<String, dynamic> toMap() {
    return ProcessedImageMapper.ensureInitialized().encodeMap<ProcessedImage>(
      this as ProcessedImage,
    );
  }

  ProcessedImageCopyWith<ProcessedImage, ProcessedImage, ProcessedImage>
  get copyWith => _ProcessedImageCopyWithImpl<ProcessedImage, ProcessedImage>(
    this as ProcessedImage,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ProcessedImageMapper.ensureInitialized().stringifyValue(
      this as ProcessedImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProcessedImageMapper.ensureInitialized().equalsValue(
      this as ProcessedImage,
      other,
    );
  }

  @override
  int get hashCode {
    return ProcessedImageMapper.ensureInitialized().hashValue(
      this as ProcessedImage,
    );
  }
}

extension ProcessedImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProcessedImage, $Out> {
  ProcessedImageCopyWith<$R, ProcessedImage, $Out> get $asProcessedImage =>
      $base.as((v, t, t2) => _ProcessedImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProcessedImageCopyWith<$R, $In extends ProcessedImage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Uint8List? fullBytes,
    Uint8List? thumbnailBytes,
    String? photographer,
    String? photographerUrl,
  });
  ProcessedImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProcessedImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProcessedImage, $Out>
    implements ProcessedImageCopyWith<$R, ProcessedImage, $Out> {
  _ProcessedImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProcessedImage> $mapper =
      ProcessedImageMapper.ensureInitialized();
  @override
  $R call({
    Uint8List? fullBytes,
    Uint8List? thumbnailBytes,
    Object? photographer = $none,
    Object? photographerUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (fullBytes != null) #fullBytes: fullBytes,
      if (thumbnailBytes != null) #thumbnailBytes: thumbnailBytes,
      if (photographer != $none) #photographer: photographer,
      if (photographerUrl != $none) #photographerUrl: photographerUrl,
    }),
  );
  @override
  ProcessedImage $make(CopyWithData data) => ProcessedImage(
    fullBytes: data.get(#fullBytes, or: $value.fullBytes),
    thumbnailBytes: data.get(#thumbnailBytes, or: $value.thumbnailBytes),
    photographer: data.get(#photographer, or: $value.photographer),
    photographerUrl: data.get(#photographerUrl, or: $value.photographerUrl),
  );

  @override
  ProcessedImageCopyWith<$R2, ProcessedImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProcessedImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

