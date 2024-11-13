import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/presentation/widgets/edit_source_target_dialog.dart';

class SourceToTarget extends StatefulWidget {
  final Vocabulary vocabulary;
  final bool isVertical;

  const SourceToTarget({super.key, required this.vocabulary, this.isVertical = false});

  @override
  State<SourceToTarget> createState() => _SourceToTargetState();
}

class _SourceToTargetState extends State<SourceToTarget> {
  Future<void> _click({required bool editTarget}) async {
    await context
        .showDialog(EditSourceTargetDialog(vocabulary: widget.vocabulary, editTarget: editTarget))
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      Flexible(
        child: TextButton(
          onPressed: () => _click(editTarget: false),
          child: Text(widget.vocabulary.source, textAlign: TextAlign.right, style: Theme.of(Global.context).textTheme.displayMedium),
        ),
      ),
      const SizedBox(width: 8, height: 8),
      Icon(widget.isVertical ? Icons.arrow_downward_rounded : Icons.arrow_forward_rounded,
          color: Theme.of(Global.context).colorScheme.primary),
      const SizedBox(width: 8, height: 8),
      Flexible(
        child: TextButton(
          onPressed: () => _click(editTarget: true),
          child: Text(widget.vocabulary.target, textAlign: TextAlign.left, style: Theme.of(Global.context).textTheme.displayMedium),
        ),
      ),
    ];

    return widget.isVertical
        ? Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: children)
        : Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: children);
  }
}
