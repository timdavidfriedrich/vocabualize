import 'package:core/theme/spacing.dart';
import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const SettingsScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsBloc, SettingsState>(
          listenWhen: (previous, current) => switch ((previous, current)) {
            (SettingsLoaded(error: null), SettingsLoaded(error: _?)) => true,
            _ => false,
          },
          listener: (context, state) {
            if (state case SettingsLoaded(error: final error?)) {
              context.showToast(error.toMessage(context));
            }
          },
        ),
        BlocListener<SettingsBloc, SettingsState>(
          listenWhen: (previous, current) => switch ((previous, current)) {
            (SettingsLoaded(isSignOutBlocked: false), SettingsLoaded(isSignOutBlocked: true)) =>
              true,
            _ => false,
          },
          listener: (context, state) => _showSignOutBlockedDialog(context),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(context.s.settingsTitle)),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) => switch (state) {
            SettingsLoading() => const Center(child: CircularProgressIndicator()),
            SettingsLoaded(:final account, :final isBusy) => ListView(
              padding: const EdgeInsets.all(Spacing.m),
              children: [
                Text(context.s.settingsAccountTitle, style: context.t.titleMedium),
                const SizedBox(height: Spacing.xs),
                switch (account) {
                  LocalAccount() => _LocalAccountSection(isBusy: isBusy),
                  GoogleAccount(:final name, :final email) => _GoogleAccountSection(
                    name: name,
                    email: email,
                    isBusy: isBusy,
                  ),
                },
              ],
            ),
          },
        ),
      ),
    );
  }

  Future<void> _showSignOutBlockedDialog(BuildContext context) async {
    final bloc = context.read<SettingsBloc>();
    final signOutAnyway = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => const _SignOutBlockedDialog(),
    );
    bloc.add(
      signOutAnyway == true
          ? const SettingsSignOutRequested(discardUnsyncedChanges: true)
          : const SettingsSignOutDismissed(),
    );
  }
}

class const _LocalAccountSection({
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(context.s.settingsSignInHint, style: context.t.bodyMedium),
        const SizedBox(height: Spacing.s),
        FilledButton(
          onPressed: _isBusy
              ? null
              : () => context.read<SettingsBloc>().add(const SettingsGoogleSignInRequested()),
          child: _isBusy ? const _ButtonProgress() : Text(context.s.settingsSignInButton),
        ),
      ],
    );
  }
}

class const _GoogleAccountSection({
  required final String? _name,
  required final String? _email,
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.account_circle_rounded),
          title: Text(_name ?? _email ?? context.s.unknown),
          subtitle: _name == null || _email == null ? null : Text(_email),
        ),
        const SizedBox(height: Spacing.s),
        OutlinedButton(
          onPressed: _isBusy
              ? null
              : () => context.read<SettingsBloc>().add(
                  const SettingsSignOutRequested(discardUnsyncedChanges: false),
                ),
          child: _isBusy ? const _ButtonProgress() : Text(context.s.settingsSignOutButton),
        ),
      ],
    );
  }
}

class const _SignOutBlockedDialog() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.s.settingsSignOutBlockedTitle),
      content: Text(context.s.settingsSignOutBlockedMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.s.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(context.s.settingsSignOutAnywayButton),
        ),
      ],
    );
  }
}

class const _ButtonProgress() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: Spacing.iconS,
      child: CircularProgressIndicator(strokeWidth: Spacing.borderWidthMedium),
    );
  }
}
