import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/widgets/section_title.dart';

class const SettingsGroup({
  super.key,
  required final String? _title,
  required final List<Widget> _children,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_title case final title?)
            Padding(
              padding: const EdgeInsets.fromLTRB(Spacing.xxxs, 0, Spacing.xxxs, Spacing.s),
              child: SectionTitle(title: title),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(Spacing.radiusXxl),
            child: Material(
              type: MaterialType.transparency,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: Spacing.tileGap,
                children: _children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
