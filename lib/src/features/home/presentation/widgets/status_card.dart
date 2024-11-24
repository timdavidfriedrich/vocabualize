import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/src/features/home/domain/utils/card_generator.dart';
import 'package:vocabualize/src/features/home/presentation/states/home_state.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/status_card_indicator.dart';
import 'package:vocabualize/src/features/practise/presentation/screens/practise_screen.dart';

class StatusCard extends ConsumerWidget {
  final HomeState state;
  const StatusCard({required this.state, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void startPractise() {
      Navigator.pushNamed(
        context,
        PractiseScreen.routeName,
      );
    }

    final message = CardGenerator.generateMessage(state.vocabularies);
    final beginnerAmout = state.vocabularies.where((voc) {
      return voc.level.color == LevelPalette.beginner;
    }).length;
    final advancedAmount = state.vocabularies.where((voc) {
      return voc.level.color == LevelPalette.advanced;
    }).length;
    final expertAmount = state.vocabularies.where((voc) {
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
                      Text("$beginnerAmout"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.advanced),
                      Text("$advancedAmount"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.expert),
                      Text("$expertAmount"),
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
