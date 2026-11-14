import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const StatusNotice({
  super.key,
  required final String _message,
  final Widget? _action,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.m),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.c.surfaceContainerHighest,
          borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusM)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(_message, style: context.t.bodyMedium),
              if (_action case final action?)
                Align(alignment: Alignment.centerRight, child: action),
            ],
          ),
        ),
      ),
    );
  }
}
