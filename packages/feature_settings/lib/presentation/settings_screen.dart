import 'package:core/theme/spacing.dart';
import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_state.dart';
import 'package:feature_settings/presentation/widgets/account_card.dart';
import 'package:feature_settings/presentation/widgets/backup_section.dart';
import 'package:feature_settings/presentation/widgets/delete_tile.dart';
import 'package:feature_settings/presentation/widgets/display_section.dart';
import 'package:feature_settings/presentation/widgets/learning_section.dart';
import 'package:feature_settings/presentation/widgets/notifications_section.dart';
import 'package:feature_settings/presentation/widgets/settings_group.dart';
import 'package:feature_settings/presentation/widgets/sign_in_card.dart';
import 'package:feature_settings/presentation/widgets/sign_out_blocked_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/backup_import_status.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/account_conflict_dialog.dart';
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
                tileColor: context.c.surfaceContainerLowest,
                subtitleTextStyle: context.t.bodyMedium?.copyWith(color: context.c.outline),
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.m, Spacing.m, Spacing.xxl),
                children: [
                  switch (account) {
                    LocalAccount() => SignInCard(runningAction: runningAction),
                    GoogleAccount(:final name, :final email, :final picturePath) => AccountCard(
                      name: name,
                      email: email,
                      picturePath: picturePath,
                      runningAction: runningAction,
                    ),
                  },
                  const SizedBox(height: Spacing.xl),
                  const DisplaySection(),
                  const LearningSection(),
                  const NotificationsSection(),
                  BackupSection(runningAction: runningAction),
                  SettingsGroup(
                    title: context.s.settingsAboutSectionTitle,
                    children: [
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
                    ],
                  ),
                  SettingsGroup(
                    title: null,
                    children: [DeleteTile(account: account, runningAction: runningAction)],
                  ),
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
      builder: (dialogContext) => const SignOutBlockedDialog(),
    );
    bloc.add(
      signOutAnyway == true
          ? const SettingsSignOutRequested(discardUnsyncedChanges: true)
          : const SettingsSignOutDismissed(),
    );
  }
}
