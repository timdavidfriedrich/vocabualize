import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/widgets/edit_language_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';

const _maxLines = 2;

class const SourceToTarget({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) => switch (state) {
        final DetailsEditing editing => Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: _TextButton(
                  editing: editing,
                  language: editing.setup.main,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const SizedBox(width: Spacing.xs),
            Icon(Icons.keyboard_double_arrow_right_rounded, color: context.c.primary),
            const SizedBox(width: Spacing.xs),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: _TextButton(
                  editing: editing,
                  language: editing.setup.selected,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class const MainTextButton({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) => switch (state) {
        final DetailsEditing editing => Align(
          alignment: Alignment.centerLeft,
          child: _TextButton(
            editing: editing,
            language: editing.setup.main,
            textAlign: TextAlign.left,
          ),
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class const _TextButton({
  required final DetailsEditing _editing,
  required final Language _language,
  required final TextAlign _textAlign,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = _editing.textOf(_language);
    if (text.isEmpty && _editing.translatingLanguages.contains(_language)) {
      return const ButtonProgress();
    }
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () => editLanguageText(context, _editing, _language),
      child: Text(
        text.isEmpty ? _language.toLabel(context) : text,
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: _textAlign,
        style: text.isEmpty
            ? context.t.bodyLarge?.copyWith(color: context.c.outline)
            : context.t.bodyLarge,
      ),
    );
  }
}
