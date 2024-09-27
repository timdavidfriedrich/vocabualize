import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/usecases/tag/get_all_tags_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/update_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/widgets/add_tag_dialog.dart';

class TagWrap extends ConsumerWidget {
  final Vocabulary vocabulary;

  const TagWrap({super.key, required this.vocabulary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getAllTags = ref.watch(getAllTagsUseCaseProvider);

    void add() async {
      await HelperWidgets.showStaticDialog(
        AddTagDialog(vocabulary: vocabulary),
      );
      // TODO: In TagWrap were "setState(() {});" before. Maybe this doesn't update anymore?
    }

    void toggleTag(Tag tag) {
      if (vocabulary.tags.contains(tag)) {
        final updatedVocabulary = vocabulary.copyWith(
          tags: vocabulary.tags.where((t) => t != tag).toList(),
        );
        ref.read(updateVocabularyUseCaseProvider(updatedVocabulary));
      } else {
        final updatedVocabulary = vocabulary.copyWith(
          tags: [...vocabulary.tags, tag],
        );
        ref.read(updateVocabularyUseCaseProvider(updatedVocabulary));
      }
      // TODO: In TagWrap were "setState(() {});" before. Maybe this doesn't update anymore?
    }

    return getAllTags.when(
      loading: () {
        return const SizedBox();
      },
      error: (error, stackStrace) {
        return const SizedBox();
      },
      data: (List<Tag> tags) {
        return Wrap(
          spacing: 8,
          runSpacing: -8,
          children: List.generate(
            tags.length + 1,
            (index) {
              if (index == tags.length) {
                return IconButton(
                  onPressed: () => add(),
                  icon: const Icon(Icons.add_rounded),
                );
              }
              final tag = tags.elementAt(index);
              final vocabularyTags = vocabulary.tags;
              return FilterChip(
                label: Text(tag.name),
                backgroundColor: vocabularyTags.contains(tag) ? Theme.of(context).primaryColor : null,
                onSelected: (enabled) => toggleTag(tag),
              );
            },
          ),
        );
      },
    );
  }
}
