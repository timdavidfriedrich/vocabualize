import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';

class StatusCardIndicator extends StatefulWidget {
  const StatusCardIndicator({super.key, required this.parent});

  final Widget parent;

  @override
  State<StatusCardIndicator> createState() => _StatusCardIndicatorState();
}

class _StatusCardIndicatorState extends State<StatusCardIndicator> {
  late Timer timer;

  _startReloadTimer() async {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {});
    });
  }

  _cancelReloadTimer() {
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.parent,
        Provider.of<VocabularyProvider>(context).allToPractise.isEmpty
            ? Container()
            : Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "${Provider.of<VocabularyProvider>(context).allToPractise.length}",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10),
                  ),
                ),
              ),
      ],
    );
  }
}
