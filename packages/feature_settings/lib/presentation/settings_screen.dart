import 'package:core/theme/spacing.dart';
import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/backup_import_status.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/extensions/string_extensions.dart';
import 'package:shared/presentation/extensions/sync_status_extensions.dart';
import 'package:shared/presentation/language_pair/language_pair_cubit.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/reminders/practice_reminder_cubit.dart';
import 'package:shared/presentation/sync_status/sync_status_cubit.dart';
import 'package:shared/presentation/widgets/account_conflict_dialog.dart';
import 'package:shared/presentation/widgets/connection_required_notice.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';

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
        BlocListener<SettingsBloc, SettingsState>(
          listenWhen: (previous, current) => switch ((previous, current)) {
            (SettingsLoaded(accountConflict: null), SettingsLoaded(accountConflict: _?)) => true,
            _ => false,
          },
          listener: (context, state) async {
            if (state case SettingsLoaded(accountConflict: final conflict?)) {
              final bloc = context.read<SettingsBloc>();
              final switchesAccount = await confirmsAccountSwitch(context, conflict);
              bloc.add(SettingsAccountConflictResolved(keepsPreviousAccount: !switchesAccount));
            }
          },
        ),
        BlocListener<SettingsBloc, SettingsState>(
          listenWhen: (previous, current) => switch ((previous, current)) {
            (SettingsLoaded(importedCount: null), SettingsLoaded(importedCount: _?)) => true,
            _ => false,
          },
          listener: (context, state) {
            if (state case SettingsLoaded(importedCount: final count?)) {
              context.showToast(context.s.settingsImportBackupDone(count));
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(context.s.settingsTitle)),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) => switch (state) {
            SettingsLoading() => const LoadingView(),
            SettingsLoaded(
              importProgress: BackupImportRunning(:final processedImages, :final totalImages),
            ) =>
              LoadingView(
                progress: LoadingProgress(current: processedImages, total: totalImages),
              ),
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
                const SizedBox(height: Spacing.xl),
                Text(context.s.settingsLanguagesTitle, style: context.t.titleMedium),
                BlocBuilder<LanguagePairCubit, LanguagePair?>(
                  builder: (context, pair) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    enabled: !isBusy,
                    leading: const Icon(Icons.translate_rounded),
                    title: Text(pair?.toLabel(context) ?? context.s.unknown),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: context.pushLanguageSelection,
                  ),
                ),
                const SizedBox(height: Spacing.xl),
                Text(context.s.settingsLearningTitle, style: context.t.titleMedium),
                const _LearningSection(),
                const SizedBox(height: Spacing.xl),
                Text(context.s.settingsNotificationsTitle, style: context.t.titleMedium),
                const _NotificationsSection(),
                const SizedBox(height: Spacing.xl),
                Text(context.s.settingsBackupTitle, style: context.t.titleMedium),
                const SizedBox(height: Spacing.xs),
                _BackupSection(isBusy: isBusy),
                const SizedBox(height: Spacing.xl),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.feedback_rounded),
                  title: Text(context.s.settingsFeedbackButton),
                  subtitle: Text(context.s.settingsFeedbackHint),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: context.pushFeedback,
                ),
                const Divider(height: Spacing.xl),
                _DeleteTile(account: account, isBusy: isBusy),
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

class const _LearningSection() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    return BlocBuilder<PreferencesCubit, Preferences>(
      builder: (context, preferences) => Column(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.keyboard_rounded),
            title: Text(context.s.settingsTypeAnswerDisabledTitle),
            subtitle: Text(context.s.settingsTypeAnswerDisabledHint),
            value: preferences.isTypeAnswerDisabled,
            onChanged: (isDisabled) =>
                bloc.add(SettingsTypeAnswerDisabledChanged(isDisabled: isDisabled)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.hide_image_rounded),
            title: Text(context.s.settingsImagesHiddenTitle),
            subtitle: Text(context.s.settingsImagesHiddenHint),
            value: preferences.areImagesHidden,
            onChanged: (areHidden) => bloc.add(SettingsImagesHiddenChanged(areHidden: areHidden)),
          ),
        ],
      ),
    );
  }
}

class const _NotificationsSection() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    return BlocSelector<PreferencesCubit, Preferences, PracticeReminder>(
      selector: (preferences) => preferences.practiceReminder,
      builder: (context, reminder) => BlocBuilder<PracticeReminderCubit, bool>(
        builder: (context, isPermitted) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.notifications_rounded),
              title: Text(context.s.settingsPracticeReminderTitle),
              subtitle: Text(context.s.settingsPracticeReminderHint),
              value: reminder.isEnabled,
              onChanged: (isEnabled) =>
                  bloc.add(SettingsPracticeReminderToggled(isEnabled: isEnabled)),
            ),
            if (reminder.isEnabled) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.schedule_rounded),
                title: Text(context.s.settingsReminderTimeTitle),
                trailing: Text(
                  TimeOfDay(hour: reminder.hour, minute: reminder.minute).format(context),
                  style: context.t.bodyLarge,
                ),
                onTap: () => _pickTime(context, reminder),
              ),
              if (!isPermitted) ...[
                Text(
                  context.s.settingsNotificationsBlockedMessage,
                  style: context.t.bodyMedium?.copyWith(color: context.c.error),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () => bloc.add(const SettingsNotificationSettingsOpened()),
                    child: Text(context.s.settingsOpenNotificationSettingsButton),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _pickTime(BuildContext context, PracticeReminder reminder) async {
    final bloc = context.read<SettingsBloc>();
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: reminder.hour, minute: reminder.minute),
    );
    if (time != null) {
      bloc.add(SettingsPracticeReminderTimeChanged(hour: time.hour, minute: time.minute));
    }
  }
}

class const _BackupSection({
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          enabled: !_isBusy,
          leading: const Icon(Icons.ios_share_rounded),
          title: Text(context.s.settingsExportBackupButton),
          subtitle: Text(context.s.settingsExportBackupHint),
          onTap: () => context.read<SettingsBloc>().add(const SettingsBackupExportRequested()),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          enabled: !_isBusy,
          leading: const Icon(Icons.download_rounded),
          title: Text(context.s.settingsImportBackupButton),
          subtitle: Text(context.s.settingsImportBackupHint),
          trailing: _isBusy ? const _ButtonProgress() : null,
          onTap: () => _confirmImport(context),
        ),
      ],
    );
  }

  Future<void> _confirmImport(BuildContext context) async {
    final bloc = context.read<SettingsBloc>();
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => const _ImportBackupDialog(),
    );
    if (isConfirmed == true) bloc.add(const SettingsBackupImportRequested());
  }
}

class const _ImportBackupDialog() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.s.settingsImportBackupConfirmTitle),
      content: Text(context.s.settingsImportBackupConfirmMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.s.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(context.s.settingsImportBackupConfirmButton),
        ),
      ],
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
        ConnectionRequiredNotice(message: context.s.settingsSignInOfflineMessage),
        BlocBuilder<ConnectivityCubit, bool>(
          builder: (context, isConnected) => FilledButton(
            onPressed: _isBusy || !isConnected
                ? null
                : () => context.read<SettingsBloc>().add(const SettingsGoogleSignInRequested()),
            child: _isBusy ? const _ButtonProgress() : Text(context.s.settingsSignInButton),
          ),
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
        BlocBuilder<SyncStatusCubit, SyncStatus>(
          builder: (context, status) => switch (status.toLabel(context)) {
            final label? => Text(
              label,
              style: context.t.bodyMedium?.copyWith(
                color: status.needsAction ? context.c.error : context.c.onSurfaceVariant,
              ),
            ),
            null => const SizedBox.shrink(),
          },
        ),
        BlocBuilder<SyncStatusCubit, SyncStatus>(
          builder: (context, status) => switch (status) {
            SyncStatus.signInRequired => Padding(
              padding: const EdgeInsets.only(top: Spacing.s),
              child: BlocBuilder<ConnectivityCubit, bool>(
                builder: (context, isConnected) => FilledButton(
                  onPressed: _isBusy || !isConnected
                      ? null
                      : () =>
                            context.read<SettingsBloc>().add(const SettingsGoogleSignInRequested()),
                  child: Text(context.s.settingsSignInAgainButton),
                ),
              ),
            ),
            _ => const SizedBox.shrink(),
          },
        ),
        const SizedBox(height: Spacing.s),
        ConnectionRequiredNotice(message: context.s.settingsSignOutOfflineMessage),
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

class const _DeleteTile({
  required final Account _account,
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isAccount = _account is GoogleAccount;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      enabled: !_isBusy,
      iconColor: context.c.error,
      textColor: context.c.error,
      leading: const Icon(Icons.delete_forever_rounded),
      title: Text(
        isAccount ? context.s.settingsDeleteAccountButton : context.s.settingsDeleteDataButton,
      ),
      onTap: () => _confirm(context, isAccount: isAccount),
    );
  }

  Future<void> _confirm(BuildContext context, {required bool isAccount}) async {
    final bloc = context.read<SettingsBloc>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => _DeleteDialog(isAccount: isAccount),
    );
    if (confirmed == true) bloc.add(const SettingsDeletionRequested());
  }
}

class const _DeleteDialog({
  required final bool _isAccount,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final typed = useValueListenable(controller).text;
    final confirmWord = context.s.settingsDeleteConfirmWord;
    return AlertDialog(
      title: Text(
        _isAccount ? context.s.settingsDeleteAccountTitle : context.s.settingsDeleteDataTitle,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _isAccount
                ? context.s.settingsDeleteAccountMessage
                : context.s.settingsDeleteDataMessage,
          ),
          const SizedBox(height: Spacing.m),
          TextField(
            controller: controller,
            autofocus: true,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(hintText: context.s.settingsDeleteConfirmHint(confirmWord)),
          ),
          if (_isAccount) ...[
            const SizedBox(height: Spacing.s),
            ConnectionRequiredNotice(message: context.s.settingsDeleteAccountOfflineMessage),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.s.cancel),
        ),
        BlocBuilder<ConnectivityCubit, bool>(
          builder: (context, isConnected) => FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: context.c.error,
              foregroundColor: context.c.onError,
            ),
            onPressed: typed.matchesLoosely(confirmWord) && (isConnected || !_isAccount)
                ? () => Navigator.of(context).pop(true)
                : null,
            child: Text(context.s.settingsDeleteConfirmButton),
          ),
        ),
      ],
    );
  }
}
