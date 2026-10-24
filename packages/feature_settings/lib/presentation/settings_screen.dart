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
    return BlocListener<SettingsBloc, SettingsState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (SettingsLoaded(signInError: null), SettingsLoaded(signInError: _?)) => true,
        _ => false,
      },
      listener: (context, state) {
        if (state case SettingsLoaded(signInError: final error?)) {
          context.showToast(error.toMessage(context));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.s.settingsTitle)),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) => switch (state) {
            SettingsLoading() => const Center(child: CircularProgressIndicator()),
            SettingsLoaded(:final account, :final isSigningIn) => ListView(
              padding: const EdgeInsets.all(Spacing.m),
              children: [
                Text(context.s.settingsAccountTitle, style: context.t.titleMedium),
                const SizedBox(height: Spacing.xs),
                switch (account) {
                  LocalAccount() => _LocalAccountSection(isSigningIn: isSigningIn),
                  GoogleAccount(:final name, :final email) => _GoogleAccountSection(
                    name: name,
                    email: email,
                  ),
                },
              ],
            ),
          },
        ),
      ),
    );
  }
}

class const _LocalAccountSection({
  required final bool _isSigningIn,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(context.s.settingsSignInHint, style: context.t.bodyMedium),
        const SizedBox(height: Spacing.s),
        FilledButton(
          onPressed: _isSigningIn
              ? null
              : () => context.read<SettingsBloc>().add(const SettingsGoogleSignInRequested()),
          child: _isSigningIn
              ? const SizedBox.square(
                  dimension: Spacing.iconS,
                  child: CircularProgressIndicator(strokeWidth: Spacing.borderWidthMedium),
                )
              : Text(context.s.settingsSignInButton),
        ),
      ],
    );
  }
}

class const _GoogleAccountSection({
  required final String? _name,
  required final String? _email,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.account_circle_rounded),
      title: Text(_name ?? _email ?? context.s.unknown),
      subtitle: _name == null || _email == null ? null : Text(_email),
    );
  }
}
