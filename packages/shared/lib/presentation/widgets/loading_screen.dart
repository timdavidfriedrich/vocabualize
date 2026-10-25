import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const LoadingProgress({
  required final int current,
  required final int total,
});

class const LoadingScreen({
  super.key,
  final LoadingProgress? _progress,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoadingView(progress: _progress));
  }
}

class const LoadingView({
  super.key,
  final LoadingProgress? _progress,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: switch (_progress) {
        LoadingProgress(:final current, :final total) when total > 0 => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(value: current / total),
            const SizedBox(height: Spacing.m),
            Text(context.s.loadingProgressLabel(current, total), style: context.t.bodyLarge),
          ],
        ),
        LoadingProgress() || null => const CircularProgressIndicator(),
      },
    );
  }
}
