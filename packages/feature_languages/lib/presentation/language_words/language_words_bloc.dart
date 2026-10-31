import 'package:core/error/app_result.dart';
import 'package:feature_languages/domain/use_cases/add_learned_language_use_case.dart';
import 'package:feature_languages/presentation/language_words/language_words_event.dart';
import 'package:feature_languages/presentation/language_words/language_words_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language_coverage.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/language_words_change.dart';
import 'package:shared/domain/repositories/language_words_repository.dart';

@injectable
class LanguageWordsBloc extends Bloc<LanguageWordsEvent, LanguageWordsState> {
  LanguageWordsBloc(
    this._languageWordsRepository,
    this._addLearnedLanguage,
  ) : super(const LanguageWordsLoading()) {
    on<LanguageWordsStarted>(_onStarted);
    on<LanguageWordsOptionChanged>(_onOptionChanged);
    on<LanguageWordsCollectionToggled>(_onCollectionToggled);
    on<LanguageWordsUntaggedToggled>(_onUntaggedToggled);
    on<LanguageWordsNewWordsChanged>(_onNewWordsChanged);
    on<LanguageWordsSaveRequested>(_onSaveRequested);
    on<LanguageWordsSaveConfirmed>(_onSaveConfirmed);
    on<LanguageWordsSaveCancelled>(_onSaveCancelled);
  }

  final LanguageWordsRepository _languageWordsRepository;
  final AddLearnedLanguageUseCase _addLearnedLanguage;

  Future<void> _onStarted(LanguageWordsStarted event, Emitter<LanguageWordsState> emit) {
    return emit.forEach(
      _languageWordsRepository.watchLanguageCoverage(event.language),
      onData: (result) => switch ((state, result)) {
        (final LanguageWordsEditing editing, Success(:final data)) => editing.copyWith(
          coverage: data,
        ),
        (_, Success(:final data)) => _initial(event, data),
        (_, Failure(:final error)) => LanguageWordsFailure(error: error),
      },
    );
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
    return LanguageWordsEditing(
      language: event.language,
      isAdding: event.isAdding,
      coverage: coverage,
      option: LanguageWordsOption.all,
      initialSelection: selection,
      selection: selection,
      initialUntagged: untagged,
      untagged: untagged,
      newWords: defaultNewWordLimit,
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
          selection: {
            ...editing.selection,
            event.tagId: editing.selection[event.tagId] != true,
          },
        ),
      );
    }
  }

  void _onUntaggedToggled(LanguageWordsUntaggedToggled event, Emitter<LanguageWordsState> emit) {
    if (state case final LanguageWordsEditing editing when !editing.isSaving) {
      emit(editing.copyWith(untagged: editing.untagged != true));
    }
  }

  void _onNewWordsChanged(LanguageWordsNewWordsChanged event, Emitter<LanguageWordsState> emit) {
    if (state case final LanguageWordsEditing editing when !editing.isSaving) {
      emit(editing.copyWith(newWords: event.newWords));
    }
  }

  Future<void> _onSaveRequested(
    LanguageWordsSaveRequested event,
    Emitter<LanguageWordsState> emit,
  ) async {
    if (state case final LanguageWordsEditing editing when !editing.isSaving) {
      final saving = editing.copyWith(isSaving: true, error: null);
      emit(saving);
      if (editing.isAdding) {
        _finish(
          emit,
          await _addLearnedLanguage(
            language: editing.language,
            newWords: editing.newWords,
            words: switch (editing.option) {
              LanguageWordsOption.all => addAllWords,
              LanguageWordsOption.choose => editing.change,
              LanguageWordsOption.none => null,
            },
          ),
        );
        return;
      }
      emit(switch (await _languageWordsRepository.previewChange(editing.language, editing.change)) {
        Success(:final data) => saving.copyWith(preview: data),
        Failure(:final error) => saving.copyWith(isSaving: false, error: error),
      });
    }
  }

  Future<void> _onSaveConfirmed(
    LanguageWordsSaveConfirmed event,
    Emitter<LanguageWordsState> emit,
  ) async {
    if (state case final LanguageWordsEditing editing when editing.preview != null) {
      _finish(
        emit,
        await _languageWordsRepository.applyChange(editing.language, editing.change),
      );
    }
  }

  void _onSaveCancelled(LanguageWordsSaveCancelled event, Emitter<LanguageWordsState> emit) {
    if (state case final LanguageWordsEditing editing) {
      emit(editing.copyWith(preview: null, isSaving: false));
    }
  }

  void _finish(Emitter<LanguageWordsState> emit, AppResult<()> result) {
    switch ((state, result)) {
      case (_, Success()):
        emit(const LanguageWordsSaved());
      case (final LanguageWordsEditing editing, Failure(:final error)):
        emit(editing.copyWith(isSaving: false, preview: null, error: error));
      case (_, Failure()):
        break;
    }
  }
}
