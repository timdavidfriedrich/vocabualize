import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/domain/entities/filter_options.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/vocabulary/get_vocabularies_use_case.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/features/collections/presentation/states/collection_state.dart';
import 'package:vocabualize/src/features/practise/presentation/screens/practise_screen.dart';

final collectionControllerProvider = AutoDisposeAsyncNotifierProviderFamily<CollectionController, CollectionState, Tag>(() {
  return CollectionController();
});

class CollectionController extends AutoDisposeFamilyAsyncNotifier<CollectionState, Tag> {
  @override
  Future<CollectionState> build(Tag arg) async {
    final tag = arg;
    return CollectionState(
      tag: tag,
      tagVocabularies: ref.watch(getVocabulariesUseCaseProvider).call(filterOptions: FilterOptions(tag: tag)),
      areImagesEnabled: await ref.watch(getAreImagesEnabledUseCaseProvider.future),
    );
  }

  void editTag() {
    // TODO: implement edit tag / collection
  }

  void startPractise({required BuildContext context, required Tag tag}) {
    context.pushNamed(
      PractiseScreen.routeName,
      arguments: PractiseScreenArguments(
        tag: tag,
      ),
    );
  }
}
