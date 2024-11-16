import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';

class AddTagDialog extends StatefulWidget {
  const AddTagDialog({super.key});

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void submit() {
      final text = _controller.text;
      Navigator.pop<String?>(context, text.takeUnless((t) => t.isEmpty));
    }

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.extraExtraLargeSpacing),
      contentPadding: const EdgeInsets.fromLTRB(
        Dimensions.semiSmallSpacing,
        Dimensions.semiSmallSpacing,
        Dimensions.smallSpacing,
        Dimensions.semiSmallSpacing,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.record_addTagHint,
                  label: Text(AppLocalizations.of(context)?.record_addTagLabel ?? ""),
                ),
              ),
            ),
            const SizedBox(width: Dimensions.smallSpacing),
            IconButton(
              onPressed: () => submit(),
              icon: switch (_controller.text.isNotEmpty) {
                true => const Icon(Icons.save_rounded),
                false => const Icon(Icons.close_rounded),
              },
            ),
          ],
        ),
      ),
    );
  }
}
