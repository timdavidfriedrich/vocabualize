import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/system_action/system_action_cubit.dart';

class const ConnectButton({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: context.read<SystemActionCubit>().openInternetSettings,
      icon: const Icon(Icons.wifi_rounded),
      label: Text(context.s.connectToInternet),
    );
  }
}
