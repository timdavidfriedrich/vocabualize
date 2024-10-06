import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/filter_options.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_use_case.dart';
import 'package:vocabualize/src/features/collections/states/collection_state.dart';
import 'package:vocabualize/src/features/practise/screens/practise_screen.dart';
import 'package:vocabualize/src/features/practise/utils/practise_arguments.dart';

final collectionControllerProvider = AutoDisposeAsyncNotifierProviderFamily<CollectionController, CollectionState, Tag>(() {
  return CollectionController();
});

class CollectionController extends AutoDisposeFamilyAsyncNotifier<CollectionState, Tag> {
  List<Vocabulary> _tagVocabularies = [];

  @override
  Future<CollectionState> build(Tag arg) async {
    final tag = arg;
    final getVocabularies = ref.watch(getVocabulariesUseCaseProvider(FilterOptions(tag: tag)));
    getVocabularies.when(
      loading: () {},
      error: (_, __) {},
      data: (vocabularies) => _tagVocabularies = vocabularies,
    );

    return CollectionState(
      tag: tag,
      tagVocabularies: _tagVocabularies,
      areImagesEnabled: await ref.watch(getAreImagesEnabledUseCaseProvider.future),
    );
  }

  void editTag() {
    // TODO: implement edit tag / collection
  }

  void startPractise({required BuildContext context, required Tag tag}) {
    Navigator.pushNamed(
      context,
      PractiseScreen.routeName,
      arguments: PractiseScreenArguments(
        tag: tag,
      ),
    );
  }
}
