import 'dart:async';

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';

const _translatingHintDelay = Duration(seconds: 1);

class const UntranslatedHint({
  super.key,
  required final List<Language> _languages,
  required final bool _isTranslating,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isDelayOver = useState(false);
    useEffect(() {
      if (!_isTranslating) return null;
      final timer = Timer(_translatingHintDelay, () => isDelayOver.value = true);
      return timer.cancel;
    }, [_isTranslating]);
    if (_isTranslating && !isDelayOver.value) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.s),
      child: Row(
        children: [
          if (_isTranslating)
            const ButtonProgress()
          else
            Icon(Icons.schedule_rounded, size: Spacing.iconS, color: context.c.onSurfaceVariant),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Text(
              context.s.detailsUntranslatedHint(
                _languages.length,
                _languages.first.toLabel(context),
              ),
              style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
