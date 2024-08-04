import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/presentation/providers/vocabulary_provider.dart';
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
  _add() async {
    await HelperWidgets.showStaticDialog(AddTagDialog(vocabulary: widget.vocabulary)).whenComplete(() => setState(() {}));
  }

  _toggleTag(Tag tag) {
    if (widget.vocabulary.tags.contains(tag)) {
      widget.vocabulary.deleteTag(tag);
    } else {
      widget.vocabulary.addTag(tag);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Tag> allTags = Provider.of<VocabularyProvider>(context).allTags;
    return Wrap(
      spacing: 8,
      runSpacing: -8,
      children: List.generate(
        allTags.length + 1,
        (index) => index == allTags.length
            ? IconButton(onPressed: () => _add(), icon: const Icon(Icons.add_rounded))
            : FilterChip(
                label: Text(allTags.elementAt(index).name),
                backgroundColor: widget.vocabulary.tags.contains(allTags.elementAt(index)) ? Theme.of(context).primaryColor : null,
                onSelected: (enabled) => _toggleTag(allTags.elementAt(index)),
              ),
      ),
    );
  }
}
