import 'package:core/theme/spacing.dart';
import 'package:feature_welcome/presentation/welcome/welcome_bloc.dart';
import 'package:feature_welcome/presentation/welcome/welcome_event.dart';
import 'package:feature_welcome/presentation/welcome/welcome_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/account_conflict_dialog.dart';
import 'package:shared/presentation/widgets/connection_required_notice.dart';
import 'package:shared/presentation/widgets/google_logo.dart';
import 'package:shared/presentation/widgets/mascot.dart';

class const WelcomeScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<WelcomeBloc, WelcomeState>(
      listener: (context, state) async {
        switch (state) {
          case WelcomeFailure(:final error):
            context.showToast(error.toMessage(context));
          case WelcomeAccountConflict(:final conflict):
            final bloc = context.read<WelcomeBloc>();
            final switchesAccount = await confirmsAccountSwitch(context, conflict);
            bloc.add(WelcomeAccountConflictResolved(keepsPreviousAccount: !switchesAccount));
          case WelcomeIdle() || WelcomeBusy():
            break;
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: context.c.primary,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxl),
              child: BlocBuilder<WelcomeBloc, WelcomeState>(
                builder: (context, state) => _Content(
                  isBusy: switch (state) {
                    WelcomeBusy() || WelcomeAccountConflict() => true,
                    WelcomeIdle() || WelcomeFailure() => false,
                  },
                  isSigningIn: switch (state) {
                    WelcomeBusy(:final isSigningIn) => isSigningIn,
                    WelcomeAccountConflict() => true,
                    WelcomeIdle() || WelcomeFailure() => false,
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class const _Content({
  required final bool _isBusy,
  required final bool _isSigningIn,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: Spacing.xxxl),
        Text(
          context.s.appTitle,
          style: context.t.headlineLarge?.copyWith(color: context.c.onPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacing.s),
        const Expanded(child: Mascot(pose: MascotPose.idle)),
        const SizedBox(height: Spacing.xl),
        ConnectionRequiredNotice(
          message: context.s.welcomeOfflineMessage,
          isCentered: true,
          color: context.c.onPrimary,
        ),
        _GoogleSignInButton(isBusy: _isBusy, isSigningIn: _isSigningIn),
        const SizedBox(height: Spacing.m),
        OutlinedButton(
          onPressed: _isBusy
              ? null
              : () => context.read<WelcomeBloc>().add(const WelcomeLocalUseChosen()),
          child: Text(context.s.welcomeContinueWithoutAccountButton),
        ),
        const SizedBox(height: Spacing.xxl),
      ],
    );
  }
}

class const _GoogleSignInButton({
  required final bool _isBusy,
  required final bool _isSigningIn,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, bool>(
      builder: (context, isConnected) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.c.secondary,
          foregroundColor: context.c.onSecondary,
          padding: const EdgeInsets.all(Spacing.m),
        ),
        onPressed: _isBusy || !isConnected
            ? null
            : () => context.read<WelcomeBloc>().add(const WelcomeGoogleSignInChosen()),
        child: Row(
          children: [
            const GoogleLogo(),
            const SizedBox(width: Spacing.m),
            Expanded(child: Text(context.s.welcomeGoogleSignInButton)),
            if (_isSigningIn)
              const SizedBox.square(
                dimension: Spacing.iconM,
                child: CircularProgressIndicator(strokeWidth: Spacing.borderWidthThick),
              ),
          ],
        ),
      ),
    );
  }
}
