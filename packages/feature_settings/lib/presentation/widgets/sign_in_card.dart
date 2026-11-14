import 'package:core/theme/spacing.dart';
import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_state.dart';
import 'package:feature_settings/presentation/widgets/connect_button.dart';
import 'package:feature_settings/presentation/widgets/settings_card.dart';
import 'package:feature_settings/presentation/widgets/status_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';

class const SignInCard({
  super.key,
  required final SettingsAction? _runningAction,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.s.settingsSignInHint, style: context.t.bodyLarge),
          BlocBuilder<ConnectivityCubit, bool>(
            builder: (context, isConnected) => switch (isConnected) {
              true => const SizedBox.shrink(),
              false => StatusNotice(
                message: context.s.settingsSignInOfflineMessage,
                action: const ConnectButton(),
              ),
            },
          ),
          const SizedBox(height: Spacing.s),
          Align(
            alignment: Alignment.centerRight,
            child: BlocBuilder<ConnectivityCubit, bool>(
              builder: (context, isConnected) => ElevatedButton(
                onPressed: _runningAction != null || !isConnected
                    ? null
                    : () => context.read<SettingsBloc>().add(const SettingsGoogleSignInRequested()),
                child: _runningAction == SettingsAction.signIn
                    ? const ButtonProgress()
                    : Text(context.s.settingsSignInButton),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
