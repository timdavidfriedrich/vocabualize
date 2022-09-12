import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/utils/messenger.dart';
import 'package:vocabualize/utils/providers/active_provider.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';
import 'package:vocabualize/utils/translator.dart';

class TypeInstead extends StatefulWidget {
  const TypeInstead({Key? key}) : super(key: key);

  @override
  State<TypeInstead> createState() => _TypeInsteadState();
}

class _TypeInsteadState extends State<TypeInstead> {
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
              enabled: !Provider.of<ActiveProv>(context).micIsActive,
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
            onTap: Provider.of<ActiveProv>(context).micIsActive
                ? () {}
                : () => Provider.of<ActiveProv>(context, listen: false).typeIsActive = true,
            onChanged: (text) => setState(() => currentSource = text),
            onFieldSubmitted: (text) async {
              Messenger.loadingAnimation();
              Provider.of<VocProv>(context, listen: false)
                  .addToVocabularyList(Vocabulary(source: currentSource, target: await Translator.translate(currentSource)))
                  .whenComplete(() {
                controller.clear();
                currentSource = "";
                Navigator.pop(context);
                Messenger.saveMessage(text);
                Provider.of<ActiveProv>(context, listen: false).typeIsActive = false;
              });
            },
          ),
        ),
        currentSource.isEmpty && !Provider.of<ActiveProv>(context).typeIsActive
            ? Container()
            : IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.clear();
                  currentSource = "";
                  Provider.of<ActiveProv>(context, listen: false).typeIsActive = false;
                },
                icon: const Icon(Icons.clear_rounded),
              ),
      ],
    );
  }
}
