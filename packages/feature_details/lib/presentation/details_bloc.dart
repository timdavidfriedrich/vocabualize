import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_details/domain/use_cases/pick_image_use_case.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/entities/vocabulary_image_change.dart';
import 'package:shared/domain/repositories/connectivity_repository.dart';
import 'package:shared/domain/repositories/external_link_repository.dart';
import 'package:shared/domain/repositories/image_repository.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/report_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';
import 'package:shared/domain/repositories/stock_image_repository.dart';
import 'package:shared/domain/repositories/tag_repository.dart';
import 'package:shared/domain/repositories/text_to_speech_repository.dart';
import 'package:shared/domain/repositories/translation_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

typedef _Lookup = ({
  Map<Language, String> translations,
  List<StockImage>? stockImages,
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
    this._textToSpeechRepository,
    this._languageRepository,
  ) : super(const DetailsLoading()) {
    on<DetailsNewStarted>(_onNewStarted);
    on<DetailsEditStarted>(_onEditStarted);
    on<DetailsConnectionRestored>(_onConnectionRestored);
    on<DetailsSpeakRequested>(_onSpeakRequested);
    on<DetailsTranslationReported>(_onTranslationReported);
    on<DetailsDuplicateResolved>(_onDuplicateResolved);
    on<DetailsExistingResolved>(_onExistingResolved);
    on<DetailsTextChanged>(_onTextChanged);
    on<DetailsLanguageToggled>(_onLanguageToggled);
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
  final TextToSpeechRepository _textToSpeechRepository;
  final LanguageRepository _languageRepository;
  DetailsNewStarted? _newWord;

  Future<void> _onNewStarted(DetailsNewStarted event, Emitter<DetailsState> emit) async {
    _newWord = event;
    final setup = await _setup();
    if (setup == null) {
      emit(const DetailsFailure(error: NotFoundError()));
      return;
    }
    switch (await _vocabularyRepository.findVocabulariesWithText(
      language: event.language,
      text: event.text,
    )) {
      case Success(data: []):
        await _startNewWord(emit, setup, event);
      case Success(:final data):
        final inSelected = data.where(
          (vocabulary) => vocabulary.progress.containsKey(setup.selected),
        );
        emit(
          inSelected.isNotEmpty
              ? DetailsDuplicateFound(
                  text: event.text,
                  language: event.language,
                  photo: event.photo,
                  context: event.context,
                )
              : DetailsExistingFound(
                  text: event.text,
                  vocabulary: data.first,
                  language: setup.selected,
                  knownLanguage: data.first.progress.keys.firstOrNull ?? event.language,
                ),
        );
      case Failure(:final error):
        emit(DetailsFailure(error: error));
    }
    await _watchConnectivity(emit);
  }

  Future<void> _onEditStarted(DetailsEditStarted event, Emitter<DetailsState> emit) async {
    switch (await _vocabularyRepository.findVocabulary(event.vocabularyId)) {
      case Success(:final data):
        await _startExistingWord(emit, data, addsLanguage: null);
      case Failure(:final error):
        emit(DetailsFailure(error: error));
    }
    await _watchConnectivity(emit);
  }

  Future<void> _onDuplicateResolved(
    DetailsDuplicateResolved event,
    Emitter<DetailsState> emit,
  ) async {
    final newWord = _newWord;
    if (state case DetailsDuplicateFound() when newWord != null) {
      final setup = await _setup();
      if (event.addsAnyway && setup != null) {
        await _startNewWord(emit, setup, newWord);
      } else {
        emit(const DetailsClosed());
      }
    }
  }

  Future<void> _onExistingResolved(
    DetailsExistingResolved event,
    Emitter<DetailsState> emit,
  ) async {
    if (state case DetailsExistingFound(:final vocabulary, :final language)) {
      if (event.addsLanguage) {
        await _startExistingWord(emit, vocabulary, addsLanguage: language);
      } else {
        emit(const DetailsClosed());
      }
    }
  }

  Future<void> _onConnectionRestored(
    DetailsConnectionRestored event,
    Emitter<DetailsState> emit,
  ) async {
    if (state case DetailsEditing(:final pendingLookup?, runningAction: null) && final editing) {
      await _lookUpAndApply(emit, editing, pending: pendingLookup);
    }
  }

  Future<void> _onSpeakRequested(DetailsSpeakRequested event, Emitter<DetailsState> emit) async {
    if (state case final DetailsEditing editing when editing.textOf(event.language).isNotEmpty) {
      emit(editing.copyWith(error: null));
      final result = await _textToSpeechRepository.speak(
        text: editing.textOf(event.language),
        language: event.language,
      );
      if (result case Failure(:final error)) {
        if (state case final DetailsEditing latest) emit(latest.copyWith(error: error));
      }
    }
  }

  Future<void> _onTranslationReported(
    DetailsTranslationReported event,
    Emitter<DetailsState> emit,
  ) async {
    if (state case final DetailsEditing editing when editing.runningAction == null) {
      final busy = editing.copyWith(runningAction: DetailsAction.report, error: null);
      emit(busy);
      final result = await _reportRepository.sendTranslationReport(
        source: editing.enteredText,
        target: editing.textOf(event.language),
        languages: LanguagePair(source: editing.enteredLanguage, target: event.language),
        note: event.note,
      );
      switch (result) {
        case Success():
          emit(busy.copyWith(runningAction: null, notice: DetailsNotice.translationReported));
          emit(busy.copyWith(runningAction: null, notice: null));
        case Failure(:final error):
          emit(busy.copyWith(runningAction: null, error: error));
      }
    }
  }

  Future<void> _onTextChanged(DetailsTextChanged event, Emitter<DetailsState> emit) async {
    if (state case final DetailsEditing editing when editing.runningAction == null) {
      final text = event.text.trim();
      final isEntered = event.language == editing.enteredLanguage;
      final changed = editing.copyWith(
        texts: {
          ...editing.texts,
          event.language: DetailsText(
            text: text,
            origin: isEntered ? TranslationOrigin.entered : TranslationOrigin.edited,
          ),
        },
        error: null,
      );
      if (!isEntered || !event.retranslates) {
        emit(changed);
        return;
      }
      final retranslated = changed.copyWith(
        texts: {
          for (final MapEntry(key: language, value: entry) in changed.texts.entries)
            if (entry.origin.isFromUser) language: entry,
        },
      );
      await _lookUpAndApply(
        emit,
        retranslated,
        pending: DetailsPendingLookup.translationAndPhotos,
      );
    }
  }

  Future<void> _onLanguageToggled(DetailsLanguageToggled event, Emitter<DetailsState> emit) async {
    if (state case final DetailsEditing editing
        when editing.runningAction == null && editing.canSwitchOff(event.language)) {
      final enabled = editing.enabledLanguages.contains(event.language)
          ? editing.enabledLanguages.difference({event.language})
          : {...editing.enabledLanguages, event.language};
      final toggled = editing.copyWith(enabledLanguages: enabled, error: null);
      if (toggled.missingLanguages.contains(event.language)) {
        await _lookUpAndApply(emit, toggled, pending: DetailsPendingLookup.translations);
      } else {
        emit(toggled);
      }
    }
  }

  Future<void> _onPhotoPickRequested(
    DetailsPhotoPickRequested event,
    Emitter<DetailsState> emit,
  ) async {
    if (state case final DetailsEditing editing when editing.runningAction == null) {
      final busy = editing.copyWith(runningAction: DetailsAction.photoPick, error: null);
      emit(busy);
      final result = await _pickImage(event.source);
      emit(switch (result) {
        Success(data: final image?) => busy.copyWith(
          selectedImage: DetailsNewPhoto(image: image),
          ownPhoto: DetailsNewPhoto(image: image),
          runningAction: null,
        ),
        Success(data: null) => busy.copyWith(runningAction: null),
        Failure(:final error) => busy.copyWith(runningAction: null, error: error),
      });
    }
  }

  void _onImageToggled(DetailsImageToggled event, Emitter<DetailsState> emit) {
    if (state case final DetailsEditing editing when editing.runningAction == null) {
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
    if (state case final DetailsEditing editing when editing.runningAction == null) {
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
    if (state case final DetailsEditing editing when editing.runningAction == null) {
      final busy = editing.copyWith(runningAction: DetailsAction.tagCreation, error: null);
      emit(busy);
      final result = await _tagRepository.createTag(event.name.trim());
      emit(switch (result) {
        Success(:final data) => busy.copyWith(
          tags: [...busy.tags, data],
          selectedTagIds: {...busy.selectedTagIds, data.id},
          runningAction: null,
        ),
        Failure(:final error) => busy.copyWith(runningAction: null, error: error),
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
    if (editing is! DetailsEditing || editing.runningAction != null) return;
    if (!editing.canSave) {
      emit(editing.copyWith(error: const ValidationError()));
      return;
    }
    final busy = editing.copyWith(runningAction: DetailsAction.save, error: null);
    emit(busy);
    final result = await _save(editing);
    emit(switch (result) {
      Success() when editing.original == null => const DetailsAdded(),
      Success() => const DetailsClosed(),
      Failure(:final error) => busy.copyWith(runningAction: null, error: error),
    });
  }

  Future<void> _onDeleteRequested(DetailsDeleteRequested event, Emitter<DetailsState> emit) async {
    if (state case DetailsEditing(:final original?, runningAction: null) && final editing) {
      final busy = editing.copyWith(runningAction: DetailsAction.delete, error: null);
      emit(busy);
      final result = await _vocabularyRepository.deleteVocabulary(original.id);
      emit(switch (result) {
        Success() => const DetailsClosed(),
        Failure(:final error) => busy.copyWith(runningAction: null, error: error),
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
    final translations = [
      for (final MapEntry(key: language, value: entry) in editing.texts.entries)
        if (entry.text.isNotEmpty)
          Translation(language: language, text: entry.text, origin: entry.origin),
    ];
    final active = editing.activeLanguages.toSet();
    final paused = editing.pausedLanguages.toSet();
    final enabled = editing.enabledLanguages;
    if (editing.original case final original?) {
      final existing = original.progress.keys.toSet();
      return _vocabularyRepository.updateVocabulary(
        id: original.id,
        translations: translations,
        startedLanguages: enabled.intersection(active).difference(existing),
        waitingLanguages: enabled.intersection(paused).difference(existing),
        removedLanguages: existing.intersection({...active, ...paused}).difference(enabled),
        image: switch ((editing.selectedImage, newImage)) {
          (_, final image?) => ReplaceImage(image: image),
          (DetailsSavedImage(), null) => const KeepImage(),
          (_, null) => const RemoveImage(),
        },
        tagIds: editing.selectedTagIds,
      );
    }
    return _vocabularyRepository.addVocabulary(
      translations: translations,
      startedLanguages: enabled.intersection(active),
      waitingLanguages: enabled.intersection(paused),
      image: newImage,
      tagIds: editing.selectedTagIds,
    );
  }

  Future<void> _startNewWord(
    Emitter<DetailsState> emit,
    LanguageSetup setup,
    DetailsNewStarted event,
  ) async {
    final ownPhoto = switch (event.photo) {
      final photo? => DetailsNewPhoto(image: photo),
      null => null,
    };
    final editing = DetailsEditing(
      original: null,
      setup: setup,
      enteredLanguage: event.language,
      texts: {
        event.language: DetailsText(text: event.text.trim(), origin: TranslationOrigin.entered),
      },
      enabledLanguages: {for (final learned in setup.learned) learned.language},
      translatingLanguages: const {},
      context: event.context,
      selectedImage: ownPhoto ?? const DetailsNoImage(),
      ownPhoto: ownPhoto,
      stockImages: const [],
      stockPage: 0,
      tags: await _tags(),
      selectedTagIds: const {},
      pendingLookup: null,
      isSearchingPhotos: false,
      runningAction: null,
      notice: null,
      error: null,
    );
    await _lookUpAndApply(emit, editing, pending: DetailsPendingLookup.translationAndPhotos);
  }

  Future<void> _startExistingWord(
    Emitter<DetailsState> emit,
    Vocabulary vocabulary, {
    required Language? addsLanguage,
  }) async {
    final setup = await _setup();
    if (setup == null) {
      emit(const DetailsFailure(error: NotFoundError()));
      return;
    }
    final learned = {for (final learned in setup.learned) learned.language};
    final editing = DetailsEditing(
      original: vocabulary,
      setup: setup,
      enteredLanguage: vocabulary.entered?.language ?? setup.main,
      texts: {
        for (final translation in vocabulary.translations.values)
          translation.language: DetailsText(text: translation.text, origin: translation.origin),
      },
      enabledLanguages: {
        ...vocabulary.progress.keys.toSet().intersection(learned),
        ?addsLanguage,
      },
      translatingLanguages: const {},
      context: null,
      selectedImage: switch (vocabulary.image) {
        NoImage() => const DetailsNoImage(),
        final image => DetailsSavedImage(image: image),
      },
      ownPhoto: switch (vocabulary.image) {
        final CustomImage image => DetailsSavedImage(image: image),
        NoImage() || StockImage() => null,
      },
      stockImages: const [],
      stockPage: 0,
      tags: await _tags(),
      selectedTagIds: vocabulary.tagIds,
      pendingLookup: null,
      isSearchingPhotos: true,
      runningAction: null,
      notice: null,
      error: null,
    );
    await _lookUpAndApply(
      emit,
      editing,
      pending: editing.missingLanguages.isEmpty
          ? DetailsPendingLookup.photos
          : DetailsPendingLookup.translationAndPhotos,
    );
  }

  Future<void> _lookUpAndApply(
    Emitter<DetailsState> emit,
    DetailsEditing editing, {
    required DetailsPendingLookup pending,
  }) async {
    final targets = switch (pending) {
      DetailsPendingLookup.photos => const <Language>{},
      DetailsPendingLookup.translationAndPhotos ||
      DetailsPendingLookup.translations => editing.missingLanguages,
    };
    emit(
      editing.copyWith(
        translatingLanguages: targets,
        runningAction: targets.isEmpty ? editing.runningAction : DetailsAction.lookup,
      ),
    );
    final lookup = await _lookUp(editing, targets: targets, pending: pending);
    if (state case final DetailsEditing current) {
      emit(
        current.copyWith(
          texts: {
            ...current.texts,
            for (final MapEntry(key: language, value: text) in lookup.translations.entries)
              if (current.textOf(language).isEmpty)
                language: DetailsText(text: text, origin: TranslationOrigin.translated),
          },
          translatingLanguages: const {},
          stockImages: lookup.stockImages ?? current.stockImages,
          stockPage: lookup.stockImages == null ? current.stockPage : 0,
          pendingLookup: lookup.pending,
          isSearchingPhotos: false,
          runningAction: targets.isEmpty ? current.runningAction : null,
          error: lookup.error ?? current.error,
        ),
      );
    }
  }

  Future<_Lookup> _lookUp(
    DetailsEditing editing, {
    required Set<Language> targets,
    required DetailsPendingLookup pending,
  }) async {
    final searchesPhotos =
        pending != DetailsPendingLookup.translations && !await _areImagesHidden();
    if (targets.isEmpty && !searchesPhotos) {
      return (
        translations: const <Language, String>{},
        stockImages: null,
        error: null,
        pending: null,
      );
    }
    if (!await _isConnected()) {
      return (
        translations: const <Language, String>{},
        stockImages: null,
        error: null,
        pending: pending,
      );
    }
    final source = editing.enteredLanguage;
    final text = editing.enteredText;
    final (translations, stockImages) = await (
      Future.wait([
        for (final target in targets)
          target.isSameLanguageAs(source)
              ? Future<(Language, AppResult<String>)>.value((target, Success(text)))
              : _translationRepository
                    .translate(text: text, from: source, to: target, context: editing.context)
                    .then((result) => (target, result)),
      ]),
      searchesPhotos
          ? _stockImageRepository.search(query: text, language: source)
          : Future<AppResult<List<StockImage>>?>.value(),
    ).wait;
    final error = [
      for (final (_, result) in translations)
        if (result case Failure(:final error)) error,
      if (stockImages case Failure(:final error)) error,
    ].firstOrNull;
    final isOffline = error is ConnectionError && !await _isConnected();
    return (
      translations: {
        for (final (target, result) in translations)
          if (result case Success(:final data)) target: data,
      },
      stockImages: switch (stockImages) {
        Success(:final data) => data,
        Failure() || null => null,
      },
      error: isOffline ? null : error,
      pending: isOffline ? pending : null,
    );
  }

  Future<LanguageSetup?> _setup() async {
    return switch (await _languageRepository.readLanguageSetup()) {
      Success(:final data) => data,
      Failure() => null,
    };
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
