import 'package:core/theme/spacing.dart';
import 'package:feature_gate/presentation/wait_for_data/wait_for_data_cubit.dart';
import 'package:feature_gate/presentation/wait_for_data/wait_for_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/data_readiness.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
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
      listenWhen: (previous, current) => previous.error == null && current.error != null,
      listener: (context, state) {
        if (state.error case final error?) context.showToast(error.toMessage(context));
      },
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
                  actionLabel: context.s.dataRetryButton,
                  onAction: state.isBusy ? null : cubit.retry,
                ),
                DataUnavailableReason.signInRequired => _Content(
                  pose: MascotPose.idle,
                  title: context.s.dataSignInRequiredTitle,
                  message: context.s.dataSignInRequiredMessage,
                  actionLabel: context.s.dataSignInButton,
                  onAction: state.isBusy ? null : cubit.signIn,
                ),
                DataUnavailableReason.updateRequired => _Content(
                  pose: MascotPose.idle,
                  title: context.s.gateUpdateTitle,
                  message: context.s.gateUpdateMessage,
                  actionLabel: context.s.gateUpdateButton,
                  onAction: state.isBusy ? null : cubit.openStore,
                ),
              },
            ),
          ),
        ),
      ),
    );
  }
}

class const _Content({
  required final MascotPose _pose,
  required final String _title,
  required final String _message,
  required final String _actionLabel,
  required final VoidCallback? _onAction,
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
        const SizedBox(height: Spacing.xl),
        FilledButton(onPressed: _onAction, child: Text(_actionLabel)),
      ],
    );
  }
}
