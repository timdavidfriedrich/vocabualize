import 'package:flutter/material.dart';
import 'package:teleport/teleport.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/edit/screens/edit.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class InfoDialog extends StatefulWidget {
  const InfoDialog({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

  @override
  State<InfoDialog> createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  bool popped = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Provider.of<SettingsProvider>(context).areImagesDisabled
              ? Container()
              : SizedBox(
                  width: double.infinity,
                  height: 128,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(color: Theme.of(context).colorScheme.surface),
                  ),
                ),
          Provider.of<SettingsProvider>(context).areImagesDisabled ? Container() : const SizedBox(height: 16),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(widget.vocabulary.target, style: Theme.of(context).textTheme.headlineSmall),
            subtitle: Text(widget.vocabulary.source, style: TextStyle(color: Theme.of(context).hintColor)),
            trailing: IconButton(
              onPressed: () {
                Navigator.push(context, Teleport(child: Edit(vocabulary: widget.vocabulary), type: "scale_center"));
                //if (!popped) setState(() => popped = true);
              },
              icon: Icon(Icons.edit_rounded, color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ],
      ),
      content: RichText(
        text: TextSpan(
          children: [
            const TextSpan(text: "Tags:\n"),
            TextSpan(text: widget.vocabulary.tags.isEmpty ? "No tags added.\n\n" : "${widget.vocabulary.tags}\n\n"),
            const TextSpan(text: "Creation date:\n"),
            TextSpan(text: "${widget.vocabulary.creationDate.toString()}\n\n"),
            const TextSpan(text: "Next date:\n"),
            TextSpan(text: "${widget.vocabulary.nextDate.toString()} "),
          ],
        ),
      ),
      actions: [
        // TODO: Save TextField and Chip data on clicked, pop()
        ElevatedButton(
          onPressed: () {
            if (!popped) {
              Navigator.pop(context);
              setState(() => popped = true);
            }
          },
          child: const Text("Okay"),
        ),
      ],
    );
  }
}
