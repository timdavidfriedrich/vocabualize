import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/features/home/controllers/home_controller.dart';

class StatusCardIndicator extends ConsumerStatefulWidget {
  final Widget parent;
  final Tag? tag;

  const StatusCardIndicator({super.key, required this.parent, this.tag});

  @override
  ConsumerState<StatusCardIndicator> createState() => _StatusCardIndicatorState();
}

class _StatusCardIndicatorState extends ConsumerState<StatusCardIndicator> {
  late Timer timer;

  void _startReloadTimer() async {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {});
    });
  }

  void _cancelReloadTimer() {
    if (timer.isActive) timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _startReloadTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _cancelReloadTimer();
  }

  @override
  Widget build(BuildContext context) {
    final voabulariesToPractise = ref.watch(homeControllerProvider.notifier).getVocabulariesToPracise();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.parent,
        Positioned(
          top: -4,
          right: -4,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "${voabulariesToPractise.length}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
