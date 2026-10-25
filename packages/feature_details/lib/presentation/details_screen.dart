import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/widgets/duplicate_dialog.dart';
import 'package:feature_details/presentation/widgets/image_chooser.dart';
import 'package:feature_details/presentation/widgets/source_to_target.dart';
import 'package:feature_details/presentation/widgets/tag_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/delete_vocabulary_dialog.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';

const _deleteBackgroundOpacity = 0.2;

class const DetailsScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DetailsBloc, DetailsState>(
          listenWhen: (previous, current) => current is DetailsClosed,
          listener: (context, state) => context.closeScreen(),
        ),
        BlocListener<DetailsBloc, DetailsState>(
          listenWhen: (previous, current) => current is DetailsDuplicateFound,
          listener: (context, state) async {
            if (state case DetailsDuplicateFound(:final source)) {
              final bloc = context.read<DetailsBloc>();
              final addsAnyway = await confirmsAddingDuplicate(context, source);
              bloc.add(DetailsDuplicateResolved(addsAnyway: addsAnyway));
            }
          },
        ),
        BlocListener<DetailsBloc, DetailsState>(
          listenWhen: (previous, current) => switch ((previous, current)) {
            (DetailsEditing(error: final previousError), DetailsEditing(error: AppError())) =>
              previousError == null,
            (_, DetailsEditing(error: AppError())) => true,
            _ => false,
          },
          listener: (context, state) {
            if (state case DetailsEditing(error: final error?)) {
              context.showToast(error.toMessage(context));
            }
          },
        ),
      ],
      child: BlocBuilder<DetailsBloc, DetailsState>(
        buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
        builder: (context, state) => switch (state) {
          DetailsLoading() || DetailsDuplicateFound() || DetailsClosed() => const LoadingScreen(),
          DetailsFailure(:final error) => _FailureScreen(error: error),
          DetailsEditing() => const _EditingScreen(),
        },
      ),
    );
  }
}

class const _EditingScreen() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Row(
          children: [
            Expanded(child: SourceToTarget()),
            SizedBox(width: Spacing.xxxl),
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.xxxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: Spacing.xs),
                    ImageChooser(),
                    SizedBox(height: Spacing.m),
                    TagWrap(),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.m),
            _Actions(),
            SizedBox(height: Spacing.xxl),
          ],
        ),
      ),
    );
  }
}

class const _Actions() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) => switch (state) {
        DetailsEditing(:final original, :final source, :final target, :final isBusy) => Row(
          children: [
            if (original != null) ...[
              _DeleteButton(original: original, isBusy: isBusy),
              const SizedBox(width: Spacing.s),
            ],
            Expanded(
              child: ElevatedButton(
                onPressed: isBusy || source.isEmpty || target.isEmpty
                    ? null
                    : () => context.read<DetailsBloc>().add(const DetailsSaveRequested()),
                child: Text(switch (state.selectedImage) {
                  DetailsNoImage() => context.s.detailsSaveWithoutImageButton,
                  DetailsNewPhoto() ||
                  DetailsStockPhoto() ||
                  DetailsSavedImage() => context.s.detailsSaveButton,
                }),
              ),
            ),
          ],
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class const _DeleteButton({
  required final Vocabulary _original,
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(Spacing.s),
        backgroundColor: context.c.error.withValues(alpha: _deleteBackgroundOpacity),
        foregroundColor: context.c.error,
      ),
      onPressed: _isBusy ? null : () => _delete(context),
      child: const Icon(Icons.delete_rounded),
    );
  }

  Future<void> _delete(BuildContext context) async {
    final bloc = context.read<DetailsBloc>();
    if (await confirmsVocabularyDelete(context, _original)) {
      bloc.add(const DetailsDeleteRequested());
    }
  }
}

class const _FailureScreen({
  required final AppError _error,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xl),
          child: Text(_error.toMessage(context), textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
