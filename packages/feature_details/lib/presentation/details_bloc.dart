import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_details/domain/use_cases/pick_image_use_case.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/entities/vocabulary_image_change.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:shared/domain/repositories/external_link_repository.dart';
import 'package:shared/domain/repositories/image_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';
import 'package:shared/domain/repositories/stock_image_repository.dart';
import 'package:shared/domain/repositories/tag_repository.dart';
import 'package:shared/domain/repositories/translation_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

typedef _Lookup = ({String? translation, List<StockImage> stockImages, AppError? error});

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc(
    this._vocabularyRepository,
    this._settingsRepository,
    this._accountRepository,
    this._translationRepository,
    this._stockImageRepository,
    this._imageRepository,
    this._tagRepository,
    this._externalLinkRepository,
    this._pickImage,
  ) : super(const DetailsLoading()) {
    on<DetailsNewStarted>(_onNewStarted);
    on<DetailsEditStarted>(_onEditStarted);
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
  final AccountRepository _accountRepository;
  final TranslationRepository _translationRepository;
  final StockImageRepository _stockImageRepository;
  final ImageRepository _imageRepository;
  final TagRepository _tagRepository;
  final ExternalLinkRepository _externalLinkRepository;
  final PickImageUseCase _pickImage;

  Future<void> _onNewStarted(DetailsNewStarted event, Emitter<DetailsState> emit) async {
    switch (await _vocabularyRepository.hasVocabularyWithSource(event.source)) {
      case Success(data: true):
        emit(DetailsDuplicateFound(source: event.source));
      case Success(data: false):
        emit(await _newWord(event.source));
      case Failure(:final error):
        emit(DetailsFailure(error: error));
    }
  }

  Future<void> _onEditStarted(DetailsEditStarted event, Emitter<DetailsState> emit) async {
    switch (await _vocabularyRepository.findVocabulary(event.vocabularyId)) {
      case Success(:final data):
        emit(await _existingWord(data));
      case Failure(:final error):
        emit(DetailsFailure(error: error));
    }
  }

  Future<void> _onDuplicateResolved(
    DetailsDuplicateResolved event,
    Emitter<DetailsState> emit,
  ) async {
    if (state case DetailsDuplicateFound(:final source)) {
      emit(event.addsAnyway ? await _newWord(source) : const DetailsClosed());
    }
  }

  Future<void> _onSourceChanged(DetailsSourceChanged event, Emitter<DetailsState> emit) async {
    if (state case final DetailsEditing editing when !editing.isBusy) {
      final source = event.source.trim();
      final languages = editing.languages;
      if (!event.retranslates || !editing.canUseAi || languages == null) {
        emit(editing.copyWith(source: source, error: null));
        return;
      }
      final busy = editing.copyWith(source: source, isBusy: true, error: null);
      emit(busy);
      final lookup = await _lookUp(source, languages);
      emit(
        busy.copyWith(
          target: lookup.translation ?? busy.target,
          stockImages: lookup.stockImages,
          stockPage: 0,
          isBusy: false,
          error: lookup.error,
        ),
      );
    }
  }

  void _onTargetChanged(DetailsTargetChanged event, Emitter<DetailsState> emit) {
    if (state case final DetailsEditing editing when !editing.isBusy) {
      emit(editing.copyWith(target: event.target.trim(), error: null));
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

  Future<DetailsEditing> _newWord(String source) async {
    final languages = switch (await _settingsRepository.readLanguagePair()) {
      Success(:final data) => data,
      Failure() => null,
    };
    final canUseAi = await _canUseAi();
    final lookup = canUseAi && languages != null ? await _lookUp(source, languages) : null;
    final tags = await _tags();
    return DetailsEditing(
      original: null,
      languages: languages,
      canUseAi: canUseAi,
      source: source.trim(),
      target: lookup?.translation ?? "",
      selectedImage: const DetailsNoImage(),
      ownPhoto: null,
      stockImages: lookup?.stockImages ?? const [],
      stockPage: 0,
      tags: tags,
      selectedTagIds: const {},
      isBusy: false,
      error: lookup?.error,
    );
  }

  Future<DetailsEditing> _existingWord(Vocabulary vocabulary) async {
    final languages = LanguagePair(
      source: vocabulary.sourceLanguage,
      target: vocabulary.targetLanguage,
    );
    final canUseAi = await _canUseAi();
    final stockSearch = canUseAi
        ? await _stockImageRepository.search(query: vocabulary.source, language: languages.source)
        : null;
    final tags = await _tags();
    return DetailsEditing(
      original: vocabulary,
      languages: languages,
      canUseAi: canUseAi,
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
      stockImages: switch (stockSearch) {
        Success(:final data) => data,
        Failure() || null => const [],
      },
      stockPage: 0,
      tags: tags,
      selectedTagIds: vocabulary.tagIds,
      isBusy: false,
      error: switch (stockSearch) {
        Failure(:final error) => error,
        Success() || null => null,
      },
    );
  }

  Future<_Lookup> _lookUp(String text, LanguagePair languages) async {
    final (translation, stockImages) = await (
      _translationRepository.translate(text: text, languages: languages),
      _stockImageRepository.search(query: text, language: languages.source),
    ).wait;
    return (
      translation: switch (translation) {
        Success(:final data) => data,
        Failure() => null,
      },
      stockImages: switch (stockImages) {
        Success(:final data) => data,
        Failure() => const <StockImage>[],
      },
      error: switch ((translation, stockImages)) {
        (Failure(:final error), _) || (_, Failure(:final error)) => error,
        _ => null,
      },
    );
  }

  Future<List<Tag>> _tags() async {
    return switch (await _tagRepository.watchTags().first) {
      Success(:final data) => data,
      Failure() => const [],
    };
  }

  Future<bool> _canUseAi() async {
    final status = await _accountRepository.watchAuthStatus().first;
    return switch (status) {
      Success(data: AuthAuthenticated(account: GoogleAccount())) => true,
      _ => false,
    };
  }
}
