import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_practice/domain/use_cases/build_custom_practice_use_case.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_event.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/domain/repositories/custom_practice_repository.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/tag_repository.dart';

@injectable
class CustomPracticeBloc extends Bloc<CustomPracticeEvent, CustomPracticeState> {
  CustomPracticeBloc(
    this._languageRepository,
    this._tagRepository,
    this._customPracticeRepository,
    this._buildCustomPractice,
  ) : super(const CustomPracticeLoading()) {
    on<CustomPracticeStarted>(_onStarted);
    on<CustomPracticeLanguageToggled>(_onLanguageToggled);
    on<CustomPracticeAllLanguagesSelected>(_onAllLanguagesSelected);
    on<CustomPracticeCollectionsModeChanged>(_onCollectionsModeChanged);
    on<CustomPracticeCollectionToggled>(_onCollectionToggled);
    on<CustomPracticeWordsChanged>(_onWordsChanged);
    on<CustomPracticeNewWordsChanged>(_onNewWordsChanged);
    on<CustomPracticeCountRequested>(_onCountRequested, transformer: restartable());
    on<CustomPracticeStartRequested>(_onStartRequested);
  }

  final LanguageRepository _languageRepository;
  final TagRepository _tagRepository;
  final CustomPracticeRepository _customPracticeRepository;
  final BuildCustomPracticeUseCase _buildCustomPractice;

  Future<void> _onStarted(CustomPracticeStarted event, Emitter<CustomPracticeState> emit) async {
    final (setup, tags, session) = await (
      _languageRepository.readLanguageSetup(),
      _tagRepository.watchTags().first,
      _customPracticeRepository.readSession(),
    ).wait;
    switch ((setup, tags, session)) {
      case (Failure(:final error), _, _) ||
          (_, Failure(:final error), _) ||
          (_, _, Failure(:final error)):
        emit(CustomPracticeFailure(error: error));
      case (Success(data: final setup?), Success(data: final tags), Success(data: final session)):
        emit(
          CustomPracticeEditing(
            setup: setup,
            tags: tags,
            filter: CustomPracticeFilter(
              languages: {setup.selected},
              tagIds: {?event.tagId},
              words: PracticeWords.due,
              newWords: PracticeNewWords.upToCap,
            ),
            isChoosingCollections: event.tagId != null,
            count: null,
            hasUnfinishedSession: session != null,
            isStarting: false,
            error: null,
          ),
        );
        add(const CustomPracticeCountRequested());
      case (Success(data: null), _, _):
        emit(const CustomPracticeFailure(error: NotFoundError()));
    }
  }

  void _onLanguageToggled(CustomPracticeLanguageToggled event, Emitter<CustomPracticeState> emit) {
    _changeFilter(emit, (editing) {
      final languages = editing.filter.languages;
      return editing.filter.copyWith(
        languages: languages.contains(event.language)
            ? languages.difference({event.language})
            : {...languages, event.language},
      );
    });
  }

  void _onAllLanguagesSelected(
    CustomPracticeAllLanguagesSelected event,
    Emitter<CustomPracticeState> emit,
  ) {
    _changeFilter(
      emit,
      (editing) => editing.filter.copyWith(
        languages: {for (final learned in editing.setup.active) learned.language},
      ),
    );
  }

  void _onCollectionsModeChanged(
    CustomPracticeCollectionsModeChanged event,
    Emitter<CustomPracticeState> emit,
  ) {
    if (state case final CustomPracticeEditing editing when !editing.isStarting) {
      emit(
        editing.copyWith(
          isChoosingCollections: event.isChoosing,
          filter: event.isChoosing ? editing.filter : editing.filter.copyWith(tagIds: const {}),
        ),
      );
      add(const CustomPracticeCountRequested());
    }
  }

  void _onCollectionToggled(
    CustomPracticeCollectionToggled event,
    Emitter<CustomPracticeState> emit,
  ) {
    _changeFilter(emit, (editing) {
      final tagIds = editing.filter.tagIds;
      return editing.filter.copyWith(
        tagIds: tagIds.contains(event.tagId)
            ? tagIds.difference({event.tagId})
            : {...tagIds, event.tagId},
      );
    });
  }

  void _onWordsChanged(CustomPracticeWordsChanged event, Emitter<CustomPracticeState> emit) {
    _changeFilter(emit, (editing) => editing.filter.copyWith(words: event.words));
  }

  void _onNewWordsChanged(CustomPracticeNewWordsChanged event, Emitter<CustomPracticeState> emit) {
    _changeFilter(emit, (editing) => editing.filter.copyWith(newWords: event.newWords));
  }

  Future<void> _onCountRequested(
    CustomPracticeCountRequested event,
    Emitter<CustomPracticeState> emit,
  ) async {
    if (state case final CustomPracticeEditing editing) {
      final result = await _buildCustomPractice(_effectiveFilter(editing));
      if (state case final CustomPracticeEditing latest) {
        emit(switch (result) {
          Success(:final data) => latest.copyWith(count: data.length),
          Failure(:final error) => latest.copyWith(count: 0, error: error),
        });
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
      final filter = _effectiveFilter(editing);
      switch (await _buildCustomPractice(filter)) {
        case Success(data: []):
          emit(starting.copyWith(isStarting: false, count: 0));
        case Success(:final data):
          final saved = await _customPracticeRepository.saveSession(
            CustomPracticeSession(
              filter: filter,
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

  void _changeFilter(
    Emitter<CustomPracticeState> emit,
    CustomPracticeFilter Function(CustomPracticeEditing editing) change,
  ) {
    if (state case final CustomPracticeEditing editing when !editing.isStarting) {
      emit(editing.copyWith(filter: change(editing), count: null, error: null));
      add(const CustomPracticeCountRequested());
    }
  }

  CustomPracticeFilter _effectiveFilter(CustomPracticeEditing editing) {
    return editing.isChoosingCollections
        ? editing.filter
        : editing.filter.copyWith(tagIds: const <String>{});
  }
}
