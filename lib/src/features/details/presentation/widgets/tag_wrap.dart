import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/use_cases/tag/get_all_tags_use_case.dart';
import 'package:vocabualize/src/features/details/presentation/controllers/details_controller.dart';
import 'package:vocabualize/src/features/details/presentation/states/details_state.dart';

class TagWrap extends ConsumerWidget {
  final DetailsState state;
  final Refreshable<DetailsController> notifier;

  const TagWrap({
    required this.state,
    required this.notifier,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllTagsUseCaseProvider).when(
      loading: () {
        return const SizedBox();
      },
      error: (error, stackStrace) {
        return const SizedBox();
      },
      data: (List<Tag> tags) {
        return Wrap(
          spacing: Dimensions.smallSpacing,
          runSpacing: -Dimensions.smallSpacing,
          children: List.generate(tags.length + 1, (index) {
            if (index == tags.length) {
              return _CreateButton(notifier: notifier);
            }
            final tag = tags.elementAt(index);
            final isSelected = state.vocabulary.tagIds.contains(tag.id);
            return _TagChip(
              notifier: notifier,
              tag: tag,
              selected: isSelected,
            );
          }),
        );
      },
    );
  }
}

class _CreateButton extends ConsumerWidget {
  final Refreshable<DetailsController> notifier;
  const _CreateButton({required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(notifier).openCreateTagDialogAndSave(context);
      },
      icon: const Icon(Icons.add_rounded),
    );
  }
}

class _TagChip extends ConsumerWidget {
  final Refreshable<DetailsController> notifier;
  final Tag tag;
  final bool selected;
  const _TagChip({
    required this.notifier,
    required this.tag,
    required this.selected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilterChip(
      label: Text(tag.name),
      selected: selected,
      onSelected: (enabled) {
        ref.read(notifier).addOrRemoveTag(tag.id);
      },
    );
  }
}
