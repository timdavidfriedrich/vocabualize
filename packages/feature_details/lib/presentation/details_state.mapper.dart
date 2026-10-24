// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'details_state.dart';

class DetailsStateMapper extends ClassMapperBase<DetailsState> {
  DetailsStateMapper._();

  static DetailsStateMapper? _instance;
  static DetailsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsStateMapper._());
      DetailsEditingMapper.ensureInitialized();
      DetailsSavedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsState';

  @override
  final MappableFields<DetailsState> fields = const {};

  static DetailsState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('DetailsState');
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsState>(map);
  }

  static DetailsState fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsState>(json);
  }
}

mixin DetailsStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  DetailsStateCopyWith<DetailsState, DetailsState, DetailsState> get copyWith;
}

abstract class DetailsStateCopyWith<$R, $In extends DetailsState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  DetailsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class DetailsEditingMapper extends ClassMapperBase<DetailsEditing> {
  DetailsEditingMapper._();

  static DetailsEditingMapper? _instance;
  static DetailsEditingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsEditingMapper._());
      DetailsStateMapper.ensureInitialized();
      ProcessedImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsEditing';

  static ProcessedImage? _$image(DetailsEditing v) => v.image;
  static const Field<DetailsEditing, ProcessedImage> _f$image = Field(
    'image',
    _$image,
  );
  static bool _$isBusy(DetailsEditing v) => v.isBusy;
  static const Field<DetailsEditing, bool> _f$isBusy = Field(
    'isBusy',
    _$isBusy,
  );
  static AppError? _$error(DetailsEditing v) => v.error;
  static const Field<DetailsEditing, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<DetailsEditing> fields = const {
    #image: _f$image,
    #isBusy: _f$isBusy,
    #error: _f$error,
  };

  static DetailsEditing _instantiate(DecodingData data) {
    return DetailsEditing(
      image: data.dec(_f$image),
      isBusy: data.dec(_f$isBusy),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsEditing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsEditing>(map);
  }

  static DetailsEditing fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsEditing>(json);
  }
}

mixin DetailsEditingMappable {
  String toJson() {
    return DetailsEditingMapper.ensureInitialized().encodeJson<DetailsEditing>(
      this as DetailsEditing,
    );
  }

  Map<String, dynamic> toMap() {
    return DetailsEditingMapper.ensureInitialized().encodeMap<DetailsEditing>(
      this as DetailsEditing,
    );
  }

  DetailsEditingCopyWith<DetailsEditing, DetailsEditing, DetailsEditing>
  get copyWith => _DetailsEditingCopyWithImpl<DetailsEditing, DetailsEditing>(
    this as DetailsEditing,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DetailsEditingMapper.ensureInitialized().stringifyValue(
      this as DetailsEditing,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsEditingMapper.ensureInitialized().equalsValue(
      this as DetailsEditing,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsEditingMapper.ensureInitialized().hashValue(
      this as DetailsEditing,
    );
  }
}

extension DetailsEditingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsEditing, $Out> {
  DetailsEditingCopyWith<$R, DetailsEditing, $Out> get $asDetailsEditing =>
      $base.as((v, t, t2) => _DetailsEditingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsEditingCopyWith<$R, $In extends DetailsEditing, $Out>
    implements DetailsStateCopyWith<$R, $In, $Out> {
  ProcessedImageCopyWith<$R, ProcessedImage, ProcessedImage>? get image;
  @override
  $R call({ProcessedImage? image, bool? isBusy, AppError? error});
  DetailsEditingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DetailsEditingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsEditing, $Out>
    implements DetailsEditingCopyWith<$R, DetailsEditing, $Out> {
  _DetailsEditingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsEditing> $mapper =
      DetailsEditingMapper.ensureInitialized();
  @override
  ProcessedImageCopyWith<$R, ProcessedImage, ProcessedImage>? get image =>
      $value.image?.copyWith.$chain((v) => call(image: v));
  @override
  $R call({Object? image = $none, bool? isBusy, Object? error = $none}) =>
      $apply(
        FieldCopyWithData({
          if (image != $none) #image: image,
          if (isBusy != null) #isBusy: isBusy,
          if (error != $none) #error: error,
        }),
      );
  @override
  DetailsEditing $make(CopyWithData data) => DetailsEditing(
    image: data.get(#image, or: $value.image),
    isBusy: data.get(#isBusy, or: $value.isBusy),
    error: data.get(#error, or: $value.error),
  );

  @override
  DetailsEditingCopyWith<$R2, DetailsEditing, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsEditingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsSavedMapper extends ClassMapperBase<DetailsSaved> {
  DetailsSavedMapper._();

  static DetailsSavedMapper? _instance;
  static DetailsSavedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsSavedMapper._());
      DetailsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsSaved';

  @override
  final MappableFields<DetailsSaved> fields = const {};

  static DetailsSaved _instantiate(DecodingData data) {
    return DetailsSaved();
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsSaved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsSaved>(map);
  }

  static DetailsSaved fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsSaved>(json);
  }
}

mixin DetailsSavedMappable {
  String toJson() {
    return DetailsSavedMapper.ensureInitialized().encodeJson<DetailsSaved>(
      this as DetailsSaved,
    );
  }

  Map<String, dynamic> toMap() {
    return DetailsSavedMapper.ensureInitialized().encodeMap<DetailsSaved>(
      this as DetailsSaved,
    );
  }

  DetailsSavedCopyWith<DetailsSaved, DetailsSaved, DetailsSaved> get copyWith =>
      _DetailsSavedCopyWithImpl<DetailsSaved, DetailsSaved>(
        this as DetailsSaved,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DetailsSavedMapper.ensureInitialized().stringifyValue(
      this as DetailsSaved,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsSavedMapper.ensureInitialized().equalsValue(
      this as DetailsSaved,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsSavedMapper.ensureInitialized().hashValue(
      this as DetailsSaved,
    );
  }
}

extension DetailsSavedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsSaved, $Out> {
  DetailsSavedCopyWith<$R, DetailsSaved, $Out> get $asDetailsSaved =>
      $base.as((v, t, t2) => _DetailsSavedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsSavedCopyWith<$R, $In extends DetailsSaved, $Out>
    implements DetailsStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  DetailsSavedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DetailsSavedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsSaved, $Out>
    implements DetailsSavedCopyWith<$R, DetailsSaved, $Out> {
  _DetailsSavedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsSaved> $mapper =
      DetailsSavedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DetailsSaved $make(CopyWithData data) => DetailsSaved();

  @override
  DetailsSavedCopyWith<$R2, DetailsSaved, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsSavedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

