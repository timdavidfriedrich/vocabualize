import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_state.dart';
import 'package:feature_settings/presentation/widgets/settings_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';

class const BackupSection({
  super.key,
  required final SettingsAction? _runningAction,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: context.s.settingsBackupSectionTitle,
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
