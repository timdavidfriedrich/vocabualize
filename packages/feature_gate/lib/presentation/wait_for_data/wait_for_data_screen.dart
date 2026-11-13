import 'package:core/theme/spacing.dart';
import 'package:feature_gate/presentation/wait_for_data/wait_for_data_cubit.dart';
import 'package:feature_gate/presentation/wait_for_data/wait_for_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/data_readiness.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/system_action/system_action_cubit.dart';
import 'package:shared/presentation/widgets/account_conflict_dialog.dart';
import 'package:shared/presentation/widgets/mascot.dart';

const _mascotScreenHeightFactor = 0.4;

class const WaitForDataScreen({
  super.key,
  required final DataUnavailableReason _reason,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WaitForDataCubit>();
    return BlocListener<WaitForDataCubit, WaitForDataState>(
      listener: (context, state) async {
        switch (state) {
          case WaitForDataIdle(:final error?):
            context.showToast(error.toMessage(context));
          case WaitForDataIdle(:final accountConflict?):
            final switchesAccount = await confirmsAccountSwitch(context, accountConflict);
            await cubit.resolveAccountConflict(keepsPreviousAccount: !switchesAccount);
          case WaitForDataIdle() || WaitForDataBusy():
            break;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.xl),
            child: BlocBuilder<WaitForDataCubit, WaitForDataState>(
              builder: (context, state) {
                final isBusy = switch (state) {
                  WaitForDataBusy() => true,
                  WaitForDataIdle() => false,
                };
                return switch (_reason) {
                  DataUnavailableReason.offline => _Content(
                    pose: MascotPose.offline,
                    title: context.s.dataOfflineTitle,
                    message: context.s.dataOfflineMessage,
                    action: (
                      label: context.s.connectToInternet,
                      onPressed: context.read<SystemActionCubit>().openInternetSettings,
                    ),
                  ),
                  DataUnavailableReason.serverUnreachable => _Content(
                    pose: MascotPose.offline,
                    title: context.s.dataServerUnreachableTitle,
                    message: context.s.dataServerUnreachableMessage,
                    action: (
                      label: context.s.dataRetryButton,
                      onPressed: isBusy ? null : cubit.retry,
                    ),
                  ),
                  DataUnavailableReason.signInRequired => _Content(
                    pose: MascotPose.idle,
                    title: context.s.dataSignInRequiredTitle,
                    message: context.s.dataSignInRequiredMessage,
                    action: (
                      label: context.s.dataSignInButton,
                      onPressed: isBusy ? null : cubit.signIn,
                    ),
                  ),
                  DataUnavailableReason.updateRequired => _Content(
                    pose: MascotPose.idle,
                    title: context.s.gateUpdateTitle,
                    message: context.s.gateUpdateMessage,
                    action: (
                      label: context.s.gateUpdateButton,
                      onPressed: isBusy ? null : context.read<SystemActionCubit>().openStoreListing,
                    ),
                  ),
                  DataUnavailableReason.syncFailed => _Content(
                    pose: MascotPose.idle,
                    title: context.s.dataSyncFailedTitle,
                    message: context.s.dataSyncFailedMessage,
                    action: (
                      label: context.s.dataRetryButton,
                      onPressed: isBusy ? null : cubit.retry,
                    ),
                  ),
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}

typedef _Action = ({String label, VoidCallback? onPressed});

class const _Content({
  required final MascotPose _pose,
  required final String _title,
  required final String _message,
  required final _Action? _action,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * _mascotScreenHeightFactor,
          child: Mascot(pose: _pose),
        ),
        const Spacer(),
        Text(_title, style: context.t.headlineSmall, textAlign: TextAlign.center),
        const SizedBox(height: Spacing.m),
        Text(
          _message,
          style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
        if (_action case (:final label, :final onPressed)) ...[
          const SizedBox(height: Spacing.xl),
          FilledButton(onPressed: onPressed, child: Text(label)),
        ],
      ],
    );
  }
}
