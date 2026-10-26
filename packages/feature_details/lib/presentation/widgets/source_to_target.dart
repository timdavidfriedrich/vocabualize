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

const _maxLines = 2;

class const SourceToTarget({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<DetailsBloc, DetailsState, ({String source, String target})>(
      selector: (state) => switch (state) {
        DetailsEditing(:final source, :final target) => (source: source, target: target),
        _ => (source: "", target: ""),
      },
      builder: (context, words) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: _SourceButton(source: words.source)),
          const SizedBox(width: Spacing.xs),
          Icon(Icons.keyboard_double_arrow_right_rounded, color: context.c.primary),
          const SizedBox(width: Spacing.xs),
          Flexible(child: _TargetButton(target: words.target)),
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
    return LayoutBuilder(
      builder: (context, constraints) => TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: () => _edit(context),
        child: FittedBox(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: constraints.maxWidth,
            child: Text(
              _source,
              maxLines: _maxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: context.t.bodyLarge,
            ),
          ),
        ),
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
    final canUseAi = switch (bloc.state) {
      DetailsEditing(:final canUseAi) => canUseAi,
      _ => false,
    };
    final retranslates = canUseAi && await confirmsRetranslation(context);
    bloc.add(DetailsSourceChanged(source: source, retranslates: retranslates));
  }
}

class const _TargetButton({
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
    final note = await requestsTranslationReportNote(context);
    if (note != null) bloc.add(DetailsTranslationReported(note: note));
  }
}
