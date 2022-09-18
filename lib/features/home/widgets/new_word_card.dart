import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class NewWordCard extends StatelessWidget {
  const NewWordCard({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Provider.of<SettingsProvider>(context).areImagesDisabled ? Theme.of(context).colorScheme.surface : null,
      onPressed: () => Messenger.infoDialog(vocabulary),
      padding: Provider.of<SettingsProvider>(context).areImagesDisabled ? const EdgeInsets.all(16.0) : const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// TODO: add image
          Provider.of<SettingsProvider>(context).areImagesDisabled
              ? Container()
              : SizedBox(
                  width: 128,
                  height: 128,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(color: Theme.of(context).colorScheme.surface),
                  ),
                ),
          Provider.of<SettingsProvider>(context).areImagesDisabled ? Container() : const SizedBox(height: 8),
          SizedBox(
            width: 128,
            child: Text(
              vocabulary.target,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: Provider.of<SettingsProvider>(context).areImagesDisabled ? TextAlign.center : TextAlign.start,
            ),
          ),
          SizedBox(
            width: 128,
            child: Text(
              vocabulary.source,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).hintColor),
              textAlign: Provider.of<SettingsProvider>(context).areImagesDisabled ? TextAlign.center : TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
