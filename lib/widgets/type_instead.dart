import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/utils/providers/lang_provider.dart';
import 'package:vocabualize/utils/providers/visible_provider.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';
import 'package:vocabualize/utils/translator.dart';

class TypeInstead extends StatefulWidget {
  const TypeInstead({Key? key}) : super(key: key);

  @override
  State<TypeInstead> createState() => _TypeInsteadState();
}

class _TypeInsteadState extends State<TypeInstead> {
  String currentSource = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            readOnly: false,
            decoration: const InputDecoration(hintText: "Type instead"),
            onTap: () => Provider.of<VisibleProv>(context, listen: false)
                .setTypeIsActive(true),
            onChanged: (value) => setState(() => currentSource = value),
          ),
        ),
        currentSource.isEmpty ? Container() : const SizedBox(width: 24),
        currentSource.isEmpty
            ? Container()
            : ElevatedButton(
                onPressed: () async {
                  Provider.of<VisibleProv>(context, listen: false)
                      .setTypeIsActive(false);
                  Provider.of<VocProv>(context, listen: false)
                      .addToVocabularyList(
                    Vocabulary(
                      source: currentSource,
                      target:
                          await Translator.translate(context, currentSource),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    onPrimary: Theme.of(context).colorScheme.onSecondary),
                child: const Icon(Icons.done_outline_rounded),
              ),
      ],
    );
  }
}
