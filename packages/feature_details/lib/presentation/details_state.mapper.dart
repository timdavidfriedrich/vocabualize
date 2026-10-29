// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'details_state.dart';

class DetailsPendingLookupMapper extends EnumMapper<DetailsPendingLookup> {
  DetailsPendingLookupMapper._();

  static DetailsPendingLookupMapper? _instance;
  static DetailsPendingLookupMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsPendingLookupMapper._());
    }
    return _instance!;
  }

  static DetailsPendingLookup fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DetailsPendingLookup decode(dynamic value) {
    switch (value) {
      case r'translationAndPhotos':
        return DetailsPendingLookup.translationAndPhotos;
      case r'photos':
        return DetailsPendingLookup.photos;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DetailsPendingLookup self) {
    switch (self) {
      case DetailsPendingLookup.translationAndPhotos:
        return r'translationAndPhotos';
      case DetailsPendingLookup.photos:
        return r'photos';
    }
  }
}

extension DetailsPendingLookupMapperExtension on DetailsPendingLookup {
  String toValue() {
    DetailsPendingLookupMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DetailsPendingLookup>(this)
        as String;
  }
}

class DetailsNoticeMapper extends EnumMapper<DetailsNotice> {
  DetailsNoticeMapper._();

  static DetailsNoticeMapper? _instance;
  static DetailsNoticeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsNoticeMapper._());
    }
    return _instance!;
  }

  static DetailsNotice fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DetailsNotice decode(dynamic value) {
    switch (value) {
      case r'translationReported':
        return DetailsNotice.translationReported;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DetailsNotice self) {
    switch (self) {
      case DetailsNotice.translationReported:
        return r'translationReported';
    }
  }
}

extension DetailsNoticeMapperExtension on DetailsNotice {
  String toValue() {
    DetailsNoticeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DetailsNotice>(this) as String;
  }
}

class DetailsActionMapper extends EnumMapper<DetailsAction> {
  DetailsActionMapper._();

  static DetailsActionMapper? _instance;
  static DetailsActionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsActionMapper._());
    }
    return _instance!;
  }

  static DetailsAction fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DetailsAction decode(dynamic value) {
    switch (value) {
      case r'lookup':
        return DetailsAction.lookup;
      case r'photoPick':
        return DetailsAction.photoPick;
      case r'report':
        return DetailsAction.report;
      case r'tagCreation':
        return DetailsAction.tagCreation;
      case r'save':
        return DetailsAction.save;
      case r'delete':
        return DetailsAction.delete;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DetailsAction self) {
    switch (self) {
      case DetailsAction.lookup:
        return r'lookup';
      case DetailsAction.photoPick:
        return r'photoPick';
      case DetailsAction.report:
        return r'report';
      case DetailsAction.tagCreation:
        return r'tagCreation';
      case DetailsAction.save:
        return r'save';
      case DetailsAction.delete:
        return r'delete';
    }
  }
}

extension DetailsActionMapperExtension on DetailsAction {
  String toValue() {
    DetailsActionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DetailsAction>(this) as String;
  }
}

class DetailsStateMapper extends ClassMapperBase<DetailsState> {
  DetailsStateMapper._();

  static DetailsStateMapper? _instance;
  static DetailsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsStateMapper._());
      DetailsLoadingMapper.ensureInitialized();
      DetailsDuplicateFoundMapper.ensureInitialized();
      DetailsEditingMapper.ensureInitialized();
      DetailsAddedMapper.ensureInitialized();
      DetailsClosedMapper.ensureInitialized();
      DetailsFailureMapper.ensureInitialized();
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

class DetailsLoadingMapper extends ClassMapperBase<DetailsLoading> {
  DetailsLoadingMapper._();

  static DetailsLoadingMapper? _instance;
  static DetailsLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsLoadingMapper._());
      DetailsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsLoading';

  @override
  final MappableFields<DetailsLoading> fields = const {};

  static DetailsLoading _instantiate(DecodingData data) {
    return DetailsLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsLoading>(map);
  }

  static DetailsLoading fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsLoading>(json);
  }
}

mixin DetailsLoadingMappable {
  String toJson() {
    return DetailsLoadingMapper.ensureInitialized().encodeJson<DetailsLoading>(
      this as DetailsLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return DetailsLoadingMapper.ensureInitialized().encodeMap<DetailsLoading>(
      this as DetailsLoading,
    );
  }

  DetailsLoadingCopyWith<DetailsLoading, DetailsLoading, DetailsLoading>
  get copyWith => _DetailsLoadingCopyWithImpl<DetailsLoading, DetailsLoading>(
    this as DetailsLoading,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DetailsLoadingMapper.ensureInitialized().stringifyValue(
      this as DetailsLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsLoadingMapper.ensureInitialized().equalsValue(
      this as DetailsLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsLoadingMapper.ensureInitialized().hashValue(
      this as DetailsLoading,
    );
  }
}

extension DetailsLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsLoading, $Out> {
  DetailsLoadingCopyWith<$R, DetailsLoading, $Out> get $asDetailsLoading =>
      $base.as((v, t, t2) => _DetailsLoadingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsLoadingCopyWith<$R, $In extends DetailsLoading, $Out>
    implements DetailsStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  DetailsLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DetailsLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsLoading, $Out>
    implements DetailsLoadingCopyWith<$R, DetailsLoading, $Out> {
  _DetailsLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsLoading> $mapper =
      DetailsLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DetailsLoading $make(CopyWithData data) => DetailsLoading();

  @override
  DetailsLoadingCopyWith<$R2, DetailsLoading, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsDuplicateFoundMapper
    extends ClassMapperBase<DetailsDuplicateFound> {
  DetailsDuplicateFoundMapper._();

  static DetailsDuplicateFoundMapper? _instance;
  static DetailsDuplicateFoundMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsDuplicateFoundMapper._());
      DetailsStateMapper.ensureInitialized();
      ProcessedImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsDuplicateFound';

  static String _$source(DetailsDuplicateFound v) => v.source;
  static const Field<DetailsDuplicateFound, String> _f$source = Field(
    'source',
    _$source,
  );
  static ProcessedImage? _$photo(DetailsDuplicateFound v) => v.photo;
  static const Field<DetailsDuplicateFound, ProcessedImage> _f$photo = Field(
    'photo',
    _$photo,
  );

  @override
  final MappableFields<DetailsDuplicateFound> fields = const {
    #source: _f$source,
    #photo: _f$photo,
  };

  static DetailsDuplicateFound _instantiate(DecodingData data) {
    return DetailsDuplicateFound(
      source: data.dec(_f$source),
      photo: data.dec(_f$photo),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsDuplicateFound fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsDuplicateFound>(map);
  }

  static DetailsDuplicateFound fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsDuplicateFound>(json);
  }
}

mixin DetailsDuplicateFoundMappable {
  String toJson() {
    return DetailsDuplicateFoundMapper.ensureInitialized()
        .encodeJson<DetailsDuplicateFound>(this as DetailsDuplicateFound);
  }

  Map<String, dynamic> toMap() {
    return DetailsDuplicateFoundMapper.ensureInitialized()
        .encodeMap<DetailsDuplicateFound>(this as DetailsDuplicateFound);
  }

  DetailsDuplicateFoundCopyWith<
    DetailsDuplicateFound,
    DetailsDuplicateFound,
    DetailsDuplicateFound
  >
  get copyWith =>
      _DetailsDuplicateFoundCopyWithImpl<
        DetailsDuplicateFound,
        DetailsDuplicateFound
      >(this as DetailsDuplicateFound, $identity, $identity);
  @override
  String toString() {
    return DetailsDuplicateFoundMapper.ensureInitialized().stringifyValue(
      this as DetailsDuplicateFound,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsDuplicateFoundMapper.ensureInitialized().equalsValue(
      this as DetailsDuplicateFound,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsDuplicateFoundMapper.ensureInitialized().hashValue(
      this as DetailsDuplicateFound,
    );
  }
}

extension DetailsDuplicateFoundValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsDuplicateFound, $Out> {
  DetailsDuplicateFoundCopyWith<$R, DetailsDuplicateFound, $Out>
  get $asDetailsDuplicateFound => $base.as(
    (v, t, t2) => _DetailsDuplicateFoundCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DetailsDuplicateFoundCopyWith<
  $R,
  $In extends DetailsDuplicateFound,
  $Out
>
    implements DetailsStateCopyWith<$R, $In, $Out> {
  ProcessedImageCopyWith<$R, ProcessedImage, ProcessedImage>? get photo;
  @override
  $R call({String? source, ProcessedImage? photo});
  DetailsDuplicateFoundCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DetailsDuplicateFoundCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsDuplicateFound, $Out>
    implements DetailsDuplicateFoundCopyWith<$R, DetailsDuplicateFound, $Out> {
  _DetailsDuplicateFoundCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsDuplicateFound> $mapper =
      DetailsDuplicateFoundMapper.ensureInitialized();
  @override
  ProcessedImageCopyWith<$R, ProcessedImage, ProcessedImage>? get photo =>
      $value.photo?.copyWith.$chain((v) => call(photo: v));
  @override
  $R call({String? source, Object? photo = $none}) => $apply(
    FieldCopyWithData({
      if (source != null) #source: source,
      if (photo != $none) #photo: photo,
    }),
  );
  @override
  DetailsDuplicateFound $make(CopyWithData data) => DetailsDuplicateFound(
    source: data.get(#source, or: $value.source),
    photo: data.get(#photo, or: $value.photo),
  );

  @override
  DetailsDuplicateFoundCopyWith<$R2, DetailsDuplicateFound, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DetailsDuplicateFoundCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsEditingMapper extends ClassMapperBase<DetailsEditing> {
  DetailsEditingMapper._();

  static DetailsEditingMapper? _instance;
  static DetailsEditingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsEditingMapper._());
      DetailsStateMapper.ensureInitialized();
      VocabularyMapper.ensureInitialized();
      LanguagePairMapper.ensureInitialized();
      DetailsImageMapper.ensureInitialized();
      StockImageMapper.ensureInitialized();
      TagMapper.ensureInitialized();
      DetailsPendingLookupMapper.ensureInitialized();
      DetailsActionMapper.ensureInitialized();
      DetailsNoticeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsEditing';

  static Vocabulary? _$original(DetailsEditing v) => v.original;
  static const Field<DetailsEditing, Vocabulary> _f$original = Field(
    'original',
    _$original,
  );
  static LanguagePair? _$languages(DetailsEditing v) => v.languages;
  static const Field<DetailsEditing, LanguagePair> _f$languages = Field(
    'languages',
    _$languages,
  );
  static String _$source(DetailsEditing v) => v.source;
  static const Field<DetailsEditing, String> _f$source = Field(
    'source',
    _$source,
  );
  static String _$target(DetailsEditing v) => v.target;
  static const Field<DetailsEditing, String> _f$target = Field(
    'target',
    _$target,
  );
  static DetailsImage _$selectedImage(DetailsEditing v) => v.selectedImage;
  static const Field<DetailsEditing, DetailsImage> _f$selectedImage = Field(
    'selectedImage',
    _$selectedImage,
  );
  static DetailsImage? _$ownPhoto(DetailsEditing v) => v.ownPhoto;
  static const Field<DetailsEditing, DetailsImage> _f$ownPhoto = Field(
    'ownPhoto',
    _$ownPhoto,
  );
  static List<StockImage> _$stockImages(DetailsEditing v) => v.stockImages;
  static const Field<DetailsEditing, List<StockImage>> _f$stockImages = Field(
    'stockImages',
    _$stockImages,
  );
  static int _$stockPage(DetailsEditing v) => v.stockPage;
  static const Field<DetailsEditing, int> _f$stockPage = Field(
    'stockPage',
    _$stockPage,
  );
  static List<Tag> _$tags(DetailsEditing v) => v.tags;
  static const Field<DetailsEditing, List<Tag>> _f$tags = Field('tags', _$tags);
  static Set<String> _$selectedTagIds(DetailsEditing v) => v.selectedTagIds;
  static const Field<DetailsEditing, Set<String>> _f$selectedTagIds = Field(
    'selectedTagIds',
    _$selectedTagIds,
  );
  static DetailsPendingLookup? _$pendingLookup(DetailsEditing v) =>
      v.pendingLookup;
  static const Field<DetailsEditing, DetailsPendingLookup> _f$pendingLookup =
      Field('pendingLookup', _$pendingLookup);
  static bool _$isSearchingPhotos(DetailsEditing v) => v.isSearchingPhotos;
  static const Field<DetailsEditing, bool> _f$isSearchingPhotos = Field(
    'isSearchingPhotos',
    _$isSearchingPhotos,
  );
  static DetailsAction? _$runningAction(DetailsEditing v) => v.runningAction;
  static const Field<DetailsEditing, DetailsAction> _f$runningAction = Field(
    'runningAction',
    _$runningAction,
  );
  static DetailsNotice? _$notice(DetailsEditing v) => v.notice;
  static const Field<DetailsEditing, DetailsNotice> _f$notice = Field(
    'notice',
    _$notice,
  );
  static AppError? _$error(DetailsEditing v) => v.error;
  static const Field<DetailsEditing, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<DetailsEditing> fields = const {
    #original: _f$original,
    #languages: _f$languages,
    #source: _f$source,
    #target: _f$target,
    #selectedImage: _f$selectedImage,
    #ownPhoto: _f$ownPhoto,
    #stockImages: _f$stockImages,
    #stockPage: _f$stockPage,
    #tags: _f$tags,
    #selectedTagIds: _f$selectedTagIds,
    #pendingLookup: _f$pendingLookup,
    #isSearchingPhotos: _f$isSearchingPhotos,
    #runningAction: _f$runningAction,
    #notice: _f$notice,
    #error: _f$error,
  };

  static DetailsEditing _instantiate(DecodingData data) {
    return DetailsEditing(
      original: data.dec(_f$original),
      languages: data.dec(_f$languages),
      source: data.dec(_f$source),
      target: data.dec(_f$target),
      selectedImage: data.dec(_f$selectedImage),
      ownPhoto: data.dec(_f$ownPhoto),
      stockImages: data.dec(_f$stockImages),
      stockPage: data.dec(_f$stockPage),
      tags: data.dec(_f$tags),
      selectedTagIds: data.dec(_f$selectedTagIds),
      pendingLookup: data.dec(_f$pendingLookup),
      isSearchingPhotos: data.dec(_f$isSearchingPhotos),
      runningAction: data.dec(_f$runningAction),
      notice: data.dec(_f$notice),
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
  VocabularyCopyWith<$R, Vocabulary, Vocabulary>? get original;
  LanguagePairCopyWith<$R, LanguagePair, LanguagePair>? get languages;
  DetailsImageCopyWith<$R, DetailsImage, DetailsImage> get selectedImage;
  DetailsImageCopyWith<$R, DetailsImage, DetailsImage>? get ownPhoto;
  ListCopyWith<$R, StockImage, StockImageCopyWith<$R, StockImage, StockImage>>
  get stockImages;
  ListCopyWith<$R, Tag, TagCopyWith<$R, Tag, Tag>> get tags;
  @override
  $R call({
    Vocabulary? original,
    LanguagePair? languages,
    String? source,
    String? target,
    DetailsImage? selectedImage,
    DetailsImage? ownPhoto,
    List<StockImage>? stockImages,
    int? stockPage,
    List<Tag>? tags,
    Set<String>? selectedTagIds,
    DetailsPendingLookup? pendingLookup,
    bool? isSearchingPhotos,
    DetailsAction? runningAction,
    DetailsNotice? notice,
    AppError? error,
  });
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
  VocabularyCopyWith<$R, Vocabulary, Vocabulary>? get original =>
      $value.original?.copyWith.$chain((v) => call(original: v));
  @override
  LanguagePairCopyWith<$R, LanguagePair, LanguagePair>? get languages =>
      $value.languages?.copyWith.$chain((v) => call(languages: v));
  @override
  DetailsImageCopyWith<$R, DetailsImage, DetailsImage> get selectedImage =>
      $value.selectedImage.copyWith.$chain((v) => call(selectedImage: v));
  @override
  DetailsImageCopyWith<$R, DetailsImage, DetailsImage>? get ownPhoto =>
      $value.ownPhoto?.copyWith.$chain((v) => call(ownPhoto: v));
  @override
  ListCopyWith<$R, StockImage, StockImageCopyWith<$R, StockImage, StockImage>>
  get stockImages => ListCopyWith(
    $value.stockImages,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(stockImages: v),
  );
  @override
  ListCopyWith<$R, Tag, TagCopyWith<$R, Tag, Tag>> get tags => ListCopyWith(
    $value.tags,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(tags: v),
  );
  @override
  $R call({
    Object? original = $none,
    Object? languages = $none,
    String? source,
    String? target,
    DetailsImage? selectedImage,
    Object? ownPhoto = $none,
    List<StockImage>? stockImages,
    int? stockPage,
    List<Tag>? tags,
    Set<String>? selectedTagIds,
    Object? pendingLookup = $none,
    bool? isSearchingPhotos,
    Object? runningAction = $none,
    Object? notice = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (original != $none) #original: original,
      if (languages != $none) #languages: languages,
      if (source != null) #source: source,
      if (target != null) #target: target,
      if (selectedImage != null) #selectedImage: selectedImage,
      if (ownPhoto != $none) #ownPhoto: ownPhoto,
      if (stockImages != null) #stockImages: stockImages,
      if (stockPage != null) #stockPage: stockPage,
      if (tags != null) #tags: tags,
      if (selectedTagIds != null) #selectedTagIds: selectedTagIds,
      if (pendingLookup != $none) #pendingLookup: pendingLookup,
      if (isSearchingPhotos != null) #isSearchingPhotos: isSearchingPhotos,
      if (runningAction != $none) #runningAction: runningAction,
      if (notice != $none) #notice: notice,
      if (error != $none) #error: error,
    }),
  );
  @override
  DetailsEditing $make(CopyWithData data) => DetailsEditing(
    original: data.get(#original, or: $value.original),
    languages: data.get(#languages, or: $value.languages),
    source: data.get(#source, or: $value.source),
    target: data.get(#target, or: $value.target),
    selectedImage: data.get(#selectedImage, or: $value.selectedImage),
    ownPhoto: data.get(#ownPhoto, or: $value.ownPhoto),
    stockImages: data.get(#stockImages, or: $value.stockImages),
    stockPage: data.get(#stockPage, or: $value.stockPage),
    tags: data.get(#tags, or: $value.tags),
    selectedTagIds: data.get(#selectedTagIds, or: $value.selectedTagIds),
    pendingLookup: data.get(#pendingLookup, or: $value.pendingLookup),
    isSearchingPhotos: data.get(
      #isSearchingPhotos,
      or: $value.isSearchingPhotos,
    ),
    runningAction: data.get(#runningAction, or: $value.runningAction),
    notice: data.get(#notice, or: $value.notice),
    error: data.get(#error, or: $value.error),
  );

  @override
  DetailsEditingCopyWith<$R2, DetailsEditing, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsEditingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsImageMapper extends ClassMapperBase<DetailsImage> {
  DetailsImageMapper._();

  static DetailsImageMapper? _instance;
  static DetailsImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsImageMapper._());
      DetailsNoImageMapper.ensureInitialized();
      DetailsNewPhotoMapper.ensureInitialized();
      DetailsStockPhotoMapper.ensureInitialized();
      DetailsSavedImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsImage';

  @override
  final MappableFields<DetailsImage> fields = const {};

  static DetailsImage _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('DetailsImage');
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsImage>(map);
  }

  static DetailsImage fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsImage>(json);
  }
}

mixin DetailsImageMappable {
  String toJson();
  Map<String, dynamic> toMap();
  DetailsImageCopyWith<DetailsImage, DetailsImage, DetailsImage> get copyWith;
}

abstract class DetailsImageCopyWith<$R, $In extends DetailsImage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  DetailsImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class DetailsAddedMapper extends ClassMapperBase<DetailsAdded> {
  DetailsAddedMapper._();

  static DetailsAddedMapper? _instance;
  static DetailsAddedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsAddedMapper._());
      DetailsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsAdded';

  @override
  final MappableFields<DetailsAdded> fields = const {};

  static DetailsAdded _instantiate(DecodingData data) {
    return DetailsAdded();
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsAdded fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsAdded>(map);
  }

  static DetailsAdded fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsAdded>(json);
  }
}

mixin DetailsAddedMappable {
  String toJson() {
    return DetailsAddedMapper.ensureInitialized().encodeJson<DetailsAdded>(
      this as DetailsAdded,
    );
  }

  Map<String, dynamic> toMap() {
    return DetailsAddedMapper.ensureInitialized().encodeMap<DetailsAdded>(
      this as DetailsAdded,
    );
  }

  DetailsAddedCopyWith<DetailsAdded, DetailsAdded, DetailsAdded> get copyWith =>
      _DetailsAddedCopyWithImpl<DetailsAdded, DetailsAdded>(
        this as DetailsAdded,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DetailsAddedMapper.ensureInitialized().stringifyValue(
      this as DetailsAdded,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsAddedMapper.ensureInitialized().equalsValue(
      this as DetailsAdded,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsAddedMapper.ensureInitialized().hashValue(
      this as DetailsAdded,
    );
  }
}

extension DetailsAddedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsAdded, $Out> {
  DetailsAddedCopyWith<$R, DetailsAdded, $Out> get $asDetailsAdded =>
      $base.as((v, t, t2) => _DetailsAddedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsAddedCopyWith<$R, $In extends DetailsAdded, $Out>
    implements DetailsStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  DetailsAddedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DetailsAddedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsAdded, $Out>
    implements DetailsAddedCopyWith<$R, DetailsAdded, $Out> {
  _DetailsAddedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsAdded> $mapper =
      DetailsAddedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DetailsAdded $make(CopyWithData data) => DetailsAdded();

  @override
  DetailsAddedCopyWith<$R2, DetailsAdded, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsAddedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsClosedMapper extends ClassMapperBase<DetailsClosed> {
  DetailsClosedMapper._();

  static DetailsClosedMapper? _instance;
  static DetailsClosedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsClosedMapper._());
      DetailsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsClosed';

  @override
  final MappableFields<DetailsClosed> fields = const {};

  static DetailsClosed _instantiate(DecodingData data) {
    return DetailsClosed();
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsClosed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsClosed>(map);
  }

  static DetailsClosed fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsClosed>(json);
  }
}

mixin DetailsClosedMappable {
  String toJson() {
    return DetailsClosedMapper.ensureInitialized().encodeJson<DetailsClosed>(
      this as DetailsClosed,
    );
  }

  Map<String, dynamic> toMap() {
    return DetailsClosedMapper.ensureInitialized().encodeMap<DetailsClosed>(
      this as DetailsClosed,
    );
  }

  DetailsClosedCopyWith<DetailsClosed, DetailsClosed, DetailsClosed>
  get copyWith => _DetailsClosedCopyWithImpl<DetailsClosed, DetailsClosed>(
    this as DetailsClosed,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DetailsClosedMapper.ensureInitialized().stringifyValue(
      this as DetailsClosed,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsClosedMapper.ensureInitialized().equalsValue(
      this as DetailsClosed,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsClosedMapper.ensureInitialized().hashValue(
      this as DetailsClosed,
    );
  }
}

extension DetailsClosedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsClosed, $Out> {
  DetailsClosedCopyWith<$R, DetailsClosed, $Out> get $asDetailsClosed =>
      $base.as((v, t, t2) => _DetailsClosedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsClosedCopyWith<$R, $In extends DetailsClosed, $Out>
    implements DetailsStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  DetailsClosedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DetailsClosedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsClosed, $Out>
    implements DetailsClosedCopyWith<$R, DetailsClosed, $Out> {
  _DetailsClosedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsClosed> $mapper =
      DetailsClosedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DetailsClosed $make(CopyWithData data) => DetailsClosed();

  @override
  DetailsClosedCopyWith<$R2, DetailsClosed, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsClosedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsFailureMapper extends ClassMapperBase<DetailsFailure> {
  DetailsFailureMapper._();

  static DetailsFailureMapper? _instance;
  static DetailsFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsFailureMapper._());
      DetailsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsFailure';

  static AppError _$error(DetailsFailure v) => v.error;
  static const Field<DetailsFailure, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<DetailsFailure> fields = const {#error: _f$error};

  static DetailsFailure _instantiate(DecodingData data) {
    return DetailsFailure(error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsFailure>(map);
  }

  static DetailsFailure fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsFailure>(json);
  }
}

mixin DetailsFailureMappable {
  String toJson() {
    return DetailsFailureMapper.ensureInitialized().encodeJson<DetailsFailure>(
      this as DetailsFailure,
    );
  }

  Map<String, dynamic> toMap() {
    return DetailsFailureMapper.ensureInitialized().encodeMap<DetailsFailure>(
      this as DetailsFailure,
    );
  }

  DetailsFailureCopyWith<DetailsFailure, DetailsFailure, DetailsFailure>
  get copyWith => _DetailsFailureCopyWithImpl<DetailsFailure, DetailsFailure>(
    this as DetailsFailure,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DetailsFailureMapper.ensureInitialized().stringifyValue(
      this as DetailsFailure,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsFailureMapper.ensureInitialized().equalsValue(
      this as DetailsFailure,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsFailureMapper.ensureInitialized().hashValue(
      this as DetailsFailure,
    );
  }
}

extension DetailsFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsFailure, $Out> {
  DetailsFailureCopyWith<$R, DetailsFailure, $Out> get $asDetailsFailure =>
      $base.as((v, t, t2) => _DetailsFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsFailureCopyWith<$R, $In extends DetailsFailure, $Out>
    implements DetailsStateCopyWith<$R, $In, $Out> {
  @override
  $R call({AppError? error});
  DetailsFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DetailsFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsFailure, $Out>
    implements DetailsFailureCopyWith<$R, DetailsFailure, $Out> {
  _DetailsFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsFailure> $mapper =
      DetailsFailureMapper.ensureInitialized();
  @override
  $R call({AppError? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  DetailsFailure $make(CopyWithData data) =>
      DetailsFailure(error: data.get(#error, or: $value.error));

  @override
  DetailsFailureCopyWith<$R2, DetailsFailure, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsNoImageMapper extends ClassMapperBase<DetailsNoImage> {
  DetailsNoImageMapper._();

  static DetailsNoImageMapper? _instance;
  static DetailsNoImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsNoImageMapper._());
      DetailsImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsNoImage';

  @override
  final MappableFields<DetailsNoImage> fields = const {};

  static DetailsNoImage _instantiate(DecodingData data) {
    return DetailsNoImage();
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsNoImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsNoImage>(map);
  }

  static DetailsNoImage fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsNoImage>(json);
  }
}

mixin DetailsNoImageMappable {
  String toJson() {
    return DetailsNoImageMapper.ensureInitialized().encodeJson<DetailsNoImage>(
      this as DetailsNoImage,
    );
  }

  Map<String, dynamic> toMap() {
    return DetailsNoImageMapper.ensureInitialized().encodeMap<DetailsNoImage>(
      this as DetailsNoImage,
    );
  }

  DetailsNoImageCopyWith<DetailsNoImage, DetailsNoImage, DetailsNoImage>
  get copyWith => _DetailsNoImageCopyWithImpl<DetailsNoImage, DetailsNoImage>(
    this as DetailsNoImage,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DetailsNoImageMapper.ensureInitialized().stringifyValue(
      this as DetailsNoImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsNoImageMapper.ensureInitialized().equalsValue(
      this as DetailsNoImage,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsNoImageMapper.ensureInitialized().hashValue(
      this as DetailsNoImage,
    );
  }
}

extension DetailsNoImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsNoImage, $Out> {
  DetailsNoImageCopyWith<$R, DetailsNoImage, $Out> get $asDetailsNoImage =>
      $base.as((v, t, t2) => _DetailsNoImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsNoImageCopyWith<$R, $In extends DetailsNoImage, $Out>
    implements DetailsImageCopyWith<$R, $In, $Out> {
  @override
  $R call();
  DetailsNoImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DetailsNoImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsNoImage, $Out>
    implements DetailsNoImageCopyWith<$R, DetailsNoImage, $Out> {
  _DetailsNoImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsNoImage> $mapper =
      DetailsNoImageMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DetailsNoImage $make(CopyWithData data) => DetailsNoImage();

  @override
  DetailsNoImageCopyWith<$R2, DetailsNoImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsNoImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsNewPhotoMapper extends ClassMapperBase<DetailsNewPhoto> {
  DetailsNewPhotoMapper._();

  static DetailsNewPhotoMapper? _instance;
  static DetailsNewPhotoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsNewPhotoMapper._());
      DetailsImageMapper.ensureInitialized();
      ProcessedImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsNewPhoto';

  static ProcessedImage _$image(DetailsNewPhoto v) => v.image;
  static const Field<DetailsNewPhoto, ProcessedImage> _f$image = Field(
    'image',
    _$image,
  );

  @override
  final MappableFields<DetailsNewPhoto> fields = const {#image: _f$image};

  static DetailsNewPhoto _instantiate(DecodingData data) {
    return DetailsNewPhoto(image: data.dec(_f$image));
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsNewPhoto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsNewPhoto>(map);
  }

  static DetailsNewPhoto fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsNewPhoto>(json);
  }
}

mixin DetailsNewPhotoMappable {
  String toJson() {
    return DetailsNewPhotoMapper.ensureInitialized()
        .encodeJson<DetailsNewPhoto>(this as DetailsNewPhoto);
  }

  Map<String, dynamic> toMap() {
    return DetailsNewPhotoMapper.ensureInitialized().encodeMap<DetailsNewPhoto>(
      this as DetailsNewPhoto,
    );
  }

  DetailsNewPhotoCopyWith<DetailsNewPhoto, DetailsNewPhoto, DetailsNewPhoto>
  get copyWith =>
      _DetailsNewPhotoCopyWithImpl<DetailsNewPhoto, DetailsNewPhoto>(
        this as DetailsNewPhoto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DetailsNewPhotoMapper.ensureInitialized().stringifyValue(
      this as DetailsNewPhoto,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsNewPhotoMapper.ensureInitialized().equalsValue(
      this as DetailsNewPhoto,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsNewPhotoMapper.ensureInitialized().hashValue(
      this as DetailsNewPhoto,
    );
  }
}

extension DetailsNewPhotoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsNewPhoto, $Out> {
  DetailsNewPhotoCopyWith<$R, DetailsNewPhoto, $Out> get $asDetailsNewPhoto =>
      $base.as((v, t, t2) => _DetailsNewPhotoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DetailsNewPhotoCopyWith<$R, $In extends DetailsNewPhoto, $Out>
    implements DetailsImageCopyWith<$R, $In, $Out> {
  ProcessedImageCopyWith<$R, ProcessedImage, ProcessedImage> get image;
  @override
  $R call({ProcessedImage? image});
  DetailsNewPhotoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DetailsNewPhotoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsNewPhoto, $Out>
    implements DetailsNewPhotoCopyWith<$R, DetailsNewPhoto, $Out> {
  _DetailsNewPhotoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsNewPhoto> $mapper =
      DetailsNewPhotoMapper.ensureInitialized();
  @override
  ProcessedImageCopyWith<$R, ProcessedImage, ProcessedImage> get image =>
      $value.image.copyWith.$chain((v) => call(image: v));
  @override
  $R call({ProcessedImage? image}) =>
      $apply(FieldCopyWithData({if (image != null) #image: image}));
  @override
  DetailsNewPhoto $make(CopyWithData data) =>
      DetailsNewPhoto(image: data.get(#image, or: $value.image));

  @override
  DetailsNewPhotoCopyWith<$R2, DetailsNewPhoto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsNewPhotoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsStockPhotoMapper extends ClassMapperBase<DetailsStockPhoto> {
  DetailsStockPhotoMapper._();

  static DetailsStockPhotoMapper? _instance;
  static DetailsStockPhotoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsStockPhotoMapper._());
      DetailsImageMapper.ensureInitialized();
      StockImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsStockPhoto';

  static StockImage _$image(DetailsStockPhoto v) => v.image;
  static const Field<DetailsStockPhoto, StockImage> _f$image = Field(
    'image',
    _$image,
  );

  @override
  final MappableFields<DetailsStockPhoto> fields = const {#image: _f$image};

  static DetailsStockPhoto _instantiate(DecodingData data) {
    return DetailsStockPhoto(image: data.dec(_f$image));
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsStockPhoto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsStockPhoto>(map);
  }

  static DetailsStockPhoto fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsStockPhoto>(json);
  }
}

mixin DetailsStockPhotoMappable {
  String toJson() {
    return DetailsStockPhotoMapper.ensureInitialized()
        .encodeJson<DetailsStockPhoto>(this as DetailsStockPhoto);
  }

  Map<String, dynamic> toMap() {
    return DetailsStockPhotoMapper.ensureInitialized()
        .encodeMap<DetailsStockPhoto>(this as DetailsStockPhoto);
  }

  DetailsStockPhotoCopyWith<
    DetailsStockPhoto,
    DetailsStockPhoto,
    DetailsStockPhoto
  >
  get copyWith =>
      _DetailsStockPhotoCopyWithImpl<DetailsStockPhoto, DetailsStockPhoto>(
        this as DetailsStockPhoto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DetailsStockPhotoMapper.ensureInitialized().stringifyValue(
      this as DetailsStockPhoto,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsStockPhotoMapper.ensureInitialized().equalsValue(
      this as DetailsStockPhoto,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsStockPhotoMapper.ensureInitialized().hashValue(
      this as DetailsStockPhoto,
    );
  }
}

extension DetailsStockPhotoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsStockPhoto, $Out> {
  DetailsStockPhotoCopyWith<$R, DetailsStockPhoto, $Out>
  get $asDetailsStockPhoto => $base.as(
    (v, t, t2) => _DetailsStockPhotoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DetailsStockPhotoCopyWith<
  $R,
  $In extends DetailsStockPhoto,
  $Out
>
    implements DetailsImageCopyWith<$R, $In, $Out> {
  StockImageCopyWith<$R, StockImage, StockImage> get image;
  @override
  $R call({StockImage? image});
  DetailsStockPhotoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DetailsStockPhotoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsStockPhoto, $Out>
    implements DetailsStockPhotoCopyWith<$R, DetailsStockPhoto, $Out> {
  _DetailsStockPhotoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsStockPhoto> $mapper =
      DetailsStockPhotoMapper.ensureInitialized();
  @override
  StockImageCopyWith<$R, StockImage, StockImage> get image =>
      $value.image.copyWith.$chain((v) => call(image: v));
  @override
  $R call({StockImage? image}) =>
      $apply(FieldCopyWithData({if (image != null) #image: image}));
  @override
  DetailsStockPhoto $make(CopyWithData data) =>
      DetailsStockPhoto(image: data.get(#image, or: $value.image));

  @override
  DetailsStockPhotoCopyWith<$R2, DetailsStockPhoto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsStockPhotoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DetailsSavedImageMapper extends ClassMapperBase<DetailsSavedImage> {
  DetailsSavedImageMapper._();

  static DetailsSavedImageMapper? _instance;
  static DetailsSavedImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DetailsSavedImageMapper._());
      DetailsImageMapper.ensureInitialized();
      VocabularyImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DetailsSavedImage';

  static VocabularyImage _$image(DetailsSavedImage v) => v.image;
  static const Field<DetailsSavedImage, VocabularyImage> _f$image = Field(
    'image',
    _$image,
  );

  @override
  final MappableFields<DetailsSavedImage> fields = const {#image: _f$image};

  static DetailsSavedImage _instantiate(DecodingData data) {
    return DetailsSavedImage(image: data.dec(_f$image));
  }

  @override
  final Function instantiate = _instantiate;

  static DetailsSavedImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DetailsSavedImage>(map);
  }

  static DetailsSavedImage fromJson(String json) {
    return ensureInitialized().decodeJson<DetailsSavedImage>(json);
  }
}

mixin DetailsSavedImageMappable {
  String toJson() {
    return DetailsSavedImageMapper.ensureInitialized()
        .encodeJson<DetailsSavedImage>(this as DetailsSavedImage);
  }

  Map<String, dynamic> toMap() {
    return DetailsSavedImageMapper.ensureInitialized()
        .encodeMap<DetailsSavedImage>(this as DetailsSavedImage);
  }

  DetailsSavedImageCopyWith<
    DetailsSavedImage,
    DetailsSavedImage,
    DetailsSavedImage
  >
  get copyWith =>
      _DetailsSavedImageCopyWithImpl<DetailsSavedImage, DetailsSavedImage>(
        this as DetailsSavedImage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DetailsSavedImageMapper.ensureInitialized().stringifyValue(
      this as DetailsSavedImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return DetailsSavedImageMapper.ensureInitialized().equalsValue(
      this as DetailsSavedImage,
      other,
    );
  }

  @override
  int get hashCode {
    return DetailsSavedImageMapper.ensureInitialized().hashValue(
      this as DetailsSavedImage,
    );
  }
}

extension DetailsSavedImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DetailsSavedImage, $Out> {
  DetailsSavedImageCopyWith<$R, DetailsSavedImage, $Out>
  get $asDetailsSavedImage => $base.as(
    (v, t, t2) => _DetailsSavedImageCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DetailsSavedImageCopyWith<
  $R,
  $In extends DetailsSavedImage,
  $Out
>
    implements DetailsImageCopyWith<$R, $In, $Out> {
  VocabularyImageCopyWith<$R, VocabularyImage, VocabularyImage> get image;
  @override
  $R call({VocabularyImage? image});
  DetailsSavedImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DetailsSavedImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DetailsSavedImage, $Out>
    implements DetailsSavedImageCopyWith<$R, DetailsSavedImage, $Out> {
  _DetailsSavedImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DetailsSavedImage> $mapper =
      DetailsSavedImageMapper.ensureInitialized();
  @override
  VocabularyImageCopyWith<$R, VocabularyImage, VocabularyImage> get image =>
      $value.image.copyWith.$chain((v) => call(image: v));
  @override
  $R call({VocabularyImage? image}) =>
      $apply(FieldCopyWithData({if (image != null) #image: image}));
  @override
  DetailsSavedImage $make(CopyWithData data) =>
      DetailsSavedImage(image: data.get(#image, or: $value.image));

  @override
  DetailsSavedImageCopyWith<$R2, DetailsSavedImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DetailsSavedImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

