import 'dart:math';

import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_use_case.dart';
import 'package:vocabualize/src/features/collections/screens/collection_screen.dart';
import 'package:vocabualize/src/features/collections/utils/collection_arguments.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

class TagCardButton extends StatelessWidget {
  final Tag tag;

  const TagCardButton({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final getVocabularies = sl.get<GetVocabulariesUseCase>();

    void click() {
      Navigator.pushNamed(context, CollectionScreen.routeName, arguments: CollectionScreenArguments(tag: tag));
    }

    return StreamBuilder<List<Vocabulary>>(
      stream: getVocabularies(tag: tag),
      builder: (context, snapshot) {
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
            children: buildContent(context, snapshot.data),
          ),
        );
      },
    );
  }

  List<Widget> buildContent(
    BuildContext context,
    List<Vocabulary>? vocabularies,
  ) {
    if (vocabularies == null) {
      return [
        const CircularProgressIndicator(),
      ];
    }
    return [
      Provider.of<SettingsProvider>(context).areImagesDisabled
          ? Container()
          : SizedBox(
              width: 128,
              height: 128,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: min(vocabularies.length, 2),
                    ),
                    itemCount: min(vocabularies.length, 4),
                    itemBuilder: (context, index) {
                      return Image(
                        image: NetworkImage(
                          vocabularies.elementAt(index).image.url,
                        ),
                      );
                    },
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
            tag.name,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: Provider.of<SettingsProvider>(context).areImagesDisabled ? TextAlign.center : TextAlign.start,
          ),
        ),
      ),
    ];
  }
}
