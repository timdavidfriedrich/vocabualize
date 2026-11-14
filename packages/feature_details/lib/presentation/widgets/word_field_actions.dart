import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const WordFieldActions({
  super.key,
  required final bool _canReport,
  required final VoidCallback _onReport,
  required final VoidCallback _onSpeak,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Spacing.xs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_canReport)
            IconButton(
              style: IconButton.styleFrom(foregroundColor: context.c.onSurfaceVariant),
              onPressed: _onReport,
              tooltip: context.s.detailsReportTranslationButton,
              icon: const Icon(Icons.flag_outlined),
            ),
          IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: context.c.surface,
              foregroundColor: context.c.primary,
              shape: const CircleBorder(),
            ),
            onPressed: _onSpeak,
            tooltip: context.s.vocabularySpeakTooltip,
            icon: const Icon(Icons.volume_up_rounded),
          ),
        ],
      ),
    );
  }
}
