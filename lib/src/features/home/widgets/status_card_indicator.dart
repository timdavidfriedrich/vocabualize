import 'dart:async';

import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_to_practise_use_case.dart';

class StatusCardIndicator extends StatefulWidget {
  final Widget parent;
  final Tag? tag;

  const StatusCardIndicator({super.key, required this.parent, this.tag});

  @override
  State<StatusCardIndicator> createState() => _StatusCardIndicatorState();
}

class _StatusCardIndicatorState extends State<StatusCardIndicator> {
  final getVocabulariesToPractise = sl.get<GetVocabulariesToPractiseUseCase>();
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
    return FutureBuilder(
        future: getVocabulariesToPractise(tag: widget.tag),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return widget.parent;
          }
          final vocabularies = snapshot.data;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              widget.parent,
              vocabularies == null || vocabularies.isEmpty
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
                          "${vocabularies.length}",
                          style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10),
                        ),
                      ),
                    ),
            ],
          );
        });
  }
}
