// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'scan_state.dart';

class ScanStateMapper extends ClassMapperBase<ScanState> {
  ScanStateMapper._();

  static ScanStateMapper? _instance;
  static ScanStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanStateMapper._());
      ScanCapturingMapper.ensureInitialized();
      ScanReviewingMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanState';

  @override
  final MappableFields<ScanState> fields = const {};

  static ScanState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('ScanState');
  }

  @override
  final Function instantiate = _instantiate;

  static ScanState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanState>(map);
  }

  static ScanState fromJson(String json) {
    return ensureInitialized().decodeJson<ScanState>(json);
  }
}

mixin ScanStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ScanStateCopyWith<ScanState, ScanState, ScanState> get copyWith;
}

abstract class ScanStateCopyWith<$R, $In extends ScanState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  ScanStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ScanCapturingMapper extends ClassMapperBase<ScanCapturing> {
  ScanCapturingMapper._();

  static ScanCapturingMapper? _instance;
  static ScanCapturingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanCapturingMapper._());
      ScanStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanCapturing';

  static bool _$isProcessing(ScanCapturing v) => v.isProcessing;
  static const Field<ScanCapturing, bool> _f$isProcessing = Field(
    'isProcessing',
    _$isProcessing,
  );
  static AppError? _$error(ScanCapturing v) => v.error;
  static const Field<ScanCapturing, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<ScanCapturing> fields = const {
    #isProcessing: _f$isProcessing,
    #error: _f$error,
  };

  static ScanCapturing _instantiate(DecodingData data) {
    return ScanCapturing(
      isProcessing: data.dec(_f$isProcessing),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ScanCapturing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanCapturing>(map);
  }

  static ScanCapturing fromJson(String json) {
    return ensureInitialized().decodeJson<ScanCapturing>(json);
  }
}

mixin ScanCapturingMappable {
  String toJson() {
    return ScanCapturingMapper.ensureInitialized().encodeJson<ScanCapturing>(
      this as ScanCapturing,
    );
  }

  Map<String, dynamic> toMap() {
    return ScanCapturingMapper.ensureInitialized().encodeMap<ScanCapturing>(
      this as ScanCapturing,
    );
  }

  ScanCapturingCopyWith<ScanCapturing, ScanCapturing, ScanCapturing>
  get copyWith => _ScanCapturingCopyWithImpl<ScanCapturing, ScanCapturing>(
    this as ScanCapturing,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ScanCapturingMapper.ensureInitialized().stringifyValue(
      this as ScanCapturing,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScanCapturingMapper.ensureInitialized().equalsValue(
      this as ScanCapturing,
      other,
    );
  }

  @override
  int get hashCode {
    return ScanCapturingMapper.ensureInitialized().hashValue(
      this as ScanCapturing,
    );
  }
}

extension ScanCapturingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScanCapturing, $Out> {
  ScanCapturingCopyWith<$R, ScanCapturing, $Out> get $asScanCapturing =>
      $base.as((v, t, t2) => _ScanCapturingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ScanCapturingCopyWith<$R, $In extends ScanCapturing, $Out>
    implements ScanStateCopyWith<$R, $In, $Out> {
  @override
  $R call({bool? isProcessing, AppError? error});
  ScanCapturingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ScanCapturingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScanCapturing, $Out>
    implements ScanCapturingCopyWith<$R, ScanCapturing, $Out> {
  _ScanCapturingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScanCapturing> $mapper =
      ScanCapturingMapper.ensureInitialized();
  @override
  $R call({bool? isProcessing, Object? error = $none}) => $apply(
    FieldCopyWithData({
      if (isProcessing != null) #isProcessing: isProcessing,
      if (error != $none) #error: error,
    }),
  );
  @override
  ScanCapturing $make(CopyWithData data) => ScanCapturing(
    isProcessing: data.get(#isProcessing, or: $value.isProcessing),
    error: data.get(#error, or: $value.error),
  );

  @override
  ScanCapturingCopyWith<$R2, ScanCapturing, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ScanCapturingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ScanReviewingMapper extends ClassMapperBase<ScanReviewing> {
  ScanReviewingMapper._();

  static ScanReviewingMapper? _instance;
  static ScanReviewingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanReviewingMapper._());
      ScanStateMapper.ensureInitialized();
      ProcessedImageMapper.ensureInitialized();
      ScanSuggestionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanReviewing';

  static ProcessedImage _$photo(ScanReviewing v) => v.photo;
  static const Field<ScanReviewing, ProcessedImage> _f$photo = Field(
    'photo',
    _$photo,
  );
  static ScanSuggestions _$suggestions(ScanReviewing v) => v.suggestions;
  static const Field<ScanReviewing, ScanSuggestions> _f$suggestions = Field(
    'suggestions',
    _$suggestions,
  );

  @override
  final MappableFields<ScanReviewing> fields = const {
    #photo: _f$photo,
    #suggestions: _f$suggestions,
  };

  static ScanReviewing _instantiate(DecodingData data) {
    return ScanReviewing(
      photo: data.dec(_f$photo),
      suggestions: data.dec(_f$suggestions),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ScanReviewing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanReviewing>(map);
  }

  static ScanReviewing fromJson(String json) {
    return ensureInitialized().decodeJson<ScanReviewing>(json);
  }
}

mixin ScanReviewingMappable {
  String toJson() {
    return ScanReviewingMapper.ensureInitialized().encodeJson<ScanReviewing>(
      this as ScanReviewing,
    );
  }

  Map<String, dynamic> toMap() {
    return ScanReviewingMapper.ensureInitialized().encodeMap<ScanReviewing>(
      this as ScanReviewing,
    );
  }

  ScanReviewingCopyWith<ScanReviewing, ScanReviewing, ScanReviewing>
  get copyWith => _ScanReviewingCopyWithImpl<ScanReviewing, ScanReviewing>(
    this as ScanReviewing,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ScanReviewingMapper.ensureInitialized().stringifyValue(
      this as ScanReviewing,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScanReviewingMapper.ensureInitialized().equalsValue(
      this as ScanReviewing,
      other,
    );
  }

  @override
  int get hashCode {
    return ScanReviewingMapper.ensureInitialized().hashValue(
      this as ScanReviewing,
    );
  }
}

extension ScanReviewingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScanReviewing, $Out> {
  ScanReviewingCopyWith<$R, ScanReviewing, $Out> get $asScanReviewing =>
      $base.as((v, t, t2) => _ScanReviewingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ScanReviewingCopyWith<$R, $In extends ScanReviewing, $Out>
    implements ScanStateCopyWith<$R, $In, $Out> {
  ProcessedImageCopyWith<$R, ProcessedImage, ProcessedImage> get photo;
  ScanSuggestionsCopyWith<$R, ScanSuggestions, ScanSuggestions> get suggestions;
  @override
  $R call({ProcessedImage? photo, ScanSuggestions? suggestions});
  ScanReviewingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ScanReviewingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScanReviewing, $Out>
    implements ScanReviewingCopyWith<$R, ScanReviewing, $Out> {
  _ScanReviewingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScanReviewing> $mapper =
      ScanReviewingMapper.ensureInitialized();
  @override
  ProcessedImageCopyWith<$R, ProcessedImage, ProcessedImage> get photo =>
      $value.photo.copyWith.$chain((v) => call(photo: v));
  @override
  ScanSuggestionsCopyWith<$R, ScanSuggestions, ScanSuggestions>
  get suggestions =>
      $value.suggestions.copyWith.$chain((v) => call(suggestions: v));
  @override
  $R call({ProcessedImage? photo, ScanSuggestions? suggestions}) => $apply(
    FieldCopyWithData({
      if (photo != null) #photo: photo,
      if (suggestions != null) #suggestions: suggestions,
    }),
  );
  @override
  ScanReviewing $make(CopyWithData data) => ScanReviewing(
    photo: data.get(#photo, or: $value.photo),
    suggestions: data.get(#suggestions, or: $value.suggestions),
  );

  @override
  ScanReviewingCopyWith<$R2, ScanReviewing, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ScanReviewingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ScanSuggestionsMapper extends ClassMapperBase<ScanSuggestions> {
  ScanSuggestionsMapper._();

  static ScanSuggestionsMapper? _instance;
  static ScanSuggestionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanSuggestionsMapper._());
      ScanSuggestionsLoadingMapper.ensureInitialized();
      ScanSuggestionsLoadedMapper.ensureInitialized();
      ScanSuggestionsOfflineMapper.ensureInitialized();
      ScanSuggestionsFailedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanSuggestions';

  @override
  final MappableFields<ScanSuggestions> fields = const {};

  static ScanSuggestions _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('ScanSuggestions');
  }

  @override
  final Function instantiate = _instantiate;

  static ScanSuggestions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanSuggestions>(map);
  }

  static ScanSuggestions fromJson(String json) {
    return ensureInitialized().decodeJson<ScanSuggestions>(json);
  }
}

mixin ScanSuggestionsMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ScanSuggestionsCopyWith<ScanSuggestions, ScanSuggestions, ScanSuggestions>
  get copyWith;
}

abstract class ScanSuggestionsCopyWith<$R, $In extends ScanSuggestions, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  ScanSuggestionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class ScanSuggestionsLoadingMapper
    extends ClassMapperBase<ScanSuggestionsLoading> {
  ScanSuggestionsLoadingMapper._();

  static ScanSuggestionsLoadingMapper? _instance;
  static ScanSuggestionsLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanSuggestionsLoadingMapper._());
      ScanSuggestionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanSuggestionsLoading';

  @override
  final MappableFields<ScanSuggestionsLoading> fields = const {};

  static ScanSuggestionsLoading _instantiate(DecodingData data) {
    return ScanSuggestionsLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static ScanSuggestionsLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanSuggestionsLoading>(map);
  }

  static ScanSuggestionsLoading fromJson(String json) {
    return ensureInitialized().decodeJson<ScanSuggestionsLoading>(json);
  }
}

mixin ScanSuggestionsLoadingMappable {
  String toJson() {
    return ScanSuggestionsLoadingMapper.ensureInitialized()
        .encodeJson<ScanSuggestionsLoading>(this as ScanSuggestionsLoading);
  }

  Map<String, dynamic> toMap() {
    return ScanSuggestionsLoadingMapper.ensureInitialized()
        .encodeMap<ScanSuggestionsLoading>(this as ScanSuggestionsLoading);
  }

  ScanSuggestionsLoadingCopyWith<
    ScanSuggestionsLoading,
    ScanSuggestionsLoading,
    ScanSuggestionsLoading
  >
  get copyWith =>
      _ScanSuggestionsLoadingCopyWithImpl<
        ScanSuggestionsLoading,
        ScanSuggestionsLoading
      >(this as ScanSuggestionsLoading, $identity, $identity);
  @override
  String toString() {
    return ScanSuggestionsLoadingMapper.ensureInitialized().stringifyValue(
      this as ScanSuggestionsLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScanSuggestionsLoadingMapper.ensureInitialized().equalsValue(
      this as ScanSuggestionsLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return ScanSuggestionsLoadingMapper.ensureInitialized().hashValue(
      this as ScanSuggestionsLoading,
    );
  }
}

extension ScanSuggestionsLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScanSuggestionsLoading, $Out> {
  ScanSuggestionsLoadingCopyWith<$R, ScanSuggestionsLoading, $Out>
  get $asScanSuggestionsLoading => $base.as(
    (v, t, t2) => _ScanSuggestionsLoadingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ScanSuggestionsLoadingCopyWith<
  $R,
  $In extends ScanSuggestionsLoading,
  $Out
>
    implements ScanSuggestionsCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ScanSuggestionsLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ScanSuggestionsLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScanSuggestionsLoading, $Out>
    implements
        ScanSuggestionsLoadingCopyWith<$R, ScanSuggestionsLoading, $Out> {
  _ScanSuggestionsLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScanSuggestionsLoading> $mapper =
      ScanSuggestionsLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  ScanSuggestionsLoading $make(CopyWithData data) => ScanSuggestionsLoading();

  @override
  ScanSuggestionsLoadingCopyWith<$R2, ScanSuggestionsLoading, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ScanSuggestionsLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ScanSuggestionsLoadedMapper
    extends ClassMapperBase<ScanSuggestionsLoaded> {
  ScanSuggestionsLoadedMapper._();

  static ScanSuggestionsLoadedMapper? _instance;
  static ScanSuggestionsLoadedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanSuggestionsLoadedMapper._());
      ScanSuggestionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanSuggestionsLoaded';

  static List<String> _$labels(ScanSuggestionsLoaded v) => v.labels;
  static const Field<ScanSuggestionsLoaded, List<String>> _f$labels = Field(
    'labels',
    _$labels,
  );

  @override
  final MappableFields<ScanSuggestionsLoaded> fields = const {
    #labels: _f$labels,
  };

  static ScanSuggestionsLoaded _instantiate(DecodingData data) {
    return ScanSuggestionsLoaded(labels: data.dec(_f$labels));
  }

  @override
  final Function instantiate = _instantiate;

  static ScanSuggestionsLoaded fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanSuggestionsLoaded>(map);
  }

  static ScanSuggestionsLoaded fromJson(String json) {
    return ensureInitialized().decodeJson<ScanSuggestionsLoaded>(json);
  }
}

mixin ScanSuggestionsLoadedMappable {
  String toJson() {
    return ScanSuggestionsLoadedMapper.ensureInitialized()
        .encodeJson<ScanSuggestionsLoaded>(this as ScanSuggestionsLoaded);
  }

  Map<String, dynamic> toMap() {
    return ScanSuggestionsLoadedMapper.ensureInitialized()
        .encodeMap<ScanSuggestionsLoaded>(this as ScanSuggestionsLoaded);
  }

  ScanSuggestionsLoadedCopyWith<
    ScanSuggestionsLoaded,
    ScanSuggestionsLoaded,
    ScanSuggestionsLoaded
  >
  get copyWith =>
      _ScanSuggestionsLoadedCopyWithImpl<
        ScanSuggestionsLoaded,
        ScanSuggestionsLoaded
      >(this as ScanSuggestionsLoaded, $identity, $identity);
  @override
  String toString() {
    return ScanSuggestionsLoadedMapper.ensureInitialized().stringifyValue(
      this as ScanSuggestionsLoaded,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScanSuggestionsLoadedMapper.ensureInitialized().equalsValue(
      this as ScanSuggestionsLoaded,
      other,
    );
  }

  @override
  int get hashCode {
    return ScanSuggestionsLoadedMapper.ensureInitialized().hashValue(
      this as ScanSuggestionsLoaded,
    );
  }
}

extension ScanSuggestionsLoadedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScanSuggestionsLoaded, $Out> {
  ScanSuggestionsLoadedCopyWith<$R, ScanSuggestionsLoaded, $Out>
  get $asScanSuggestionsLoaded => $base.as(
    (v, t, t2) => _ScanSuggestionsLoadedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ScanSuggestionsLoadedCopyWith<
  $R,
  $In extends ScanSuggestionsLoaded,
  $Out
>
    implements ScanSuggestionsCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get labels;
  @override
  $R call({List<String>? labels});
  ScanSuggestionsLoadedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ScanSuggestionsLoadedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScanSuggestionsLoaded, $Out>
    implements ScanSuggestionsLoadedCopyWith<$R, ScanSuggestionsLoaded, $Out> {
  _ScanSuggestionsLoadedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScanSuggestionsLoaded> $mapper =
      ScanSuggestionsLoadedMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get labels =>
      ListCopyWith(
        $value.labels,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(labels: v),
      );
  @override
  $R call({List<String>? labels}) =>
      $apply(FieldCopyWithData({if (labels != null) #labels: labels}));
  @override
  ScanSuggestionsLoaded $make(CopyWithData data) =>
      ScanSuggestionsLoaded(labels: data.get(#labels, or: $value.labels));

  @override
  ScanSuggestionsLoadedCopyWith<$R2, ScanSuggestionsLoaded, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ScanSuggestionsLoadedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ScanSuggestionsOfflineMapper
    extends ClassMapperBase<ScanSuggestionsOffline> {
  ScanSuggestionsOfflineMapper._();

  static ScanSuggestionsOfflineMapper? _instance;
  static ScanSuggestionsOfflineMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanSuggestionsOfflineMapper._());
      ScanSuggestionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanSuggestionsOffline';

  @override
  final MappableFields<ScanSuggestionsOffline> fields = const {};

  static ScanSuggestionsOffline _instantiate(DecodingData data) {
    return ScanSuggestionsOffline();
  }

  @override
  final Function instantiate = _instantiate;

  static ScanSuggestionsOffline fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanSuggestionsOffline>(map);
  }

  static ScanSuggestionsOffline fromJson(String json) {
    return ensureInitialized().decodeJson<ScanSuggestionsOffline>(json);
  }
}

mixin ScanSuggestionsOfflineMappable {
  String toJson() {
    return ScanSuggestionsOfflineMapper.ensureInitialized()
        .encodeJson<ScanSuggestionsOffline>(this as ScanSuggestionsOffline);
  }

  Map<String, dynamic> toMap() {
    return ScanSuggestionsOfflineMapper.ensureInitialized()
        .encodeMap<ScanSuggestionsOffline>(this as ScanSuggestionsOffline);
  }

  ScanSuggestionsOfflineCopyWith<
    ScanSuggestionsOffline,
    ScanSuggestionsOffline,
    ScanSuggestionsOffline
  >
  get copyWith =>
      _ScanSuggestionsOfflineCopyWithImpl<
        ScanSuggestionsOffline,
        ScanSuggestionsOffline
      >(this as ScanSuggestionsOffline, $identity, $identity);
  @override
  String toString() {
    return ScanSuggestionsOfflineMapper.ensureInitialized().stringifyValue(
      this as ScanSuggestionsOffline,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScanSuggestionsOfflineMapper.ensureInitialized().equalsValue(
      this as ScanSuggestionsOffline,
      other,
    );
  }

  @override
  int get hashCode {
    return ScanSuggestionsOfflineMapper.ensureInitialized().hashValue(
      this as ScanSuggestionsOffline,
    );
  }
}

extension ScanSuggestionsOfflineValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScanSuggestionsOffline, $Out> {
  ScanSuggestionsOfflineCopyWith<$R, ScanSuggestionsOffline, $Out>
  get $asScanSuggestionsOffline => $base.as(
    (v, t, t2) => _ScanSuggestionsOfflineCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ScanSuggestionsOfflineCopyWith<
  $R,
  $In extends ScanSuggestionsOffline,
  $Out
>
    implements ScanSuggestionsCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ScanSuggestionsOfflineCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ScanSuggestionsOfflineCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScanSuggestionsOffline, $Out>
    implements
        ScanSuggestionsOfflineCopyWith<$R, ScanSuggestionsOffline, $Out> {
  _ScanSuggestionsOfflineCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScanSuggestionsOffline> $mapper =
      ScanSuggestionsOfflineMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  ScanSuggestionsOffline $make(CopyWithData data) => ScanSuggestionsOffline();

  @override
  ScanSuggestionsOfflineCopyWith<$R2, ScanSuggestionsOffline, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ScanSuggestionsOfflineCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ScanSuggestionsFailedMapper
    extends ClassMapperBase<ScanSuggestionsFailed> {
  ScanSuggestionsFailedMapper._();

  static ScanSuggestionsFailedMapper? _instance;
  static ScanSuggestionsFailedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScanSuggestionsFailedMapper._());
      ScanSuggestionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScanSuggestionsFailed';

  static AppError _$error(ScanSuggestionsFailed v) => v.error;
  static const Field<ScanSuggestionsFailed, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<ScanSuggestionsFailed> fields = const {#error: _f$error};

  static ScanSuggestionsFailed _instantiate(DecodingData data) {
    return ScanSuggestionsFailed(error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static ScanSuggestionsFailed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScanSuggestionsFailed>(map);
  }

  static ScanSuggestionsFailed fromJson(String json) {
    return ensureInitialized().decodeJson<ScanSuggestionsFailed>(json);
  }
}

mixin ScanSuggestionsFailedMappable {
  String toJson() {
    return ScanSuggestionsFailedMapper.ensureInitialized()
        .encodeJson<ScanSuggestionsFailed>(this as ScanSuggestionsFailed);
  }

  Map<String, dynamic> toMap() {
    return ScanSuggestionsFailedMapper.ensureInitialized()
        .encodeMap<ScanSuggestionsFailed>(this as ScanSuggestionsFailed);
  }

  ScanSuggestionsFailedCopyWith<
    ScanSuggestionsFailed,
    ScanSuggestionsFailed,
    ScanSuggestionsFailed
  >
  get copyWith =>
      _ScanSuggestionsFailedCopyWithImpl<
        ScanSuggestionsFailed,
        ScanSuggestionsFailed
      >(this as ScanSuggestionsFailed, $identity, $identity);
  @override
  String toString() {
    return ScanSuggestionsFailedMapper.ensureInitialized().stringifyValue(
      this as ScanSuggestionsFailed,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScanSuggestionsFailedMapper.ensureInitialized().equalsValue(
      this as ScanSuggestionsFailed,
      other,
    );
  }

  @override
  int get hashCode {
    return ScanSuggestionsFailedMapper.ensureInitialized().hashValue(
      this as ScanSuggestionsFailed,
    );
  }
}

extension ScanSuggestionsFailedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScanSuggestionsFailed, $Out> {
  ScanSuggestionsFailedCopyWith<$R, ScanSuggestionsFailed, $Out>
  get $asScanSuggestionsFailed => $base.as(
    (v, t, t2) => _ScanSuggestionsFailedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ScanSuggestionsFailedCopyWith<
  $R,
  $In extends ScanSuggestionsFailed,
  $Out
>
    implements ScanSuggestionsCopyWith<$R, $In, $Out> {
  @override
  $R call({AppError? error});
  ScanSuggestionsFailedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ScanSuggestionsFailedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScanSuggestionsFailed, $Out>
    implements ScanSuggestionsFailedCopyWith<$R, ScanSuggestionsFailed, $Out> {
  _ScanSuggestionsFailedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScanSuggestionsFailed> $mapper =
      ScanSuggestionsFailedMapper.ensureInitialized();
  @override
  $R call({AppError? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  ScanSuggestionsFailed $make(CopyWithData data) =>
      ScanSuggestionsFailed(error: data.get(#error, or: $value.error));

  @override
  ScanSuggestionsFailedCopyWith<$R2, ScanSuggestionsFailed, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ScanSuggestionsFailedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

