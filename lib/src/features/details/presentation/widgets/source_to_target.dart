import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/features/details/presentation/controllers/details_controller.dart';
import 'package:vocabualize/src/features/details/presentation/states/details_state.dart';

class SourceToTarget extends StatelessWidget {
  final DetailsState state;
  final Refreshable<DetailsController> notifier;
  final bool isVertical;

  const SourceToTarget({
    super.key,
    required this.state,
    required this.notifier,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      Flexible(
        child: _SourceButton(state: state, notifier: notifier),
      ),
      const SizedBox(
        width: Dimensions.smallSpacing,
        height: Dimensions.smallSpacing,
      ),
      Icon(
        isVertical ? Icons.arrow_downward_rounded : Icons.arrow_forward_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
      const SizedBox(
        width: Dimensions.smallSpacing,
        height: Dimensions.smallSpacing,
      ),
      Flexible(
        child: _TargetButton(state: state, notifier: notifier),
      ),
    ];

    return switch (isVertical) {
      true => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      false => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
    };
  }
}

class _SourceButton extends ConsumerWidget {
  final DetailsState state;
  final Refreshable<DetailsController> notifier;
  const _SourceButton({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.read(notifier).openEditSourceDialog(context);
      },
      child: Text(
        state.vocabulary.source,
        textAlign: TextAlign.right,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}

class _TargetButton extends ConsumerWidget {
  final DetailsState state;
  final Refreshable<DetailsController> notifier;
  const _TargetButton({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.read(notifier).openEditTargetDialog(context);
      },
      child: Text(
        state.vocabulary.target,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
