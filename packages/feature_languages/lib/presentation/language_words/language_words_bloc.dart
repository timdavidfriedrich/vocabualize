import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_languages/domain/use_cases/add_learned_language_use_case.dart';
import 'package:feature_languages/presentation/language_words/language_words_event.dart';
import 'package:feature_languages/presentation/language_words/language_words_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language_coverage.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/language_words_change.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/repositories/language_words_repository.dart';
import 'package:shared/domain/repositories/tag_repository.dart';

@injectable
class LanguageWordsBloc extends Bloc<LanguageWordsEvent, LanguageWordsState> {
  LanguageWordsBloc(
    this._languageWordsRepository,
    this._tagRepository,
    this._addLearnedLanguage,
  ) : super(const LanguageWordsLoading()) {
    on<LanguageWordsStarted>(_onStarted);
    on<LanguageWordsOptionChanged>(_onOptionChanged);
    on<LanguageWordsCollectionToggled>(_onCollectionToggled);
    on<LanguageWordsUntaggedToggled>(_onUntaggedToggled);
    on<LanguageWordsPreviewRequested>(_onPreviewRequested, transformer: restartable());
    on<LanguageWordsSaveRequested>(_onSaveRequested);
  }

  final LanguageWordsRepository _languageWordsRepository;
  final TagRepository _tagRepository;
  final AddLearnedLanguageUseCase _addLearnedLanguage;

  Future<void> _onStarted(LanguageWordsStarted event, Emitter<LanguageWordsState> emit) async {
    await Future.wait([
      emit.forEach(
        _languageWordsRepository.watchLanguageCoverage(event.language),
        onData: (result) => switch ((state, result)) {
          (final LanguageWordsEditing editing, Success(:final data)) => editing.copyWith(
            coverage: data,
          ),
          (_, Success(:final data)) => _initial(event, data),
          (_, Failure(:final error)) => LanguageWordsFailure(error: error),
        },
      ),
      emit.forEach(
        _tagRepository.watchCollectionPreviews(),
        onData: (result) => switch ((state, result)) {
          (final LanguageWordsEditing editing, Success(:final data)) => editing.copyWith(
            images: {
              for (final preview in data) preview.tag.id: ?preview.images.firstOrNull,
            },
          ),
          (_, Success()) || (_, Failure()) => state,
        },
      ),
    ]);
  }

  LanguageWordsEditing _initial(LanguageWordsStarted event, LanguageCoverage coverage) {
    final selection = {
      for (final collection in coverage.collections)
        collection.tag.id: event.isAdding
            ? false
            : _stateOf(collection.inLanguageCount, collection.totalCount),
    };
    final untagged = event.isAdding
        ? false
        : _stateOf(coverage.untaggedInLanguageCount, coverage.untaggedCount);
    add(const LanguageWordsPreviewRequested());
    return LanguageWordsEditing(
      language: event.language,
      isAdding: event.isAdding,
      coverage: coverage,
      images: const <String, VocabularyImage>{},
      option: LanguageWordsOption.all,
      initialSelection: selection,
      selection: selection,
      initialUntagged: untagged,
      untagged: untagged,
      preview: null,
      isSaving: false,
      error: null,
    );
  }

  bool? _stateOf(int inLanguage, int total) => switch (inLanguage) {
    0 => false,
    _ when inLanguage >= total => true,
    _ => null,
  };

  void _onOptionChanged(LanguageWordsOptionChanged event, Emitter<LanguageWordsState> emit) {
    if (state case final LanguageWordsEditing editing when !editing.isSaving) {
      emit(editing.copyWith(option: event.option));
    }
  }

  void _onCollectionToggled(
    LanguageWordsCollectionToggled event,
    Emitter<LanguageWordsState> emit,
  ) {
    if (state case final LanguageWordsEditing editing when !editing.isSaving) {
      emit(
        editing.copyWith(
          option: LanguageWordsOption.choose,
          selection: {
            ...editing.selection,
            event.tagId: editing.selection[event.tagId] != true,
          },
        ),
      );
      add(const LanguageWordsPreviewRequested());
    }
  }

  void _onUntaggedToggled(LanguageWordsUntaggedToggled event, Emitter<LanguageWordsState> emit) {
    if (state case final LanguageWordsEditing editing when !editing.isSaving) {
      emit(
        editing.copyWith(option: LanguageWordsOption.choose, untagged: editing.untagged != true),
      );
      add(const LanguageWordsPreviewRequested());
    }
  }

  Future<void> _onPreviewRequested(
    LanguageWordsPreviewRequested event,
    Emitter<LanguageWordsState> emit,
  ) async {
    if (state case final LanguageWordsEditing editing) {
      final result = await _languageWordsRepository.previewChange(editing.language, editing.change);
      if (state case final LanguageWordsEditing latest) {
        emit(switch (result) {
          Success(:final data) => latest.copyWith(preview: data),
          Failure(:final error) => latest.copyWith(error: error),
        });
      }
    }
  }

  Future<void> _onSaveRequested(
    LanguageWordsSaveRequested event,
    Emitter<LanguageWordsState> emit,
  ) async {
    if (state case final LanguageWordsEditing editing when !editing.isSaving) {
      emit(editing.copyWith(isSaving: true, error: null));
      final result = editing.isAdding
          ? await _addLearnedLanguage(
              language: editing.language,
              newWords: defaultNewWordLimit,
              words: switch (editing.option) {
                LanguageWordsOption.all => addAllWords,
                LanguageWordsOption.choose => editing.change,
                LanguageWordsOption.none => null,
              },
            )
          : await _languageWordsRepository.applyChange(editing.language, editing.change);
      switch ((state, result)) {
        case (_, Success()):
          emit(const LanguageWordsSaved());
        case (final LanguageWordsEditing latest, Failure(:final error)):
          emit(latest.copyWith(isSaving: false, error: error));
        case (_, Failure()):
          break;
      }
    }
  }
}
