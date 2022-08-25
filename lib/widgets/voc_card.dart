import 'package:flutter/material.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';

class VocCard extends StatelessWidget {
  final Vocabulary vocabulary;
  const VocCard({required this.vocabulary, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Text(vocabulary.getTarget()),
        Text(vocabulary.getSource())
      ]),
    );
  }
}
