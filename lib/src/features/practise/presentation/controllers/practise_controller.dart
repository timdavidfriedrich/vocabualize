import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/domain/entities/answer.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';
import 'package:vocabualize/src/common/domain/use_cases/language/get_language_by_id_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/language/read_out_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/vocabulary/add_or_update_vocabulary_use_case.dart';
import 'package:vocabualize/src/features/practise/domain/use_cases/answer_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/vocabulary/get_vocabularies_to_practise_use_case.dart';
import 'package:vocabualize/src/features/practise/domain/use_cases/is_collection_multilingual_use_case.dart';
import 'package:vocabualize/src/features/practise/presentation/states/practise_state.dart';

final practiseControllerProvider = AutoDisposeAsyncNotifierProviderFamily<
    PractiseController, PractiseState, Tag?>(() {
  return PractiseController();
});

class PractiseController
    extends AutoDisposeFamilyAsyncNotifier<PractiseState, Tag?> {
  @override
  Future<PractiseState> build(Tag? arg) async {
    final tag = arg;
    List<Vocabulary> vocabulariesToPractise = ref.read(
      getVocabulariesToPractiseUseCaseProvider(tag),
    );
    return PractiseState(
      initialVocabularyCount: vocabulariesToPractise.length,
      vocabulariesLeft: vocabulariesToPractise,
      isMultilingual: await ref.read(
        isCollectionMultilingualUseCaseProvider(tag),
      ),
      isSolutionShown: false,
      areImagesEnabled: await ref.read(
        getAreImagesEnabledUseCaseProvider.future,
      ),
    );
  }

  Future<String> getMultilingualLabel(PractiseState state) async {
    final currentVocabulary = state.currentVocabulary;
    final getLanguageById = ref.read(getLanguageByIdUseCaseProvider);
    final currentSourceLanguage = await getLanguageById(
      currentVocabulary.sourceLanguageId,
    );
    final currentTargetLanguage = await getLanguageById(
      currentVocabulary.targetLanguageId,
    );
    return "${currentSourceLanguage?.name}  ►  ${currentTargetLanguage?.name}";
  }

  void readOutCurrent() {
    state.value?.let((value) {
      final readOut = ref.read(readOutUseCaseProvider);
      readOut(value.currentVocabulary);
    });
  }

  void showSolution() {
    final newState = state.value?.copyWith(
      isSolutionShown: true,
    );
    newState?.let((s) {
      state = AsyncData(s);
    });
  }

  Future<void> answerCurrent(Answer answer) async {
    final previousState = state.value;
    state = const AsyncLoading();
    previousState?.let((previous) async {
      final answerVocabulary = ref.read(answerVocabularyUseCaseProvider);
      state = await AsyncValue.guard(() async {
        final updatedVocabulary = await answerVocabulary(
          vocabulary: previous.currentVocabulary,
          answer: answer,
        );
        await ref.read(addOrUpdateVocabularyUseCaseProvider(updatedVocabulary));
        return previous.copyWith(
          vocabulariesLeftToPractise: previous.vocabulariesLeft.sublist(1),
          isSolutionShown: false,
        );
      });
    });
  }
}
