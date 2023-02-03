import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/home/screens/home_screen.dart';

class SaveMessage extends StatefulWidget {
  final Vocabulary vocabulary;
  final Duration animationDuration;
  final Duration stayDuration;

  const SaveMessage({super.key, required this.vocabulary, animationDuration, stayDuration})
      : animationDuration = animationDuration ?? const Duration(milliseconds: 2000),
        stayDuration = stayDuration ?? const Duration(milliseconds: 3000);

  @override
  State<SaveMessage> createState() => _SaveMessageState();
}

class _SaveMessageState extends State<SaveMessage> {
  double dismissedEnd = -150;

  Tween<double> tween = Tween<double>(begin: -64, end: 0);

  double currentValue = -1;

  bool deleted = false;

  disappear() => setState(() => tween = Tween<double>(begin: 0, end: dismissedEnd));

  delete() => setState(() => deleted = true);

  autoDisappear() async => await Future.delayed(widget.stayDuration).whenComplete(() => currentValue != 0 || !mounted ? null : disappear());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          TweenAnimationBuilder(
            tween: tween,
            duration: widget.animationDuration,
            curve: Curves.elasticOut,
            onEnd: () {
              if (dismissedEnd.isNegative && currentValue >= dismissedEnd) return;
              if (!dismissedEnd.isNegative && currentValue <= dismissedEnd) return;
              Navigator.popUntil(Global.context, ModalRoute.withName(HomeScreen.routeName)); // pops all messages
            },
            builder: (context, double value, child) {
              currentValue = value;
              autoDisappear();
              return Transform.translate(offset: Offset(0, value), child: child);
            },
            child: Container(
              margin: const EdgeInsets.all(24),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: deleted ? Theme.of(Global.context).colorScheme.error : Theme.of(Global.context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(color: Theme.of(Global.context).colorScheme.onPrimary.withOpacity(0.6)),
                              children: [
                                TextSpan(
                                    text: widget.vocabulary.source.substring(0, 1).toUpperCase() +
                                        widget.vocabulary.source.substring(1, widget.vocabulary.source.length)),
                                TextSpan(text: AppLocalizations.of(context).record_savedMessage),
                                TextSpan(
                                  text: widget.vocabulary.target,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(Global.context).colorScheme.onPrimary),
                                ),
                                const TextSpan(text: "!"),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: deleted
                              ? null
                              : () {
                                  disappear();
                                  delete();
                                  Provider.of<VocabularyProvider>(Global.context, listen: false).remove(widget.vocabulary);
                                },
                          child: Text(
                            deleted ? "" : AppLocalizations.of(context).record_savedMessage_deleteButton,
                            style: TextStyle(color: Theme.of(Global.context).colorScheme.onPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
