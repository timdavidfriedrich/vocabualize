import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const HomeSectionTitle({
  super.key,
  required final String _title,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(_title, style: context.t.headlineSmall);
  }
}
