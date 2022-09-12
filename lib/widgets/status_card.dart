import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/level_colors.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/screens/practise.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';
import 'package:vocabualize/utils/teleport.dart';

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
                      Icon(Icons.circle, color: hardColor),
                      Text("${Provider.of<VocProv>(context).vocabularyList.where((voc) => voc.level == 1).length}"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Icon(Icons.circle, color: okayColor),
                      Text("${Provider.of<VocProv>(context).vocabularyList.where((voc) => voc.level == 2).length}"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Icon(Icons.circle, color: easyColor),
                      Text("${Provider.of<VocProv>(context).vocabularyList.where((voc) => voc.level == 3).length}"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: () => Navigator.push(context, Teleport(child: const Practise())), child: const Text("Practise")),
            ],
          )
        ],
      ),
    );
  }
}
