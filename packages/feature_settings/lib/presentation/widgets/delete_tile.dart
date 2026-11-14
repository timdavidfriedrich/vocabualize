import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/extensions/string_extensions.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';
import 'package:shared/presentation/widgets/connection_required_notice.dart';

class const DeleteTile({
  super.key,
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
