import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const SectionTitle({
  super.key,
  required final String _title,
  final bool _isMuted = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: context.t.titleMedium?.copyWith(
        color: _isMuted ? context.c.onSurfaceVariant : context.c.primary,
      ),
    );
  }
}
