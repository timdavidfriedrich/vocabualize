import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/entities/level.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/use_cases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/common/presentation/extensions/vocabulary_image_extensions.dart';
import 'package:vocabualize/src/features/details/presentation/screens/details_screen.dart';
import 'package:vocabualize/src/features/home/presentation/controllers/home_controller.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/info_dialog.dart';

class VocabularyListTile extends ConsumerWidget {
  final bool areImagesEnabled;
  final Vocabulary vocabulary;

  const VocabularyListTile({
    required this.areImagesEnabled,
    required this.vocabulary,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showVocabularyInfo() {
      context.showDialog(InfoDialog(vocabulary: vocabulary));
    }

    void editVocabualary() {
      context.pushNamed(
        DetailsScreen.routeName,
        arguments: DetailsScreenArguments(vocabulary: vocabulary),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.mediumBorderRadius),
      child: _EditDeleteDismissble(
        vocabulary: vocabulary,
        onEdit: editVocabualary,
        child: ListTile(
          onTap: showVocabularyInfo,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Dimensions.smallSpacing,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.mediumBorderRadius),
          ),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LevelIndicator(level: vocabulary.level),
              if (areImagesEnabled) ...[
                const SizedBox(width: Dimensions.semiSmallSpacing),
                _AvatarBox(image: vocabulary.image),
              ]
            ],
          ),
          title: Text(vocabulary.target),
          subtitle: Text(
            vocabulary.source,
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          trailing: _ReadOutButton(vocabulary: vocabulary),
        ),
      ),
    );
  }
}

class _EditDeleteDismissble extends ConsumerWidget {
  final Vocabulary vocabulary;
  final void Function() onEdit;
  final Widget child;
  const _EditDeleteDismissble({
    required this.vocabulary,
    required this.onEdit,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(vocabulary.toString()),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onEdit();
          return false;
        } else {
          return true;
        }
      },
      onDismissed: (direction) async {
        return await ref.read(deleteVocabularyUseCaseProvider(vocabulary));
      },
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.mediumSpacing,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Icon(
          Icons.edit_rounded,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.mediumSpacing,
        ),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.error),
        child: Icon(
          Icons.delete_rounded,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      child: child,
    );
  }
}

class _LevelIndicator extends StatelessWidget {
  final Level level;
  const _LevelIndicator({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.smallSpacing,
      ),
      color: level.color,
      width: Dimensions.extraSmallSpacing,
    );
  }
}

class _AvatarBox extends StatelessWidget {
  final VocabularyImage image;
  const _AvatarBox({required this.image});

  @override
  Widget build(BuildContext context) {
    const avatarSize = 48.0;
    return SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          Dimensions.mediumBorderRadius,
        ),
        child: Image(
          image: image.getImageProvider(
            size: ImageSize.tiny,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ReadOutButton extends ConsumerWidget {
  final Vocabulary vocabulary;
  const _ReadOutButton({required this.vocabulary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        ref.read(homeControllerProvider.notifier).readOut(vocabulary);
      },
      icon: const Icon(Icons.volume_up),
    );
  }
}
