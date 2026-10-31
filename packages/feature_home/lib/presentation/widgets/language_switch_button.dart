import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/language_setup/language_setup_cubit.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/language_label.dart';

class const LanguageSwitchButton({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageSetupCubit, LanguageSetup?>(
      builder: (context, setup) => switch (setup) {
        null => const SizedBox.shrink(),
        final setup => TextButton(
          onPressed: () => _showSwitchSheet(context, setup),
          style: TextButton.styleFrom(
            foregroundColor: context.c.onSurface,
            padding: const EdgeInsets.symmetric(horizontal: Spacing.s),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: LanguageLabel(language: setup.selected, style: context.t.titleMedium),
              ),
              const Icon(Icons.arrow_drop_down_rounded),
            ],
          ),
        ),
      },
    );
  }

  Future<void> _showSwitchSheet(BuildContext context, LanguageSetup setup) {
    final cubit = context.read<LanguageSetupCubit>();
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final learned in setup.active)
              ListTile(
                title: LanguageLabel(language: learned.language),
                trailing: learned.language == setup.selected
                    ? Icon(Icons.check_rounded, color: context.c.primary)
                    : null,
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  cubit.select(learned.language);
                },
              ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.translate_rounded),
              title: Text(context.s.homeManageLanguagesButton),
              onTap: () {
                Navigator.of(sheetContext).pop();
                context.pushLanguages();
              },
            ),
            const SizedBox(height: Spacing.s),
          ],
        ),
      ),
    );
  }
}
