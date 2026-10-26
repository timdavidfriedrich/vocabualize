import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_details/domain/use_cases/pick_image_use_case.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/entities/vocabulary_image_change.dart';
import 'package:shared/domain/repositories/connectivity_repository.dart';
import 'package:shared/domain/repositories/external_link_repository.dart';
import 'package:shared/domain/repositories/image_repository.dart';
import 'package:shared/domain/repositories/report_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';
import 'package:shared/domain/repositories/stock_image_repository.dart';
import 'package:shared/domain/repositories/tag_repository.dart';
import 'package:shared/domain/repositories/translation_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

typedef _Lookup = ({
  String? translation,
  List<StockImage> stockImages,
  AppError? error,
  DetailsPendingLookup? pending,
});

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc(
    this._vocabularyRepository,
    this._settingsRepository,
    this._translationRepository,
    this._stockImageRepository,
    this._imageRepository,
    this._tagRepository,
    this._externalLinkRepository,
    this._pickImage,
    this._connectivityRepository,
    this._reportRepository,
  ) : super(const DetailsLoading()) {
    on<DetailsNewStarted>(_onNewStarted);
    on<DetailsEditStarted>(_onEditStarted);
    on<DetailsConnectionRestored>(_onConnectionRestored);
    on<DetailsTranslationReported>(_onTranslationReported);
    on<DetailsDuplicateResolved>(_onDuplicateResolved);
    on<DetailsSourceChanged>(_onSourceChanged);
    on<DetailsTargetChanged>(_onTargetChanged);
    on<DetailsPhotoPickRequested>(_onPhotoPickRequested);
    on<DetailsImageToggled>(_onImageToggled);
    on<DetailsStockPageAdvanced>(_onStockPageAdvanced);
    on<DetailsTagToggled>(_onTagToggled);
    on<DetailsTagCreated>(_onTagCreated);
    on<DetailsPhotographerLinkOpened>(_onPhotographerLinkOpened);
    on<DetailsSaveRequested>(_onSaveRequested);
    on<DetailsDeleteRequested>(_onDeleteRequested);
  }

  final VocabularyRepository _vocabularyRepository;
  final SettingsRepository _settingsRepository;
  final TranslationRepository _translationRepository;
  final StockImageRepository _stockImageRepository;
  final ImageRepository _imageRepository;
  final TagRepository _tagRepository;
  final ExternalLinkRepository _externalLinkRepository;
  final PickImageUseCase _pickImage;
  final ConnectivityRepository _connectivityRepository;
  final ReportRepository _reportRepository;

  Future<void> _onNewStarted(DetailsNewStarted event, Emitter<DetailsState> emit) async {
    switch (await _vocabularyRepository.hasVocabularyWithSource(event.source)) {
      case Success(data: true):
        emit(DetailsDuplicateFound(source: event.source, photo: event.photo));
      case Success(data: false):
        emit(await _newWord(event.source, photo: event.photo));
      case Failure(:final error):
        emit(DetailsFailure(error: error));
    }
    await _watchConnectivity(emit);
  }

  Future<void> _onEditStarted(DetailsEditStarted event, Emitter<DetailsState> emit) async {
    switch (await _vocabularyRepository.findVocabulary(event.vocabularyId)) {
      case Success(:final data):
        emit(await _existingWord(data));
      case Failure(:final error):
        emit(DetailsFailure(error: error));
    }
    await _watchConnectivity(emit);
  }

  Future<void> _onConnectionRestored(
    DetailsConnectionRestored event,
    Emitter<DetailsState> emit,
  ) async {
    if (state
        case DetailsEditing(
              :final pendingLookup?,
              :final languages?,
              isBusy: false,
            ) &&
            final editing) {
      final busy = editing.copyWith(isBusy: true, error: null);
      emit(busy);
      final lookup = await _lookUp(editing.source, languages, pending: pendingLookup);
      emit(
        busy.copyWith(
          target: lookup.translation ?? busy.target,
          stockImages: lookup.stockImages,
          stockPage: 0,
          pendingLookup: lookup.pending,
          isBusy: false,
          error: lookup.error,
        ),
      );
    }
  }

  Future<void> _onTranslationReported(
    DetailsTranslationReported event,
    Emitter<DetailsState> emit,
  ) async {
    if (state case DetailsEditing(:final languages?, isBusy: false) && final editing) {
      final busy = editing.copyWith(isBusy: true, error: null);
      emit(busy);
      final result = await _reportRepository.sendTranslationReport(
        source: editing.source,
        target: editing.target,
        languages: languages,
        note: event.note,
      );
      switch (result) {
        case Success():
          emit(busy.copyWith(isBusy: false, notice: DetailsNotice.translationReported));
          emit(busy.copyWith(isBusy: false, notice: null));
        case Failure(:final error):
          emit(busy.copyWith(isBusy: false, error: error));
      }
    }
  }

  Future<void> _onDuplicateResolved(
    DetailsDuplicateResolved event,
    Emitter<DetailsState> emit,
  ) async {
    if (state case DetailsDuplicateFound(:final source, :final photo)) {
      emit(event.addsAnyway ? await _newWord(source, photo: photo) : const DetailsClosed());
    }
  }

  Future<void> _onSourceChanged(DetailsSourceChanged event, Emitter<DetailsState> emit) async {
    if (state case final DetailsEditing editing when !editing.isBusy) {
      final source = event.source.trim();
      final languages = editing.languages;
      if (!event.retranslates || languages == null) {
        emit(editing.copyWith(source: source, error: null));
        return;
      }
      final busy = editing.copyWith(source: source, isBusy: true, error: null);
      emit(busy);
      final lookup = await _lookUp(
        source,
        languages,
        pending: DetailsPendingLookup.translationAndPhotos,
      );
      emit(
        busy.copyWith(
          target: lookup.translation ?? busy.target,
          stockImages: lookup.stockImages,
          stockPage: 0,
          pendingLookup: lookup.pending,
          isBusy: false,
          error: lookup.error,
        ),
      );
    }
  }

  void _onTargetChanged(DetailsTargetChanged event, Emitter<DetailsState> emit) {
    if (state case final DetailsEditing editing when !editing.isBusy) {
      emit(
        editing.copyWith(
          target: event.target.trim(),
          pendingLookup: switch (editing.pendingLookup) {
            null => null,
            DetailsPendingLookup() => DetailsPendingLookup.photos,
          },
          error: null,
        ),
      );
    }
  }

  Future<void> _onPhotoPickRequested(
    DetailsPhotoPickRequested event,
    Emitter<DetailsState> emit,
  ) async {
    if (state case final DetailsEditing editing when !editing.isBusy) {
      final busy = editing.copyWith(isBusy: true, error: null);
      emit(busy);
      final result = await _pickImage(event.source);
      emit(switch (result) {
        Success(data: final image?) => busy.copyWith(
          selectedImage: DetailsNewPhoto(image: image),
          ownPhoto: DetailsNewPhoto(image: image),
          isBusy: false,
        ),
        Success(data: null) => busy.copyWith(isBusy: false),
        Failure(:final error) => busy.copyWith(isBusy: false, error: error),
      });
    }
  }

  void _onImageToggled(DetailsImageToggled event, Emitter<DetailsState> emit) {
    if (state case final DetailsEditing editing when !editing.isBusy) {
      final isSelected = editing.selectedImage == event.image;
      emit(
        editing.copyWith(
          selectedImage: isSelected ? const DetailsNoImage() : event.image,
          error: null,
        ),
      );
    }
  }

  void _onStockPageAdvanced(DetailsStockPageAdvanced event, Emitter<DetailsState> emit) {
    if (state case final DetailsEditing editing when editing.stockImages.isNotEmpty) {
      final pageCount = (editing.stockImages.length / stockImagesPerPage).ceil();
      emit(editing.copyWith(stockPage: (editing.stockPage + 1) % pageCount));
    }
  }

  void _onTagToggled(DetailsTagToggled event, Emitter<DetailsState> emit) {
    if (state case final DetailsEditing editing when !editing.isBusy) {
      final selected = editing.selectedTagIds;
      emit(
        editing.copyWith(
          selectedTagIds: selected.contains(event.tagId)
              ? selected.difference({event.tagId})
              : {...selected, event.tagId},
        ),
      );
    }
  }

  Future<void> _onTagCreated(DetailsTagCreated event, Emitter<DetailsState> emit) async {
    if (state case final DetailsEditing editing when !editing.isBusy) {
      final busy = editing.copyWith(isBusy: true, error: null);
      emit(busy);
      final result = await _tagRepository.createTag(event.name.trim());
      emit(switch (result) {
        Success(:final data) => busy.copyWith(
          tags: [...busy.tags, data],
          selectedTagIds: {...busy.selectedTagIds, data.id},
          isBusy: false,
        ),
        Failure(:final error) => busy.copyWith(isBusy: false, error: error),
      });
    }
  }

  Future<void> _onPhotographerLinkOpened(
    DetailsPhotographerLinkOpened event,
    Emitter<DetailsState> emit,
  ) async {
    final url = switch (state) {
      DetailsEditing(
        selectedImage: DetailsStockPhoto(image: StockImage(:final photographerUrl)) ||
            DetailsSavedImage(image: StockImage(:final photographerUrl)) ||
            DetailsSavedImage(image: CustomImage(:final photographerUrl)),
      ) =>
        photographerUrl,
      _ => null,
    };
    if (url == null) return;
    if (await _externalLinkRepository.open(url) case Failure(:final error)) {
      if (state case final DetailsEditing editing) emit(editing.copyWith(error: error));
    }
  }

  Future<void> _onSaveRequested(DetailsSaveRequested event, Emitter<DetailsState> emit) async {
    final editing = state;
    if (editing is! DetailsEditing || editing.isBusy) return;
    if (editing.source.isEmpty || editing.target.isEmpty) {
      emit(editing.copyWith(error: const ValidationError()));
      return;
    }
    final busy = editing.copyWith(isBusy: true, error: null);
    emit(busy);
    final result = await _save(editing);
    emit(switch (result) {
      Success() when editing.original == null => const DetailsAdded(),
      Success() => const DetailsClosed(),
      Failure(:final error) => busy.copyWith(isBusy: false, error: error),
    });
  }

  Future<void> _onDeleteRequested(DetailsDeleteRequested event, Emitter<DetailsState> emit) async {
    if (state case DetailsEditing(:final original?, isBusy: false) && final editing) {
      final busy = editing.copyWith(isBusy: true, error: null);
      emit(busy);
      final result = await _vocabularyRepository.deleteVocabulary(original.id);
      emit(switch (result) {
        Success() => const DetailsClosed(),
        Failure(:final error) => busy.copyWith(isBusy: false, error: error),
      });
    }
  }

  Future<AppResult<Vocabulary>> _save(DetailsEditing editing) async {
    final ProcessedImage? newImage;
    switch (editing.selectedImage) {
      case DetailsStockPhoto(:final image):
        switch (await _imageRepository.processStockImage(image)) {
          case Success(:final data):
            newImage = data;
          case Failure(:final error):
            return Failure(error);
        }
      case DetailsNewPhoto(:final image):
        newImage = image;
      case DetailsNoImage() || DetailsSavedImage():
        newImage = null;
    }
    if (editing.original case final original?) {
      return _vocabularyRepository.updateVocabulary(
        id: original.id,
        source: editing.source,
        target: editing.target,
        image: switch ((editing.selectedImage, newImage)) {
          (_, final image?) => ReplaceImage(image: image),
          (DetailsSavedImage(), null) => const KeepImage(),
          (_, null) => const RemoveImage(),
        },
        tagIds: editing.selectedTagIds,
      );
    }
    final languages = editing.languages;
    if (languages == null) return const Failure(ValidationError());
    return _vocabularyRepository.addVocabulary(
      source: editing.source,
      target: editing.target,
      languages: languages,
      image: newImage,
      tagIds: editing.selectedTagIds,
    );
  }

  Future<DetailsEditing> _newWord(String source, {required ProcessedImage? photo}) async {
    final languages = switch (await _settingsRepository.readLanguagePair()) {
      Success(:final data) => data,
      Failure() => null,
    };
    final lookup = languages == null
        ? null
        : await _lookUp(source, languages, pending: DetailsPendingLookup.translationAndPhotos);
    final tags = await _tags();
    final ownPhoto = photo == null ? null : DetailsNewPhoto(image: photo);
    return DetailsEditing(
      original: null,
      languages: languages,
      source: source.trim(),
      target: lookup?.translation ?? "",
      selectedImage: ownPhoto ?? const DetailsNoImage(),
      ownPhoto: ownPhoto,
      stockImages: lookup?.stockImages ?? const [],
      stockPage: 0,
      tags: tags,
      selectedTagIds: const {},
      pendingLookup: lookup?.pending,
      isBusy: false,
      notice: null,
      error: lookup?.error,
    );
  }

  Future<DetailsEditing> _existingWord(Vocabulary vocabulary) async {
    final languages = LanguagePair(
      source: vocabulary.sourceLanguage,
      target: vocabulary.targetLanguage,
    );
    final lookup = await _lookUp(
      vocabulary.source,
      languages,
      pending: DetailsPendingLookup.photos,
    );
    final tags = await _tags();
    return DetailsEditing(
      original: vocabulary,
      languages: languages,
      source: vocabulary.source,
      target: vocabulary.target,
      selectedImage: switch (vocabulary.image) {
        NoImage() => const DetailsNoImage(),
        final image => DetailsSavedImage(image: image),
      },
      ownPhoto: switch (vocabulary.image) {
        final CustomImage image => DetailsSavedImage(image: image),
        NoImage() || StockImage() => null,
      },
      stockImages: lookup.stockImages,
      stockPage: 0,
      tags: tags,
      selectedTagIds: vocabulary.tagIds,
      pendingLookup: lookup.pending,
      isBusy: false,
      notice: null,
      error: lookup.error,
    );
  }

  Future<_Lookup> _lookUp(
    String text,
    LanguagePair languages, {
    required DetailsPendingLookup pending,
  }) async {
    final searchesPhotos = !await _areImagesHidden();
    if (pending == DetailsPendingLookup.photos && !searchesPhotos) {
      return (translation: null, stockImages: const <StockImage>[], error: null, pending: null);
    }
    if (!await _isConnected()) {
      return (translation: null, stockImages: const <StockImage>[], error: null, pending: pending);
    }
    final (translation, stockImages) = await (
      switch (pending) {
        DetailsPendingLookup.translationAndPhotos => _translationRepository.translate(
          text: text,
          languages: languages,
        ),
        DetailsPendingLookup.photos => Future<AppResult<String>?>.value(),
      },
      searchesPhotos
          ? _stockImageRepository.search(query: text, language: languages.source)
          : Future<AppResult<List<StockImage>>?>.value(),
    ).wait;
    final error = switch ((translation, stockImages)) {
      (Failure(:final error), _) || (_, Failure(:final error)) => error,
      _ => null,
    };
    final isOffline = error is ConnectionError && !await _isConnected();
    return (
      translation: switch (translation) {
        Success(:final data) => data,
        Failure() || null => null,
      },
      stockImages: switch (stockImages) {
        Success(:final data) => data,
        Failure() || null => const <StockImage>[],
      },
      error: isOffline ? null : error,
      pending: isOffline ? pending : null,
    );
  }

  Future<void> _watchConnectivity(Emitter<DetailsState> emit) {
    return emit.onEach(
      _connectivityRepository.watchIsConnected(),
      onData: (result) {
        if (result case Success(data: true)) add(const DetailsConnectionRestored());
      },
    );
  }

  Future<bool> _areImagesHidden() async => switch (await _settingsRepository.readPreferences()) {
    Success(data: Preferences(:final areImagesHidden)) => areImagesHidden,
    Failure() => false,
  };

  Future<bool> _isConnected() async => switch (await _connectivityRepository.isConnected()) {
    Success(:final data) => data,
    Failure() => true,
  };

  Future<List<Tag>> _tags() async {
    return switch (await _tagRepository.watchTags().first) {
      Success(:final data) => data,
      Failure() => const [],
    };
  }
}
