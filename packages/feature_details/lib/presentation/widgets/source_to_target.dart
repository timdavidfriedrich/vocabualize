import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/widgets/edit_text_dialog.dart';
import 'package:feature_details/presentation/widgets/replace_dialog.dart';
import 'package:feature_details/presentation/widgets/report_translation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';

const _maxLines = 2;

class const SourceToTarget({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DetailsBloc,
      DetailsState,
      ({String source, String target, bool isTranslating})
    >(
      selector: (state) => switch (state) {
        DetailsEditing(:final source, :final target, :final runningAction) => (
          source: source,
          target: target,
          isTranslating: runningAction == DetailsAction.lookup,
        ),
        _ => (source: "", target: "", isTranslating: false),
      },
      builder: (context, words) => Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _SourceButton(source: words.source),
            ),
          ),
          const SizedBox(width: Spacing.xs),
          Icon(Icons.keyboard_double_arrow_right_rounded, color: context.c.primary),
          const SizedBox(width: Spacing.xs),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: words.isTranslating && words.target.isEmpty
                  ? const ButtonProgress()
                  : _TargetButton(source: words.source, target: words.target),
            ),
          ),
        ],
      ),
    );
  }
}

class const _SourceButton({
  required final String _source,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () => _edit(context),
      child: Text(
        _source,
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.right,
        style: context.t.bodyLarge,
      ),
    );
  }

  Future<void> _edit(BuildContext context) async {
    final bloc = context.read<DetailsBloc>();
    final source = await requestsEditedText(
      context,
      text: _source,
      label: context.s.detailsSourceLabel,
    );
    if (source == null || !context.mounted) return;
    final retranslates = await confirmsRetranslation(context);
    bloc.add(DetailsSourceChanged(source: source, retranslates: retranslates));
  }
}

class const _TargetButton({
  required final String _source,
  required final String _target,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () => _edit(context),
      child: Text(
        _target.isEmpty ? context.s.detailsTargetLabel : _target,
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: _target.isEmpty
            ? context.t.bodyLarge?.copyWith(color: context.c.outline)
            : context.t.bodyLarge,
      ),
    );
  }

  Future<void> _edit(BuildContext context) async {
    final bloc = context.read<DetailsBloc>();
    final target = await requestsEditedText(
      context,
      text: _target,
      label: context.s.detailsTargetLabel,
      onReportRequested: _target.isEmpty ? null : () => _report(context),
    );
    if (target != null) bloc.add(DetailsTargetChanged(target: target));
  }

  Future<void> _report(BuildContext context) async {
    final bloc = context.read<DetailsBloc>();
    final note = await requestsTranslationReportNote(context, source: _source, target: _target);
    if (note != null) bloc.add(DetailsTranslationReported(note: note));
  }
}
