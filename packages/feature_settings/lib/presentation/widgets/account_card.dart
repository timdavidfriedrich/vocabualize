import 'package:core/theme/spacing.dart';
import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_state.dart';
import 'package:feature_settings/presentation/widgets/connect_button.dart';
import 'package:feature_settings/presentation/widgets/settings_card.dart';
import 'package:feature_settings/presentation/widgets/status_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/sync_status_extensions.dart';
import 'package:shared/presentation/sync_status/sync_status_cubit.dart';
import 'package:shared/presentation/widgets/account_status_avatar.dart';
import 'package:shared/presentation/widgets/button_progress.dart';
import 'package:shared/presentation/widgets/google_logo.dart';

class const AccountCard({
  super.key,
  required final String? _name,
  required final String? _email,
  required final String? _picturePath,
  required final SettingsAction? _runningAction,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _Avatar(picturePath: _picturePath),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name ?? _email ?? context.s.unknown,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                    if (_name != null && _email != null)
                      Text(
                        _email,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: context.t.bodySmall,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.xs),
              if (_runningAction == SettingsAction.signOut)
                const ButtonProgress()
              else
                IconButton(
                  tooltip: context.s.settingsSignOutButton,
                  icon: const Icon(Icons.logout_rounded),
                  onPressed: _runningAction != null
                      ? null
                      : () => context.read<SettingsBloc>().add(
                          const SettingsSignOutRequested(discardUnsyncedChanges: false),
                        ),
                ),
            ],
          ),
          BlocBuilder<SyncStatusCubit, SyncStatus>(
            builder: (context, status) => switch (status.toLabel(context)) {
              final message? when status.needsAttention => StatusNotice(
                message: message,
                action: switch (status) {
                  SyncStatus.offline => const ConnectButton(),
                  SyncStatus.signInRequired => _SignInAgainButton(runningAction: _runningAction),
                  SyncStatus.updateRequired => const _UpdateButton(),
                  SyncStatus.disabled ||
                  SyncStatus.connecting ||
                  SyncStatus.syncing ||
                  SyncStatus.synced ||
                  SyncStatus.serverUnreachable ||
                  SyncStatus.clockWrong ||
                  SyncStatus.failed => null,
                },
              ),
              _ => const SizedBox.shrink(),
            },
          ),
        ],
      ),
    );
  }
}

class const _Avatar({
  required final String? _picturePath,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AccountStatusAvatar(
      picturePath: _picturePath,
      radius: Spacing.l,
      providerBadge: CircleAvatar(
        radius: Spacing.xs,
        backgroundColor: context.accountProviders.google,
        child: const GoogleLogo(size: Spacing.s),
      ),
    );
  }
}

class const _SignInAgainButton({
  required final SettingsAction? _runningAction,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, bool>(
      builder: (context, isConnected) => TextButton(
        onPressed: _runningAction != null || !isConnected
            ? null
            : () => context.read<SettingsBloc>().add(const SettingsGoogleSignInRequested()),
        child: _runningAction == SettingsAction.signIn
            ? const ButtonProgress()
            : Text(context.s.settingsSignInAgainButton),
      ),
    );
  }
}

class const _UpdateButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<SettingsBloc>().add(const SettingsStoreListingOpened()),
      child: Text(context.s.gateUpdateButton),
    );
  }
}
