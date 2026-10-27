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
import 'package:shared/domain/entities/reminder_kind.dart';
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
import 'package:shared/presentation/reminders/reminder_cubit.dart';
import 'package:shared/presentation/sync_status/sync_status_cubit.dart';
import 'package:shared/presentation/widgets/account_conflict_dialog.dart';
import 'package:shared/presentation/widgets/button_progress.dart';
import 'package:shared/presentation/widgets/connection_required_notice.dart';
import 'package:shared/presentation/widgets/google_logo.dart';
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
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          title: Text(context.s.settingsTitle),
          actions: const [
            _FeedbackButton(),
            SizedBox(width: Spacing.xxl),
          ],
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) => switch (state) {
            SettingsLoading() => const LoadingView(),
            SettingsLoaded(
              importProgress: BackupImportRunning(:final processedImages, :final totalImages),
            ) =>
              LoadingView(
                progress: LoadingProgress(current: processedImages, total: totalImages),
              ),
            SettingsLoaded(:final account, :final runningAction) => ListTileTheme(
              data: ListTileThemeData(
                contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.m),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusL)),
                ),
                subtitleTextStyle: context.t.bodyMedium?.copyWith(color: context.c.outline),
              ),
              child: ListView(
                padding: const EdgeInsets.all(Spacing.m),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
                    child: switch (account) {
                      LocalAccount() => _SignInCard(runningAction: runningAction),
                      GoogleAccount(:final name, :final email) => _AccountCard(
                        name: name,
                        email: email,
                        runningAction: runningAction,
                      ),
                    },
                  ),
                  const SizedBox(height: Spacing.xl),
                  _LanguageTiles(isBusy: runningAction != null),
                  const SizedBox(height: Spacing.m),
                  const _LearningSection(),
                  const SizedBox(height: Spacing.m),
                  const _NotificationsSection(),
                  const SizedBox(height: Spacing.m),
                  _BackupSection(runningAction: runningAction),
                  ListTile(
                    title: Text(context.s.settingsPrivacyPolicyButton),
                    trailing: const Icon(Icons.open_in_new_rounded),
                    onTap: () => context.read<SettingsBloc>().add(
                      SettingsPrivacyPolicyOpened(
                        languageCode: Localizations.localeOf(context).languageCode,
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.m),
                  _DeleteTile(account: account, runningAction: runningAction),
                  const SizedBox(height: Spacing.xxl),
                ],
              ),
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

class const _FeedbackButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: context.c.onSurfaceVariant,
        side: BorderSide(color: context.c.outlineVariant),
        padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xxs),
        minimumSize: Size.zero,
        textStyle: context.t.labelMedium,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Spacing.radiusS)),
        ),
      ),
      onPressed: context.pushFeedback,
      icon: const Icon(Icons.feedback_rounded, size: Spacing.iconS),
      label: Text(context.s.settingsFeedbackButton),
    );
  }
}

class const _LanguageTiles({
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguagePairCubit, LanguagePair?>(
      builder: (context, pair) => Column(
        children: [
          ListTile(
            title: Text(context.s.settingsSourceLanguageTitle),
            subtitle: Text(context.s.settingsSourceLanguageHint),
            trailing: _LanguageButton(label: pair?.source.toLabel(context), isBusy: _isBusy),
          ),
          ListTile(
            title: Text(context.s.settingsTargetLanguageTitle),
            subtitle: Text(context.s.settingsTargetLanguageHint),
            trailing: _LanguageButton(label: pair?.target.toLabel(context), isBusy: _isBusy),
          ),
        ],
      ),
    );
  }
}

class const _LanguageButton({
  required final String? _label,
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _isBusy ? null : context.pushLanguageSelection,
      child: Text(_label ?? context.s.unknown),
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
            title: Text(context.s.settingsTypeAnswerDisabledTitle),
            subtitle: Text(context.s.settingsTypeAnswerDisabledHint),
            value: preferences.isTypeAnswerDisabled,
            onChanged: (isDisabled) =>
                bloc.add(SettingsTypeAnswerDisabledChanged(isDisabled: isDisabled)),
          ),
          SwitchListTile(
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
    return BlocSelector<PreferencesCubit, Preferences, (DailyReminder, DailyReminder)>(
      selector: (preferences) => (preferences.practiceReminder, preferences.streakReminder),
      builder: (context, reminders) => BlocBuilder<ReminderCubit, bool>(
        builder: (context, isPermitted) {
          final (practiceReminder, streakReminder) = reminders;
          final isAnyEnabled = practiceReminder.isEnabled || streakReminder.isEnabled;
          return Column(
            children: [
              _ReminderSettings(
                kind: ReminderKind.practice,
                reminder: practiceReminder,
                title: context.s.settingsPracticeReminderTitle,
                hint: context.s.settingsPracticeReminderHint,
              ),
              _ReminderSettings(
                kind: ReminderKind.streak,
                reminder: streakReminder,
                title: context.s.settingsStreakReminderTitle,
                hint: context.s.settingsStreakReminderHint,
              ),
              if (isAnyEnabled && !isPermitted)
                ListTile(
                  title: Text(context.s.settingsOpenNotificationSettingsButton),
                  subtitle: Text(
                    context.s.settingsNotificationsBlockedMessage,
                    style: context.t.bodyMedium?.copyWith(color: context.c.error),
                  ),
                  trailing: const Icon(Icons.open_in_new_rounded),
                  onTap: () => context.read<SettingsBloc>().add(
                    const SettingsNotificationSettingsOpened(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class const _ReminderSettings({
  required final ReminderKind _kind,
  required final DailyReminder _reminder,
  required final String _title,
  required final String _hint,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: Text(_title),
          subtitle: Text(_hint),
          value: _reminder.isEnabled,
          onChanged: (isEnabled) => context.read<SettingsBloc>().add(
            SettingsReminderToggled(kind: _kind, isEnabled: isEnabled),
          ),
        ),
        if (_reminder.isEnabled)
          ListTile(
            title: Text(context.s.settingsReminderTimeTitle),
            trailing: Text(
              TimeOfDay(hour: _reminder.hour, minute: _reminder.minute).format(context),
              style: context.t.bodyLarge,
            ),
            onTap: () => _pickTime(context),
          ),
      ],
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    final bloc = context.read<SettingsBloc>();
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _reminder.hour, minute: _reminder.minute),
    );
    if (time != null) {
      bloc.add(SettingsReminderTimeChanged(kind: _kind, hour: time.hour, minute: time.minute));
    }
  }
}

class const _BackupSection({
  required final SettingsAction? _runningAction,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          enabled: _runningAction == null,
          title: Text(context.s.settingsExportBackupButton),
          subtitle: Text(context.s.settingsExportBackupHint),
          trailing: _runningAction == SettingsAction.backupExport
              ? const ButtonProgress()
              : const Icon(Icons.ios_share_rounded),
          onTap: () => context.read<SettingsBloc>().add(const SettingsBackupExportRequested()),
        ),
        ListTile(
          enabled: _runningAction == null,
          title: Text(context.s.settingsImportBackupButton),
          subtitle: Text(context.s.settingsImportBackupHint),
          trailing: _runningAction == SettingsAction.backupImport
              ? const ButtonProgress()
              : const Icon(Icons.download_rounded),
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

class const _Card({
  required final Widget _child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
      ),
      child: _child,
    );
  }
}

class const _SignInCard({
  required final SettingsAction? _runningAction,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.s.settingsSignInHint, style: context.t.bodyLarge),
          const SizedBox(height: Spacing.s),
          ConnectionRequiredNotice(message: context.s.settingsSignInOfflineMessage),
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

class const _AccountCard({
  required final String? _name,
  required final String? _email,
  required final SettingsAction? _runningAction,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const _Avatar(),
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
              final label? => Padding(
                padding: const EdgeInsets.only(top: Spacing.s),
                child: Text(
                  label,
                  style: context.t.bodyMedium?.copyWith(
                    color: status.needsAction ? context.c.error : context.c.onSurfaceVariant,
                  ),
                ),
              ),
              null => const SizedBox.shrink(),
            },
          ),
          BlocBuilder<SyncStatusCubit, SyncStatus>(
            builder: (context, status) => switch (status) {
              SyncStatus.signInRequired => Padding(
                padding: const EdgeInsets.only(top: Spacing.s),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<ConnectivityCubit, bool>(
                    builder: (context, isConnected) => ElevatedButton(
                      onPressed: _runningAction != null || !isConnected
                          ? null
                          : () => context.read<SettingsBloc>().add(
                              const SettingsGoogleSignInRequested(),
                            ),
                      child: _runningAction == SettingsAction.signIn
                          ? const ButtonProgress()
                          : Text(context.s.settingsSignInAgainButton),
                    ),
                  ),
                ),
              ),
              _ => const SizedBox.shrink(),
            },
          ),
          ConnectionRequiredNotice(message: context.s.settingsSignOutOfflineMessage),
        ],
      ),
    );
  }
}

class const _Avatar() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: context.c.primary,
          child: Icon(Icons.person_rounded, color: context.c.onPrimary),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircleAvatar(
            radius: Spacing.xs,
            backgroundColor: context.c.secondary,
            child: const GoogleLogo(size: Spacing.s),
          ),
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

class const _DeleteTile({
  required final Account _account,
  required final SettingsAction? _runningAction,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isAccount = _account is GoogleAccount;
    return ListTile(
      enabled: _runningAction == null,
      iconColor: context.c.error,
      textColor: context.c.error,
      trailing: _runningAction == SettingsAction.deletion
          ? const ButtonProgress()
          : const Icon(Icons.delete_forever_rounded),
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
