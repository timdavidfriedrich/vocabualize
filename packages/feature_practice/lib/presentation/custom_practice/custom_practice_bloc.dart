import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_practice/domain/use_cases/build_custom_practice_use_case.dart';
import 'package:feature_practice/domain/use_cases/count_custom_practice_use_case.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_event.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/domain/repositories/custom_practice_repository.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/language_words_repository.dart';
import 'package:shared/domain/repositories/tag_repository.dart';

@injectable
class CustomPracticeBloc extends Bloc<CustomPracticeEvent, CustomPracticeState> {
  CustomPracticeBloc(
    this._languageRepository,
    this._tagRepository,
    this._languageWordsRepository,
    this._customPracticeRepository,
    this._buildCustomPractice,
    this._countCustomPractice,
  ) : super(const CustomPracticeLoading()) {
    on<CustomPracticeStarted>(_onStarted);
    on<CustomPracticeLanguageToggled>(_onLanguageToggled);
    on<CustomPracticeAllWordsToggled>(_onAllWordsToggled);
    on<CustomPracticeNewWordsChanged>(_onNewWordsChanged);
    on<CustomPracticeCollectionsChanged>(_onCollectionsChanged);
    on<CustomPracticeCountsRequested>(_onCountsRequested, transformer: restartable());
    on<CustomPracticePreviewRequested>(_onPreviewRequested, transformer: restartable());
    on<CustomPracticeStartRequested>(_onStartRequested);
  }

  final LanguageRepository _languageRepository;
  final TagRepository _tagRepository;
  final LanguageWordsRepository _languageWordsRepository;
  final CustomPracticeRepository _customPracticeRepository;
  final BuildCustomPracticeUseCase _buildCustomPractice;
  final CountCustomPracticeUseCase _countCustomPractice;

  Future<void> _onStarted(CustomPracticeStarted event, Emitter<CustomPracticeState> emit) async {
    final (setup, previews, session) = await (
      _languageRepository.readLanguageSetup(),
      _tagRepository.watchCollectionPreviews().first,
      _customPracticeRepository.readSession(),
    ).wait;
    switch ((setup, previews, session)) {
      case (Failure(:final error), _, _) ||
          (_, Failure(:final error), _) ||
          (_, _, Failure(:final error)):
        emit(CustomPracticeFailure(error: error));
      case (
        Success(data: final setup?),
        Success(data: final previews),
        Success(data: final session),
      ):
        final coverage = await _languageWordsRepository.watchLanguageCoverage(setup.selected).first;
        emit(
          CustomPracticeEditing(
            setup: setup,
            tags: [for (final preview in previews) preview.tag],
            collectionImages: {
              for (final preview in previews) preview.tag.id: ?preview.images.firstOrNull,
            },
            collectionCounts: switch (coverage) {
              Success(:final data) => {
                for (final collection in data.collections) collection.tag.id: collection.totalCount,
              },
              Failure() => const {},
            },
            tagIds: {?event.tagId},
            enabledLanguages: {setup.selected},
            allWordsLanguages: const {},
            newWordCounts: const {},
            counts: null,
            previewImages: const [],
            hasUnfinishedSession: session != null,
            isStarting: false,
            error: null,
          ),
        );
        add(const CustomPracticeCountsRequested());
        add(const CustomPracticePreviewRequested());
      case (Success(data: null), _, _):
        emit(const CustomPracticeFailure(error: NotFoundError()));
    }
  }

  void _onLanguageToggled(CustomPracticeLanguageToggled event, Emitter<CustomPracticeState> emit) {
    if (state case final CustomPracticeEditing editing when !editing.isStarting) {
      final languages = editing.enabledLanguages;
      emit(
        editing.copyWith(
          enabledLanguages: languages.contains(event.language)
              ? languages.difference({event.language})
              : {...languages, event.language},
        ),
      );
      add(const CustomPracticePreviewRequested());
    }
  }

  void _onAllWordsToggled(CustomPracticeAllWordsToggled event, Emitter<CustomPracticeState> emit) {
    if (state case final CustomPracticeEditing editing when !editing.isStarting) {
      final languages = editing.allWordsLanguages;
      emit(
        editing.copyWith(
          allWordsLanguages: languages.contains(event.language)
              ? languages.difference({event.language})
              : {...languages, event.language},
        ),
      );
    }
  }

  void _onNewWordsChanged(CustomPracticeNewWordsChanged event, Emitter<CustomPracticeState> emit) {
    if (state case final CustomPracticeEditing editing when !editing.isStarting) {
      final waiting = editing.waitingCountOf(event.language);
      emit(
        editing.copyWith(
          newWordCounts: {
            ...editing.newWordCounts,
            event.language: event.count.clamp(0, waiting),
          },
        ),
      );
    }
  }

  void _onCollectionsChanged(
    CustomPracticeCollectionsChanged event,
    Emitter<CustomPracticeState> emit,
  ) {
    if (state case final CustomPracticeEditing editing when !editing.isStarting) {
      emit(editing.copyWith(tagIds: event.tagIds, counts: null, newWordCounts: const {}));
      add(const CustomPracticeCountsRequested());
      add(const CustomPracticePreviewRequested());
    }
  }

  Future<void> _onCountsRequested(
    CustomPracticeCountsRequested event,
    Emitter<CustomPracticeState> emit,
  ) async {
    if (state case final CustomPracticeEditing editing) {
      final result = await _countCustomPractice(
        languages: editing.activeLanguages,
        tagIds: editing.tagIds,
      );
      if (state case final CustomPracticeEditing latest) {
        emit(switch (result) {
          Success(:final data) => latest.copyWith(counts: data),
          Failure(:final error) => latest.copyWith(counts: const {}, error: error),
        });
      }
    }
  }

  Future<void> _onPreviewRequested(
    CustomPracticePreviewRequested event,
    Emitter<CustomPracticeState> emit,
  ) async {
    if (state case final CustomPracticeEditing editing) {
      final result = await _countCustomPractice.previewImages(
        languages: editing.enabledLanguages,
        tagIds: editing.tagIds,
      );
      if (state case final CustomPracticeEditing latest) {
        if (result case Success(:final data)) emit(latest.copyWith(previewImages: data));
      }
    }
  }

  Future<void> _onStartRequested(
    CustomPracticeStartRequested event,
    Emitter<CustomPracticeState> emit,
  ) async {
    if (state case final CustomPracticeEditing editing when !editing.isStarting) {
      final starting = editing.copyWith(isStarting: true, error: null);
      emit(starting);
      final plan = editing.plan;
      switch (await _buildCustomPractice(plan)) {
        case Success(data: []):
          emit(starting.copyWith(isStarting: false));
        case Success(:final data):
          final saved = await _customPracticeRepository.saveSession(
            CustomPracticeSession(
              filter: plan.filter,
              items: data,
              doneCount: 0,
              startedAt: DateTime.now().toUtc(),
            ),
          );
          emit(switch (saved) {
            Success() => const CustomPracticeLaunched(),
            Failure(:final error) => starting.copyWith(isStarting: false, error: error),
          });
        case Failure(:final error):
          emit(starting.copyWith(isStarting: false, error: error));
      }
    }
  }
}
