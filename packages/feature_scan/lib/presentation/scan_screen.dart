import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_scan/presentation/scan_bloc.dart';
import 'package:feature_scan/presentation/scan_event.dart';
import 'package:feature_scan/presentation/scan_state.dart';
import 'package:feature_scan/presentation/widgets/scan_camera_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/connection_required_notice.dart';

class const ScanScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanBloc, ScanState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (ScanCapturing(error: final previousError), ScanCapturing(error: AppError())) =>
          previousError == null,
        (_, ScanCapturing(error: AppError())) => true,
        _ => false,
      },
      listener: (context, state) {
        if (state case ScanCapturing(error: final error?)) {
          context.showToast(error.toMessage(context));
        }
      },
      child: BlocBuilder<ScanBloc, ScanState>(
        builder: (context, state) => PopScope(
          canPop: state is! ScanReviewing,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) context.read<ScanBloc>().add(const ScanRetakeRequested());
          },
          child: Scaffold(
            appBar: AppBar(),
            body: switch (state) {
              ScanCapturing(:final isProcessing) => ScanCameraView(isProcessing: isProcessing),
              ScanReviewing(:final photo, :final suggestions) => _ReviewView(
                photo: photo,
                suggestions: suggestions,
              ),
            },
          ),
        ),
      ),
    );
  }
}

class const _ReviewView({
  required final ProcessedImage _photo,
  required final ScanSuggestions _suggestions,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(Spacing.xxl, 0, Spacing.xxl, Spacing.xxl),
      children: [
        const SizedBox(height: Spacing.m),
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
            child: Image.memory(_photo.fullBytes, fit: BoxFit.cover, gaplessPlayback: true),
          ),
        ),
        const SizedBox(height: Spacing.xxl),
        TextField(
          decoration: InputDecoration(hintText: context.s.scanTypeHint),
          onSubmitted: (word) => _openDetails(context, word: word, photo: _photo),
        ),
        const SizedBox(height: Spacing.xl),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(context.s.scanSuggestionsTitle),
        ),
        const SizedBox(height: Spacing.s),
        switch (_suggestions) {
          ScanSuggestionsLoading() => LinearProgressIndicator(
            borderRadius: BorderRadius.circular(Spacing.radiusS),
          ),
          ScanSuggestionsLoaded(:final labels) when labels.isEmpty => _SuggestionsHint(
            message: context.s.scanNoSuggestionsMessage,
          ),
          ScanSuggestionsLoaded(:final labels) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final label in labels)
                Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.xs),
                  child: ListTile(
                    title: Text(label),
                    tileColor: context.c.surfaceContainerLow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Spacing.radiusL),
                    ),
                    onTap: () => _openDetails(context, word: label, photo: _photo),
                  ),
                ),
              TextButton.icon(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: context.pushFeedback,
                icon: const Icon(Icons.flag_rounded),
                label: Text(context.s.scanReportSuggestionButton),
              ),
            ],
          ),
          ScanSuggestionsOffline() => ConnectionRequiredNotice(
            message: context.s.scanOfflineMessage,
          ),
          ScanSuggestionsFailed(:final error) => _SuggestionsHint(
            message: error.toMessage(context),
          ),
        },
      ],
    );
  }
}

class const _SuggestionsHint({
  required final String _message,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(_message, style: context.t.bodySmall);
  }
}

void _openDetails(BuildContext context, {required String word, required ProcessedImage photo}) {
  final source = word.trim();
  if (source.isNotEmpty) unawaited(context.pushNewVocabularyDetails(source: source, photo: photo));
}
