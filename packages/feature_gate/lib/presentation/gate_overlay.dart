import 'dart:async';

import 'package:core/theme/spacing.dart';
import 'package:feature_gate/presentation/gate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/gate_status.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const GateOverlay({
  super.key,
  required final Widget _child,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useOnAppLifecycleStateChange((previous, current) {
      if (current == AppLifecycleState.resumed) unawaited(context.read<GateCubit>().refresh());
    });
    return BlocBuilder<GateCubit, GateStatus>(
      builder: (context, status) => switch (status) {
        GateOpen() => _child,
        GateUpdateRequired() => _GateScreen(
          icon: Icons.system_update_rounded,
          title: context.s.gateUpdateTitle,
          message: context.s.gateUpdateMessage,
          action: FilledButton(
            onPressed: context.read<GateCubit>().openStore,
            child: Text(context.s.gateUpdateButton),
          ),
        ),
        GateMaintenance(:final message) => _GateScreen(
          icon: Icons.construction_rounded,
          title: context.s.gateMaintenanceTitle,
          message: message ?? context.s.gateMaintenanceMessage,
          action: null,
        ),
      },
    );
  }
}

class const _GateScreen({
  required final IconData _icon,
  required final String _title,
  required final String _message,
  required final Widget? _action,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_icon, size: Spacing.xxxxl, color: context.c.primary),
                const SizedBox(height: Spacing.xl),
                Text(_title, style: context.t.headlineSmall, textAlign: TextAlign.center),
                const SizedBox(height: Spacing.m),
                Text(
                  _message,
                  style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                if (_action case final action?) ...[
                  const SizedBox(height: Spacing.xl),
                  action,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
