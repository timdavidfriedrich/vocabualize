import 'package:core/theme/spacing.dart';
import 'package:feature_gate/presentation/wait_for_data/wait_for_data_cubit.dart';
import 'package:feature_gate/presentation/wait_for_data/wait_for_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/data_readiness.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<WaitForDataCubit, WaitForDataState>(
          listenWhen: (previous, current) => previous.error == null && current.error != null,
          listener: (context, state) {
            if (state.error case final error?) context.showToast(error.toMessage(context));
          },
        ),
        BlocListener<WaitForDataCubit, WaitForDataState>(
          listenWhen: (previous, current) =>
              previous.accountConflict == null && current.accountConflict != null,
          listener: (context, state) async {
            if (state.accountConflict case final conflict?) {
              final switchesAccount = await confirmsAccountSwitch(context, conflict);
              await cubit.resolveAccountConflict(keepsPreviousAccount: !switchesAccount);
            }
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.xl),
            child: BlocBuilder<WaitForDataCubit, WaitForDataState>(
              builder: (context, state) => switch (_reason) {
                DataUnavailableReason.offline => _Content(
                  pose: MascotPose.offline,
                  title: context.s.dataOfflineTitle,
                  message: context.s.dataOfflineMessage,
                  action: (
                    label: context.s.connectToInternet,
                    onPressed: context.read<ConnectivityCubit>().openInternetSettings,
                  ),
                ),
                DataUnavailableReason.serverUnreachable => _Content(
                  pose: MascotPose.offline,
                  title: context.s.dataServerUnreachableTitle,
                  message: context.s.dataServerUnreachableMessage,
                  action: (
                    label: context.s.dataRetryButton,
                    onPressed: state.isBusy ? null : cubit.retry,
                  ),
                ),
                DataUnavailableReason.signInRequired => _Content(
                  pose: MascotPose.idle,
                  title: context.s.dataSignInRequiredTitle,
                  message: context.s.dataSignInRequiredMessage,
                  action: (
                    label: context.s.dataSignInButton,
                    onPressed: state.isBusy ? null : cubit.signIn,
                  ),
                ),
                DataUnavailableReason.updateRequired => _Content(
                  pose: MascotPose.idle,
                  title: context.s.gateUpdateTitle,
                  message: context.s.gateUpdateMessage,
                  action: (
                    label: context.s.gateUpdateButton,
                    onPressed: state.isBusy ? null : cubit.openStore,
                  ),
                ),
                DataUnavailableReason.syncFailed => _Content(
                  pose: MascotPose.idle,
                  title: context.s.dataSyncFailedTitle,
                  message: context.s.dataSyncFailedMessage,
                  action: (
                    label: context.s.dataRetryButton,
                    onPressed: state.isBusy ? null : cubit.retry,
                  ),
                ),
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
