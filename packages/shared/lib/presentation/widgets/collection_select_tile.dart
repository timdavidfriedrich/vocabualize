import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/selection_indicators.dart';
import 'package:shared/presentation/widgets/vocabulary_image_view.dart';

const _thumbnailSize = Spacing.xxxl;

class const CollectionSelectGroup({
  super.key,
  required final List<Widget> _children,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: Spacing.borderWidthMedium,
          children: _children,
        ),
      ),
    );
  }
}

class const CollectionSelectTile({
  super.key,
  required final String _title,
  required final VocabularyImage? _image,
  final IconData _placeholderIcon = Icons.folder_outlined,
  required final String? _subtitle,
  final bool _isWarning = false,
  required final bool? _isChecked,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.surfaceContainerLowest,
      child: InkWell(
        onTap: _onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
          child: Row(
            children: [
              SizedBox.square(
                dimension: _thumbnailSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Spacing.radiusM),
                  child: switch (_image) {
                    final image? => VocabularyImageView(
                      image: image,
                      variant: VocabularyImageVariant.thumbnail,
                      displayWidth: _thumbnailSize,
                    ),
                    null => ColoredBox(
                      color: context.c.surfaceContainerHigh,
                      child: Icon(_placeholderIcon, color: context.c.onSurfaceVariant),
                    ),
                  },
                ),
              ),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _title,
                      style: context.t.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (_subtitle case final subtitle?)
                      Text(
                        subtitle,
                        style: context.t.bodyMedium?.copyWith(
                          color: _isWarning ? context.c.error : context.c.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.s),
              CheckIndicator(isChecked: _isChecked),
            ],
          ),
        ),
      ),
    );
  }
}
