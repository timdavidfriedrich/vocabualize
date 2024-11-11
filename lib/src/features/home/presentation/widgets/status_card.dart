import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/home/domain/utils/card_generator.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/status_card_indicator.dart';
import 'package:vocabualize/src/features/practise/presentation/screens/practise_screen.dart';

class StatusCard extends StatelessWidget {
  final List<Vocabulary>? vocabularies;
  const StatusCard({required this.vocabularies, super.key});

  @override
  Widget build(BuildContext context) {
    void startPractise() {
      Navigator.pushNamed(
        context,
        PractiseScreen.routeName,
      );
    }

    final message = CardGenerator.generateMessage(vocabularies);
    final beginnerAmout = vocabularies?.where((voc) {
      return voc.level.color == LevelPalette.beginner;
    }).length;
    final advancedAmount = vocabularies?.where((voc) {
      return voc.level.color == LevelPalette.advanced;
    }).length;
    final expertAmount = vocabularies?.where((voc) {
      return voc.level.color == LevelPalette.expert;
    }).length;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.left,
          ),
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
                      Text("${beginnerAmout ?? '?'}"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.advanced),
                      Text("${advancedAmount ?? '?'}"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.expert),
                      Text("${expertAmount ?? '?'}"),
                    ],
                  ),
                ],
              ),
              StatusCardIndicator(
                parent: ElevatedButton(
                  onPressed: () => startPractise(),
                  child: Text(AppLocalizations.of(context)?.home_statusCard_practiseButton ?? ""),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
