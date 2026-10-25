import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/practice_bloc.dart';
import 'package:feature_practice/presentation/practice_state.dart';
import 'package:feature_practice/presentation/widgets/practice_card.dart';
import 'package:feature_practice/presentation/widgets/practice_controls.dart';
import 'package:feature_practice/presentation/widgets/practice_done_view.dart';
import 'package:feature_practice/presentation/widgets/practice_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';

class const PracticeScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PracticeBloc, PracticeState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (PracticeActive(error: null), PracticeActive(error: AppError())) => true,
        _ => false,
      },
      listener: (context, state) {
        if (state case PracticeActive(error: final error?)) {
          context.showToast(error.toMessage(context));
        }
      },
      child: BlocBuilder<PracticeBloc, PracticeState>(
        buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
        builder: (context, state) => switch (state) {
          PracticeLoading() => const LoadingScreen(),
          PracticeFailure(:final error) => _FailureScreen(error: error),
          PracticeDone() => const PracticeDoneView(),
          PracticeActive() => const _ActiveScreen(),
        },
      ),
    );
  }
}

class const _ActiveScreen() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xxxl),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: Spacing.xxl),
                    PracticeProgressBar(),
                    SizedBox(height: Spacing.m),
                    PracticeCard(),
                    SizedBox(height: Spacing.m),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: PracticeControls(),
              ),
            ],
          ),
        ),
      ),
    );
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
