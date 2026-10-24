import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/sync_status_extensions.dart';
import 'package:shared/presentation/sync_status/sync_status_cubit.dart';

class const SyncStatusIcon({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncStatusCubit, SyncStatus>(
      builder: (context, status) => switch ((status.icon, status.toLabel(context))) {
        (final icon?, final label?) => Tooltip(
          message: label,
          triggerMode: TooltipTriggerMode.tap,
          child: Icon(
            icon,
            color: status.needsAction ? context.c.error : context.c.onSurfaceVariant,
          ),
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
