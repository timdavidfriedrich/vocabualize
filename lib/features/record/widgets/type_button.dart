import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/record/providers/active_provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/translator.dart';

class TypeButton extends StatefulWidget {
  const TypeButton({Key? key}) : super(key: key);

  @override
  State<TypeButton> createState() => _TypeButtonState();
}

class _TypeButtonState extends State<TypeButton> {
  TextEditingController controller = TextEditingController();
  String currentSource = "";

  _focus() {
    Provider.of<ActiveProvider>(context, listen: false).typeIsActive = true;
  }

  _cancel() {
    FocusManager.instance.primaryFocus?.unfocus();
    controller.clear();
    currentSource = "";
    Provider.of<ActiveProvider>(context, listen: false).typeIsActive = false;
  }

  _submit() async {
    Messenger.loadingAnimation();
    Vocabulary newVocabulary = Vocabulary(source: currentSource, target: await Translator.translate(currentSource));
    if (!mounted) return;
    Provider.of<VocabularyProvider>(context, listen: false).add(newVocabulary).whenComplete(() {
      Navigator.pop(context);
      Messenger.showSaveMessage(newVocabulary);
    });
    currentSource = "";
    controller.clear();
    Provider.of<ActiveProvider>(context, listen: false).typeIsActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          toolbarOptions: const ToolbarOptions(copy: false, cut: false, paste: false, selectAll: false),
          autofocus: false,
          controller: controller,
          textInputAction: TextInputAction.done,
          maxLength: 20,
          maxLines: 1,
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            enabled: !Provider.of<ActiveProvider>(context).micIsActive,
            hintText: "Type instead ...",
            counterText: "",
            contentPadding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 4), borderRadius: BorderRadius.circular(16)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).hintColor, width: 4), borderRadius: BorderRadius.circular(16)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 4), borderRadius: BorderRadius.circular(16)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 4), borderRadius: BorderRadius.circular(16)),
          ),
          onTap: Provider.of<ActiveProvider>(context).micIsActive ? () {} : () => _focus(),
          onChanged: (text) {
            setState(() => currentSource = text);
            _focus(); // long pressing on field ignores onTap, that's why this workaround
          },
          onFieldSubmitted: (text) async => _submit,
        ),
        currentSource.isEmpty && !Provider.of<ActiveProvider>(context).typeIsActive ? Container() : const SizedBox(height: 16),
        currentSource.isEmpty && !Provider.of<ActiveProvider>(context).typeIsActive
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      side: BorderSide(width: 3, color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    onPressed: () => _cancel(),
                    child: const Text("Close"),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () => _submit(),
                      child: const Text("Add"),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
