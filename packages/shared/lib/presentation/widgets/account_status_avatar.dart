import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/sync_status_extensions.dart';
import 'package:shared/presentation/sync_status/sync_status_cubit.dart';
import 'package:shared/presentation/widgets/account_avatar.dart';

const _ringGap = Spacing.xxxs;
const _badgeRadius = Spacing.s;
const _badgeIconSize = Spacing.m;

class const AccountStatusAvatar({
  super.key,
  required final String? _picturePath,
  required final double _radius,
  final Widget? _providerBadge,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ringSize = (_radius + _ringGap) * 2;
    return BlocBuilder<SyncStatusCubit, SyncStatus>(
      builder: (context, status) => Semantics(
        label: status.toLabel(context),
        child: SizedBox.square(
          dimension: ringSize,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              if (status == SyncStatus.connecting || status == SyncStatus.syncing)
                SizedBox.square(
                  dimension: ringSize,
                  child: const CircularProgressIndicator(strokeWidth: Spacing.borderWidthMedium),
                ),
              AccountAvatar(picturePath: _picturePath, radius: _radius),
              if (_providerBadge case final providerBadge?)
                Positioned(right: 0, bottom: 0, child: providerBadge),
              if (status.badgeIcon case final icon?)
                Positioned(
                  top: -Spacing.xs,
                  right: -Spacing.xs,
                  child: CircleAvatar(
                    radius: _badgeRadius,
                    backgroundColor: status.needsAction
                        ? context.c.error
                        : context.c.surfaceContainerHighest,
                    child: Icon(
                      icon,
                      size: _badgeIconSize,
                      color: status.needsAction ? context.c.onError : context.c.onSurface,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
