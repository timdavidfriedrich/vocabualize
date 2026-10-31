import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/appearance_mode.dart';
import 'package:shared/domain/entities/backup_import_status.dart';
import 'package:shared/domain/entities/default_gather_option.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_kind.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/appearance_mode_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/default_gather_option_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/extensions/string_extensions.dart';
import 'package:shared/presentation/extensions/sync_status_extensions.dart';
import 'package:shared/presentation/language_setup/language_setup_cubit.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/reminders/reminder_cubit.dart';
import 'package:shared/presentation/sync_status/sync_status_cubit.dart';
import 'package:shared/presentation/widgets/account_conflict_dialog.dart';
import 'package:shared/presentation/widgets/account_status_avatar.dart';
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
                      GoogleAccount(:final name, :final email, :final picturePath) => _AccountCard(
                        name: name,
                        email: email,
                        picturePath: picturePath,
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
                    title: Text(context.s.reportFeedbackTitle),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: context.pushFeedback,
                  ),
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

class const _LanguageTiles({
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageSetupCubit, LanguageSetup?>(
      builder: (context, setup) => Column(
        children: [
          ListTile(
            title: Text(context.s.settingsSourceLanguageTitle),
            subtitle: Text(context.s.settingsSourceLanguageHint),
            trailing: _LanguageButton(label: setup?.main.toLabel(context), isBusy: _isBusy),
          ),
          ListTile(
            title: Text(context.s.settingsTargetLanguageTitle),
            subtitle: Text(context.s.settingsTargetLanguageHint),
            trailing: _LanguageButton(label: setup?.selected.toLabel(context), isBusy: _isBusy),
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

class const _ChoiceButton<T>({
  required final T _value,
  required final List<T> _options,
  required final String Function(T option) _labelOf,
  required final ValueChanged<T> _onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        for (final option in _options)
          MenuItemButton(
            onPressed: () => _onSelected(option),
            trailingIcon: option == _value ? const Icon(Icons.check_rounded) : null,
            child: Text(_labelOf(option)),
          ),
      ],
      builder: (context, controller, child) => OutlinedButton(
        onPressed: () => controller.isOpen ? controller.close() : controller.open(),
        child: Text(_labelOf(_value)),
      ),
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
          ListTile(
            title: Text(context.s.settingsAppearanceTitle),
            subtitle: Text(context.s.settingsAppearanceHint),
            trailing: _ChoiceButton(
              value: preferences.appearanceMode,
              options: AppearanceMode.values,
              labelOf: (mode) => mode.toLabel(context),
              onSelected: (mode) => bloc.add(SettingsAppearanceModeChanged(mode: mode)),
            ),
          ),
          SwitchListTile(
            title: Text(context.s.settingsTypeAnswerDisabledTitle),
            subtitle: Text(context.s.settingsTypeAnswerDisabledHint),
            value: preferences.isTypeAnswerDisabled,
            onChanged: (isDisabled) =>
                bloc.add(SettingsTypeAnswerDisabledChanged(isDisabled: isDisabled)),
          ),
          SwitchListTile(
            title: Text(context.s.settingsStrictCorrectionTitle),
            subtitle: Text(context.s.settingsStrictCorrectionHint),
            value: preferences.isStrictCorrectionEnabled,
            onChanged: preferences.isTypeAnswerDisabled
                ? null
                : (isEnabled) => bloc.add(SettingsStrictCorrectionChanged(isEnabled: isEnabled)),
          ),
          SwitchListTile(
            title: Text(context.s.settingsImagesHiddenTitle),
            subtitle: Text(context.s.settingsImagesHiddenHint),
            value: preferences.areImagesHidden,
            onChanged: (areHidden) => bloc.add(SettingsImagesHiddenChanged(areHidden: areHidden)),
          ),
          ListTile(
            title: Text(context.s.settingsDefaultGatherTitle),
            subtitle: Text(context.s.settingsDefaultGatherHint),
            trailing: _ChoiceButton(
              value: preferences.defaultGatherOption.withImagesHidden(preferences.areImagesHidden),
              options: [
                for (final option in DefaultGatherOption.values)
                  if (option.withImagesHidden(preferences.areImagesHidden) == option) option,
              ],
              labelOf: (option) => option.toLabel(context),
              onSelected: (option) => bloc.add(SettingsDefaultGatherOptionChanged(option: option)),
            ),
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
        AdaptiveActions(
          spacing: Spacing.xs,
          stackedSpacing: Spacing.xxs,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(context.s.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(context.s.settingsImportBackupConfirmButton),
            ),
          ],
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
          BlocBuilder<ConnectivityCubit, bool>(
            builder: (context, isConnected) => switch (isConnected) {
              true => const SizedBox.shrink(),
              false => _StatusNotice(
                message: context.s.settingsSignInOfflineMessage,
                action: const _ConnectButton(),
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

class const _AccountCard({
  required final String? _name,
  required final String? _email,
  required final String? _picturePath,
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
              final message? when status.needsAttention => _StatusNotice(
                message: message,
                action: switch (status) {
                  SyncStatus.offline => const _ConnectButton(),
                  SyncStatus.signInRequired => _SignInAgainButton(runningAction: _runningAction),
                  SyncStatus.updateRequired => const _UpdateButton(),
                  _ => null,
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

class const _StatusNotice({
  required final String _message,
  final Widget? _action,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.m),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.c.surfaceContainerHighest,
          borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusM)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(_message, style: context.t.bodyMedium),
              if (_action case final action?)
                Align(alignment: Alignment.centerRight, child: action),
            ],
          ),
        ),
      ),
    );
  }
}

class const _ConnectButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: context.read<ConnectivityCubit>().openInternetSettings,
      icon: const Icon(Icons.wifi_rounded),
      label: Text(context.s.connectToInternet),
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

class const _SignOutBlockedDialog() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.s.settingsSignOutBlockedTitle),
      content: Text(context.s.settingsSignOutBlockedMessage),
      actions: [
        AdaptiveActions(
          spacing: Spacing.xs,
          stackedSpacing: Spacing.xxs,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(context.s.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(context.s.settingsSignOutAnywayButton),
            ),
          ],
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
        AdaptiveActions(
          spacing: Spacing.xs,
          stackedSpacing: Spacing.xxs,
          children: [
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
        ),
      ],
    );
  }
}
