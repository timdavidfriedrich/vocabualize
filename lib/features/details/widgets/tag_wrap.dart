import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/details/widgets/add_tag_dialog.dart';

class TagWrap extends StatefulWidget {
  const TagWrap({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

  @override
  State<TagWrap> createState() => _TagWrapState();
}

class _TagWrapState extends State<TagWrap> {
  _add() {
    showDialog(context: context, builder: (context) => AddTagDialog(vocabulary: widget.vocabulary));
  }

  _delete(String tag) {
    widget.vocabulary.deleteTag(tag);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.vocabulary.tags.isEmpty
        // TODO: Replace with arb
        ? Row(children: [const Text("Tags:"), IconButton(onPressed: () => _add(), icon: const Icon(Icons.add_rounded))])
        : Wrap(
            spacing: 8,
            runSpacing: -8,
            children: List.generate(
              widget.vocabulary.tags.length + 1,
              (index) => index == widget.vocabulary.tags.length
                  ? IconButton(onPressed: () => _add(), icon: const Icon(Icons.add_rounded))
                  : Chip(
                      label: Text(widget.vocabulary.tags.elementAt(index)),
                      deleteIconColor: Theme.of(context).colorScheme.onSurface,
                      onDeleted: () => _delete(widget.vocabulary.tags.elementAt(index)),
                    ),
            ),
          );
  }
}
