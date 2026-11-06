import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _pillOpacity = 0.6;

class const PhotoPillButton({
  super.key,
  required final String _label,
  required final VoidCallback? _onPressed,
  final IconData? _leadingIcon,
  final IconData? _trailingIcon,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = context.overlay.onScrim;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.s),
        child: Material(
          color: context.overlay.scrim.withValues(alpha: _pillOpacity),
          shape: const StadiumBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: _onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_leadingIcon case final icon?) ...[
                    Icon(icon, color: color),
                    const SizedBox(width: Spacing.xs),
                  ],
                  Flexible(
                    child: Text(
                      _label,
                      overflow: TextOverflow.ellipsis,
                      style: context.t.bodySmall?.copyWith(color: color),
                    ),
                  ),
                  if (_trailingIcon case final icon?) ...[
                    const SizedBox(width: Spacing.xs),
                    Icon(icon, color: color),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class const PhotoCreditButton({
  super.key,
  required final String? _photographer,
  required final VoidCallback _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PhotoPillButton(
      label: switch (_photographer) {
        final photographer? => context.s.vocabularyPhotoByLabel(photographer),
        null => context.s.vocabularyPhotoOnPexelsLabel,
      },
      trailingIcon: Icons.open_in_new_rounded,
      onPressed: _onPressed,
    );
  }
}
