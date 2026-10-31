import 'package:core/error/app_result.dart';
import 'package:feature_languages/presentation/onboarding/language_onboarding_event.dart';
import 'package:feature_languages/presentation/onboarding/language_onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/repositories/language_repository.dart';

@injectable
class LanguageOnboardingBloc extends Bloc<LanguageOnboardingEvent, LanguageOnboardingState> {
  LanguageOnboardingBloc(this._languageRepository) : super(const LanguageOnboardingLoading()) {
    on<LanguageOnboardingStarted>(_onStarted);
    on<LanguageOnboardingMainChanged>(_onMainChanged);
    on<LanguageOnboardingLearnedToggled>(_onLearnedToggled);
    on<LanguageOnboardingSaveRequested>(_onSaveRequested);
  }

  final LanguageRepository _languageRepository;

  void _onStarted(LanguageOnboardingStarted event, Emitter<LanguageOnboardingState> emit) {
    final main = switch (_languageRepository.readDeviceLanguage()) {
      Success(data: final language) when supportedLanguages.contains(language) => language,
      Success() || Failure() => supportedLanguages.first,
    };
    emit(LanguageOnboardingEditing(main: main, learned: const [], isSaving: false, error: null));
  }

  void _onMainChanged(
    LanguageOnboardingMainChanged event,
    Emitter<LanguageOnboardingState> emit,
  ) {
    if (state case final LanguageOnboardingEditing editing when !editing.isSaving) {
      emit(
        editing.copyWith(
          main: event.language,
          learned: [
            for (final language in editing.learned)
              if (!language.isSameLanguageAs(event.language)) language,
          ],
          error: null,
        ),
      );
    }
  }

  void _onLearnedToggled(
    LanguageOnboardingLearnedToggled event,
    Emitter<LanguageOnboardingState> emit,
  ) {
    if (state case final LanguageOnboardingEditing editing
        when !editing.isSaving && !event.language.isSameLanguageAs(editing.main)) {
      emit(
        editing.copyWith(
          learned: editing.learned.contains(event.language)
              ? [
                  for (final language in editing.learned)
                    if (language != event.language) language,
                ]
              : [...editing.learned, event.language],
          error: null,
        ),
      );
    }
  }

  Future<void> _onSaveRequested(
    LanguageOnboardingSaveRequested event,
    Emitter<LanguageOnboardingState> emit,
  ) async {
    if (state case final LanguageOnboardingEditing editing
        when !editing.isSaving && editing.learned.isNotEmpty) {
      final saving = editing.copyWith(isSaving: true, error: null);
      emit(saving);
      final result = await _languageRepository.setUpLanguages(
        main: editing.main,
        learned: editing.learned,
      );
      emit(switch (result) {
        Success() => const LanguageOnboardingSaved(),
        Failure(:final error) => saving.copyWith(isSaving: false, error: error),
      });
    }
  }
}
