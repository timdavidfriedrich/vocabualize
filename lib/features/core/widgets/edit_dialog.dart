import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/core/widgets/tag_wrap.dart';
import 'package:vocabualize/features/home/screens/home.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  TextEditingController sourceController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  String sourceText = "";
  String targetText = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      sourceText = widget.vocabulary.source;
      targetText = widget.vocabulary.target;
    });
    sourceController.text = widget.vocabulary.source;
    targetController.text = widget.vocabulary.target;
  }

  @override
  void dispose() {
    super.dispose();
    sourceController.dispose();
    targetController.dispose();
  }

  _save() {
    if (sourceText.isNotEmpty) widget.vocabulary.source = sourceText;
    if (targetText.isNotEmpty) widget.vocabulary.target = targetText;
    Navigator.popUntil(context, ModalRoute.withName(Home.routeName));
  }

  _delete() {
    Provider.of<VocabularyProvider>(context, listen: false).remove(widget.vocabulary);
    Navigator.popUntil(context, ModalRoute.withName(Home.routeName));
  }

  String reappearsIn() {
    DateTime now = DateTime.now();
    Duration difference = widget.vocabulary.nextDate.difference(now);
    if (difference.isNegative) return "Now";
    if (difference.inMinutes < 1) return "In less than a minutes";
    if (difference.inHours < 1) return "In ${difference.inMinutes} minutes";
    if (difference.inDays < 1) return "In ${difference.inHours} hours";
    if (difference.inDays <= 7) return "In ${difference.inDays} days";
    return DateFormat("dd.MM.yyyy - HH:mm").format(widget.vocabulary.nextDate);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(32),
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      actionsPadding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      actionsAlignment: MainAxisAlignment.end,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Provider.of<SettingsProvider>(context).areImagesDisabled
                  ? Container()
                  : AspectRatio(
                      aspectRatio: 4 / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: widget.vocabulary.imageProvider,
                            ),
                          ),
                        ),
                      ),
                    ),
              Provider.of<SettingsProvider>(context).areImagesDisabled ? Container() : const SizedBox(height: 16),
              TextField(
                controller: sourceController,
                onChanged: (value) => setState(() => sourceText = value),
                toolbarOptions: const ToolbarOptions(copy: false, cut: false, paste: false, selectAll: false),
                decoration: InputDecoration(
                  hintText: widget.vocabulary.source,
                  label: const Text("Source"),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: targetController,
                onChanged: (value) => setState(() => targetText = value),
                toolbarOptions: const ToolbarOptions(copy: false, cut: false, paste: false, selectAll: false),
                decoration: InputDecoration(
                  hintText: widget.vocabulary.target,
                  label: const Text("Translation"),
                ),
              ),
              const SizedBox(height: 16),
              TagWrap(vocabulary: widget.vocabulary),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "Created: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "${DateFormat("dd.MM.yyyy").format(widget.vocabulary.creationDate)}\n"),
                    const TextSpan(text: "Reappears: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: reappearsIn()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.2),
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          onPressed: () => _delete(),
          child: const Icon(Icons.delete_rounded),
        ),
        ElevatedButton(onPressed: () => _save(), child: const Text("Save")),
      ],
    );
  }
}
