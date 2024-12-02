import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/entities/level.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/features/home/domain/utils/card_generator.dart';
import 'package:vocabualize/src/features/home/presentation/states/home_state.dart';
import 'package:vocabualize/src/common/presentation/widgets/status_card_indicator.dart';
import 'package:vocabualize/src/features/practise/presentation/screens/practise_screen.dart';

class StatusCard extends ConsumerWidget {
  final HomeState state;
  const StatusCard({required this.state, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.semiLargeSpacing),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Dimensions.largeBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardMessage(state),
          const SizedBox(height: Dimensions.semiLargeSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LevelStatistics(state),
              const StatusCardIndicator(
                parent: _PractiseButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardMessage extends StatelessWidget {
  final HomeState state;
  const _CardMessage(this.state);

  @override
  Widget build(BuildContext context) {
    final message = CardGenerator.generateMessage(state.vocabularies);
    return Text(
      message,
      style: Theme.of(context).textTheme.displayMedium,
      textAlign: TextAlign.left,
    );
  }
}

class _LevelStatistics extends StatelessWidget {
  final HomeState state;
  const _LevelStatistics(this.state);

  @override
  Widget build(BuildContext context) {
    final levelCounts = state.vocabularies.fold<Map<Type, int>>(
      {BeginnerLevel: 0, AdvancedLevel: 0, ExpertLevel: 0},
      (counts, voc) {
        counts.update(voc.level.runtimeType, (x) => x + 1, ifAbsent: () => 1);
        return counts;
      },
    );
    final beginnerCount = levelCounts[BeginnerLevel] ?? 0;
    final advancedCount = levelCounts[AdvancedLevel] ?? 0;
    final expertCount = levelCounts[ExpertLevel] ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Icon(Icons.circle, color: LevelPalette.beginner),
            Text("$beginnerCount"),
          ],
        ),
        const SizedBox(width: Dimensions.semiSmallSpacing),
        Column(
          children: [
            const Icon(Icons.circle, color: LevelPalette.advanced),
            Text("$advancedCount"),
          ],
        ),
        const SizedBox(width: Dimensions.semiSmallSpacing),
        Column(
          children: [
            const Icon(Icons.circle, color: LevelPalette.expert),
            Text("$expertCount"),
          ],
        ),
      ],
    );
  }
}

class _PractiseButton extends StatelessWidget {
  const _PractiseButton();

  @override
  Widget build(BuildContext context) {
    void startPractise() {
      context.pushNamed(PractiseScreen.routeName);
    }

    final strings = AppLocalizations.of(context);
    return ElevatedButton(
      onPressed: () => startPractise(),
      child: Text(
        strings?.home_statusCard_practiseButton ?? "",
      ),
    );
  }
}
