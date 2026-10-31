import 'package:core/error/app_result.dart';
import 'package:feature_welcome/presentation/language_selection/language_selection_event.dart';
import 'package:feature_welcome/presentation/language_selection/language_selection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/repositories/language_repository.dart';

@injectable
class LanguageSelectionBloc extends Bloc<LanguageSelectionEvent, LanguageSelectionState> {
  LanguageSelectionBloc(this._languageRepository) : super(const LanguageSelectionLoading()) {
    on<LanguageSelectionStarted>(_onStarted);
    on<LanguageSelectionSourceChanged>(_onSourceChanged);
    on<LanguageSelectionTargetChanged>(_onTargetChanged);
    on<LanguageSelectionSaveRequested>(_onSaveRequested);
  }

  final LanguageRepository _languageRepository;

  Future<void> _onStarted(
    LanguageSelectionStarted event,
    Emitter<LanguageSelectionState> emit,
  ) async {
    final pair = switch (await _languageRepository.readLanguageSetup()) {
      Success(data: LanguageSetup(:final main, :final selected)) => LanguagePair(
        source: main,
        target: selected,
      ),
      Success() || Failure() => _suggestedPair(),
    };
    emit(LanguageSelectionEditing(pair: pair, isSaving: false, error: null));
  }

  void _onSourceChanged(
    LanguageSelectionSourceChanged event,
    Emitter<LanguageSelectionState> emit,
  ) {
    if (state case final LanguageSelectionEditing editing when !editing.isSaving) {
      final pair = editing.pair;
      emit(
        editing.copyWith(
          pair: LanguagePair(
            source: event.language,
            target: event.language.isSameLanguageAs(pair.target) ? pair.source : pair.target,
          ),
        ),
      );
    }
  }

  void _onTargetChanged(
    LanguageSelectionTargetChanged event,
    Emitter<LanguageSelectionState> emit,
  ) {
    if (state case final LanguageSelectionEditing editing when !editing.isSaving) {
      final pair = editing.pair;
      emit(
        editing.copyWith(
          pair: LanguagePair(
            source: event.language.isSameLanguageAs(pair.source) ? pair.target : pair.source,
            target: event.language,
          ),
        ),
      );
    }
  }

  Future<void> _onSaveRequested(
    LanguageSelectionSaveRequested event,
    Emitter<LanguageSelectionState> emit,
  ) async {
    if (state case final LanguageSelectionEditing editing when !editing.isSaving) {
      final saving = editing.copyWith(isSaving: true, error: null);
      emit(saving);
      emit(switch (await _languageRepository.setUpLanguages(
        main: editing.pair.source,
        learned: [editing.pair.target],
      )) {
        Success() => const LanguageSelectionSaved(),
        Failure(:final error) => saving.copyWith(isSaving: false, error: error),
      });
    }
  }

  LanguagePair _suggestedPair() {
    final source = switch (_languageRepository.readDeviceLanguage()) {
      Success(data: final language) when supportedLanguages.contains(language) => language,
      Success() || Failure() => supportedLanguages.first,
    };
    return LanguagePair(
      source: source,
      target: supportedLanguages.firstWhere((language) => !language.isSameLanguageAs(source)),
    );
  }
}
