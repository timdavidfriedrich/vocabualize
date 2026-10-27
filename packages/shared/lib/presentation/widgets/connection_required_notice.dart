import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const ConnectionRequiredNotice({
  super.key,
  required final String _message,
  final bool _isCentered = false,
  final Color? _color,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, bool>(
      builder: (context, isConnected) => switch (isConnected) {
        true => const SizedBox.shrink(),
        false => Column(
          crossAxisAlignment: _isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Text(
              _message,
              textAlign: _isCentered ? TextAlign.center : TextAlign.start,
              style: context.t.bodyMedium?.copyWith(color: _color ?? context.c.onSurfaceVariant),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(padding: EdgeInsets.zero, foregroundColor: _color),
              onPressed: context.read<ConnectivityCubit>().openInternetSettings,
              icon: const Icon(Icons.wifi_rounded),
              label: Text(context.s.connectToInternet),
            ),
          ],
        ),
      },
    );
  }
}
