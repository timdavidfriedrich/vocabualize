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
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/widgets/button_progress.dart';
import 'package:shared/presentation/widgets/delete_vocabulary_dialog.dart';
import 'package:shared/presentation/widgets/icon_action_button.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';

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
          listenWhen: (previous, current) => switch ((previous, current)) {
            (DetailsEditing(notice: null), DetailsEditing(notice: DetailsNotice())) => true,
            _ => false,
          },
          listener: (context, state) {
            if (state case DetailsEditing(notice: DetailsNotice.translationReported)) {
              context.showToast(context.s.reportTranslationSentMessage);
            }
          },
        ),
        BlocListener<DetailsBloc, DetailsState>(
          listenWhen: (previous, current) => current is DetailsAdded,
          listener: (context, state) => context.closeToHome(),
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
          DetailsLoading() ||
          DetailsDuplicateFound() ||
          DetailsAdded() ||
          DetailsClosed() => const LoadingScreen(),
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
        title: const SourceToTarget(),
        actions: const [SizedBox(width: kToolbarHeight)],
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
                    _ImageSection(),
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
        DetailsEditing(:final original, :final source, :final target, :final runningAction) => Row(
          children: [
            if (original != null) ...[
              _DeleteButton(original: original, runningAction: runningAction),
              const SizedBox(width: Spacing.s),
            ],
            Expanded(
              child: ElevatedButton(
                onPressed: runningAction != null || source.isEmpty || target.isEmpty
                    ? null
                    : () => context.read<DetailsBloc>().add(const DetailsSaveRequested()),
                child: runningAction == DetailsAction.save
                    ? const ButtonProgress()
                    : Text(switch (state.selectedImage) {
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
  required final DetailsAction? _runningAction,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconActionButton(
      icon: _runningAction == DetailsAction.delete
          ? const ButtonProgress()
          : const Icon(Icons.delete_rounded),
      tooltip: context.s.delete,
      isDestructive: true,
      onPressed: _runningAction != null ? null : () => _delete(context),
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

class const _ImageSection() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<PreferencesCubit, Preferences, bool>(
      selector: (preferences) => preferences.areImagesHidden,
      builder: (context, areImagesHidden) => switch (areImagesHidden) {
        true => const SizedBox.shrink(),
        false => const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageChooser(),
            SizedBox(height: Spacing.m),
          ],
        ),
      },
    );
  }
}
