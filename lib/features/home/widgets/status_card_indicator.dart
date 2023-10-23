import 'dart:async';

import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/models/tag.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';

class StatusCardIndicator extends StatefulWidget {
  final Widget parent;
  final Tag? tag;

  const StatusCardIndicator({super.key, required this.parent, this.tag});

  @override
  State<StatusCardIndicator> createState() => _StatusCardIndicatorState();
}

class _StatusCardIndicatorState extends State<StatusCardIndicator> {
  late Timer timer;

  void _startReloadTimer() async {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {});
    });
  }

  void _cancelReloadTimer() {
    if (timer.isActive) timer.cancel();
  }

  List _getCurrentList() {
    if (widget.tag != null) {
      return Provider.of<VocabularyProvider>(context, listen: false).getAllToPractiseForTag(widget.tag!);
    } else {
      return Provider.of<VocabularyProvider>(context, listen: false).allToPractise;
    }
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
        _getCurrentList().isEmpty
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
                    "${_getCurrentList().length}",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10),
                  ),
                ),
              ),
      ],
    );
  }
}
