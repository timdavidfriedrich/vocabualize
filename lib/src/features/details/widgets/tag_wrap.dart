import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/usecases/tag/get_all_tags_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/update_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/widgets/add_tag_dialog.dart';

class TagWrap extends StatefulWidget {
  final Vocabulary vocabulary;

  const TagWrap({super.key, required this.vocabulary});

  @override
  State<TagWrap> createState() => _TagWrapState();
}

class _TagWrapState extends State<TagWrap> {
  final getAllTags = sl.get<GetAllTagsUseCase>();
  final updateVocabulary = sl.get<UpdateVocabularyUseCase>();

  _add() async {
    await HelperWidgets.showStaticDialog(AddTagDialog(vocabulary: widget.vocabulary)).whenComplete(() => setState(() {}));
  }

  _toggleTag(Tag tag) {
    if (widget.vocabulary.tags.contains(tag)) {
      final updatedVocabulary = widget.vocabulary.copyWith(
        tags: widget.vocabulary.tags.where((t) => t != tag).toList(),
      );
      updateVocabulary(updatedVocabulary);
    } else {
      final updatedVocabulary = widget.vocabulary.copyWith(
        tags: [...widget.vocabulary.tags, tag],
      );
      updateVocabulary(updatedVocabulary);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllTags(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container();
        }
        final allTags = snapshot.data ?? <Tag>[];
        return Wrap(
          spacing: 8,
          runSpacing: -8,
          children: List.generate(
            allTags.length + 1,
            (index) {
              if (index == allTags.length) {
                return IconButton(
                  onPressed: () => _add(),
                  icon: const Icon(Icons.add_rounded),
                );
              } else {
                final tag = allTags.elementAt(index);
                final vocabularyTags = widget.vocabulary.tags;
                return FilterChip(
                  label: Text(tag.name),
                  backgroundColor: vocabularyTags.contains(tag) ? Theme.of(context).primaryColor : null,
                  onSelected: (enabled) => _toggleTag(tag),
                );
              }
            },
          ),
        );
      },
    );
  }
}
