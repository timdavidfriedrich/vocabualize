import 'dart:math';

import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/collections/screens/collection_screen.dart';
import 'package:vocabualize/features/collections/services/collection_arguments.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class TagCardButton extends StatelessWidget {
  final String tag;

  const TagCardButton({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    void click() {
      Navigator.pushNamed(context, CollectionScreen.routeName, arguments: CollectionScreenArguments(tag: tag));
    }

    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.surface,
      onPressed: () => click(),
      padding: Provider.of<SettingsProvider>(context).areImagesDisabled ? const EdgeInsets.all(16.0) : const EdgeInsets.all(8.0),
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Provider.of<SettingsProvider>(context).areImagesDisabled
              ? Container()
              : SizedBox(
                  width: 128,
                  height: 128,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background.withOpacity(0.5),
                      ),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: min(Provider.of<VocabularyProvider>(context).getVocabulariesByTag(tag).length, 2),
                        ),
                        itemCount: min(Provider.of<VocabularyProvider>(context).getVocabulariesByTag(tag).length, 4),
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  Provider.of<VocabularyProvider>(context).getVocabulariesByTag(tag).reversed.toList()[index].imageProvider,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          Provider.of<SettingsProvider>(context).areImagesDisabled ? Container() : const SizedBox(height: 8),
          SizedBox(
            width: 128,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                tag,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: Provider.of<SettingsProvider>(context).areImagesDisabled ? TextAlign.center : TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
