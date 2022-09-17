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

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            autofocus: false,
            controller: controller,
            textInputAction: TextInputAction.done,
            maxLength: 20,
            maxLines: 1,
            decoration: InputDecoration(
              enabled: !Provider.of<ActiveProvider>(context).micIsActive,
              hintText: "Type instead ...",
              counterText: "",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 4),
                  borderRadius: BorderRadius.circular(16)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 4),
                  borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 4),
                  borderRadius: BorderRadius.circular(16)),
            ),
            onTap: Provider.of<ActiveProvider>(context).micIsActive
                ? () {}
                : () => Provider.of<ActiveProvider>(context, listen: false).typeIsActive = true,
            onChanged: (text) => setState(() => currentSource = text),
            onFieldSubmitted: (text) async {
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
            },
          ),
        ),
        currentSource.isEmpty && !Provider.of<ActiveProvider>(context).typeIsActive
            ? Container()
            : IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.clear();
                  currentSource = "";
                  Provider.of<ActiveProvider>(context, listen: false).typeIsActive = false;
                },
                icon: const Icon(Icons.clear_rounded),
              ),
      ],
    );
  }
}
