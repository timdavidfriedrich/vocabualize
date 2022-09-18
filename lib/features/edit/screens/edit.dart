import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class Edit extends StatelessWidget {
  const Edit({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Edit", style: Theme.of(context).textTheme.headlineMedium),
                    IconButton(
                      onPressed: () {
                        Provider.of<VocabularyProvider>(context, listen: false).remove(vocabulary);
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                      },
                      icon: const Icon(Icons.delete_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                Expanded(
                    child: Column(
                  children: [
                    TextField(decoration: InputDecoration(hintText: vocabulary.source)),
                    TextField(decoration: InputDecoration(hintText: vocabulary.target)),
                    TextField(decoration: InputDecoration(hintText: vocabulary.source)),
                    TextField(decoration: InputDecoration(hintText: vocabulary.source)),
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.popUntil(context, ModalRoute.withName("/")),
                      child: const Text("Save"),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
