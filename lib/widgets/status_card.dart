import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.displayMedium,
                children: const [
                  TextSpan(text: "Wow, you already added 16 words today."),
                  TextSpan(text: "\n\n"),
                  TextSpan(text: "Let's practise!", style: TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.circle, color: Colors.red),
                      Text("${Provider.of<VocProv>(context).getVocabularyList().where((voc) => voc.getLevel() == 1).length}"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: Colors.orange),
                      Text("${Provider.of<VocProv>(context).getVocabularyList().where((voc) => voc.getLevel() == 2).length}"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: Colors.green),
                      Text("${Provider.of<VocProv>(context).getVocabularyList().where((voc) => voc.getLevel() == 3).length}"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: () {}, child: const Text("Practise")),
            ],
          )
        ],
      ),
    );
  }
}
