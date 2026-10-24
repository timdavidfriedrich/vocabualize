import 'package:core/theme/spacing.dart';
import 'package:feature_welcome/presentation/welcome/welcome_bloc.dart';
import 'package:feature_welcome/presentation/welcome/welcome_event.dart';
import 'package:feature_welcome/presentation/welcome/welcome_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/mascot.dart';

class const WelcomeScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<WelcomeBloc, WelcomeState>(
      listener: (context, state) {
        if (state case WelcomeFailure(:final error)) context.showToast(error.toMessage(context));
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.xl),
            child: BlocBuilder<WelcomeBloc, WelcomeState>(
              builder: (context, state) => _Content(isBusy: state is WelcomeBusy),
            ),
          ),
        ),
      ),
    );
  }
}

class const _Content({
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WelcomeBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: Spacing.xl),
        Text(context.s.appTitle, style: context.t.headlineLarge, textAlign: TextAlign.center),
        const SizedBox(height: Spacing.xl),
        const Expanded(child: Mascot(pose: MascotPose.waving)),
        const SizedBox(height: Spacing.xl),
        if (_isBusy) ...[
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: Spacing.xl),
        ],
        FilledButton(
          onPressed: _isBusy ? null : () => bloc.add(const WelcomeGoogleSignInChosen()),
          child: Text(context.s.welcomeGoogleSignInButton),
        ),
        const SizedBox(height: Spacing.s),
        OutlinedButton(
          onPressed: _isBusy ? null : () => bloc.add(const WelcomeLocalUseChosen()),
          child: Text(context.s.welcomeContinueWithoutAccountButton),
        ),
      ],
    );
  }
}
