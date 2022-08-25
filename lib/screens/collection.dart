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
      appBar: AppBar(title: const Text("Collection")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 64),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 1,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24),
            itemCount: Provider.of<VocProv>(context, listen: false)
                .getVocabularyList()
                .length,
            itemBuilder: ((context, index) => VocCard(
                vocabulary: Provider.of<VocProv>(context, listen: false)
                    .getVocabularyList()
                    .elementAt(index)))),
      ),
    );
  }
}
