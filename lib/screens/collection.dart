import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';
import 'package:vocabualize/widgets/voc_card.dart';

class Collection extends StatefulWidget {
  const Collection({Key? key}) : super(key: key);

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Collection"),
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text("Delete all"),
                onTap: () => Provider.of<VocProv>(context, listen: false)
                    .clearVocabularyList(),
              ),
            ],
          )
        ],
      ),
      body: Provider.of<VocProv>(context).getVocabularyList().isEmpty
          ? const Center(
              child: Text(
              "Your vocabularies\nwill appear here.",
              textAlign: TextAlign.center,
            ))
          : GridView.builder(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 1,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24),
              itemCount:
                  Provider.of<VocProv>(context).getVocabularyList().length,
              itemBuilder: ((context, index) => VocCard(
                  vocabulary: Provider.of<VocProv>(context)
                      .getVocabularyList()
                      .elementAt(index)))),
    );
  }
}
