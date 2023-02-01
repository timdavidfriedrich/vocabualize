import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/features/home/services/card_generator.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/home/widgets/status_card_indicator.dart';
import 'package:vocabualize/features/practise/screens/practise.dart';
import 'package:vocabualize/features/practise/services/practise_arguments.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void startPractise() {
      Navigator.pushNamed(
        context,
        Practise.routeName,
        arguments: PractiseArguments(vocabulariesToPractise: Provider.of<VocabularyProvider>(context, listen: false).allToPractise),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Text(CardGenerator.info, style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.beginner),
                      Text(
                        "${Provider.of<VocabularyProvider>(context).vocabularyList.where((voc) => voc.level.color == LevelPalette.beginner).length}",
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.advanced),
                      Text(
                        "${Provider.of<VocabularyProvider>(context).vocabularyList.where((voc) => voc.level.color == LevelPalette.advanced).length}",
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.expert),
                      Text(
                        "${Provider.of<VocabularyProvider>(context).vocabularyList.where((voc) => voc.level.color == LevelPalette.expert).length}",
                      ),
                    ],
                  ),
                ],
              ),
              StatusCardIndicator(
                parent: ElevatedButton(
                  onPressed: () => startPractise(),
                  child: Text(AppLocalizations.of(context).home_statusCard_practiseButton),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
