import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_to_practise_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/is_collection_multilingual_use_case.dart';
import 'package:vocabualize/src/features/practise/states/practise_state.dart';

final practiseControllerProvider = AutoDisposeAsyncNotifierProviderFamily<PractiseController, PractiseState, Tag?>(() {
  return PractiseController();
});

class PractiseController extends AutoDisposeFamilyAsyncNotifier<PractiseState, Tag?> {
  // TODO: Not sure if ref.read will work here.
  @override
  Future<PractiseState> build(Tag? arg) async {
    state = const AsyncLoading();
    final vocabulariesToPractise = await ref.read(getVocabulariesToPractiseUseCaseProvider(arg));
    return PractiseState(
      initialVocabularyCount: vocabulariesToPractise.length,
      vocabulariesLeftToPractise: vocabulariesToPractise,
      isMultilingual: await ref.watch(isCollectionMultilingualUseCaseProvider),
      isSolutionShown: false,
      areImagesDisabled: await ref.watch(getAreImagesEnabledUseCaseProvider),
    );
  }

  void showSolution(bool value) {
    final newState = state.asData?.value.copyWith(
      isSolutionShown: value,
    );
    if (newState != null) {
      state = AsyncData(newState);
    }
  }
}
