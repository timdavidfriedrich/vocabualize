import 'package:feature_languages/presentation/learned_language/learned_language_bloc.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_event.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_state.dart';
import 'package:feature_languages/presentation/widgets/delete_language_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language_setup_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/app_menu.dart';

class const LearnedLanguageMoreMenu({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnedLanguageBloc, LearnedLanguageState>(
      builder: (context, state) => switch (state) {
        final LearnedLanguageLoaded loaded => _MoreMenuButton(state: loaded),
        LearnedLanguageLoading() ||
        LearnedLanguageClosed() ||
        LearnedLanguageFailure() => const SizedBox.shrink(),
      },
    );
  }
}

class const _MoreMenuButton({
  required final LearnedLanguageLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LearnedLanguageBloc>();
    final learned = _state.learned;
    final label = learned.language.toShortLabel(context);
    final isLastActive = !learned.isPaused && _state.setup.active.length == 1;
    final canChange = !_state.isBusy && !isLastActive;
    return AppMenuAnchor(
      items: [
        if (!learned.isPaused)
          AppMenuItem(
            leading: const Icon(Icons.pause_rounded),
            title: context.s.learnedLanguagePauseButton(label),
            subtitle: isLastActive ? context.s.learnedLanguageLastActiveHint : null,
            onTap: canChange ? () => bloc.add(const LearnedLanguagePauseRequested()) : null,
          ),
        AppMenuItem(
          leading: const Icon(Icons.delete_outline_rounded),
          title: context.s.delete,
          isDestructive: true,
          onTap: canChange ? () => _delete(context) : null,
        ),
      ],
      builder: (context, controller) => IconButton(
        onPressed: () => controller.isOpen ? controller.close() : controller.open(),
        tooltip: MaterialLocalizations.of(context).showMenuTooltip,
        icon: const Icon(Icons.more_vert_rounded),
      ),
    );
  }

  Future<void> _delete(BuildContext context) async {
    final bloc = context.read<LearnedLanguageBloc>();
    final language = _state.learned.language;
    final isConfirmed = await confirmsLanguageDelete(
      context,
      language: language,
      wordCount: _state.coverage?.inLanguageCount,
      keptLanguages: [
        for (final learned in _state.setup.learned)
          if (learned.language != language) learned.language,
      ],
    );
    if (isConfirmed) bloc.add(const LearnedLanguageDeleteRequested());
  }
}
