import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/practice/practice_bloc.dart';
import 'package:feature_practice/presentation/practice/practice_event.dart';
import 'package:feature_practice/presentation/widgets/edit_word_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_card.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _buttonSize = Spacing.xxxl + Spacing.xs;

class const PhotoActions({
  super.key,
  required final PracticeCard _card,
  required final Language _main,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CircleButton(
          icon: Icons.volume_up_rounded,
          tooltip: context.s.vocabularySpeakTooltip,
          onPressed: () => context.read<PracticeBloc>().add(const PracticeSpeakRequested()),
        ),
        const SizedBox(width: Spacing.s),
        _CircleButton(
          icon: Icons.edit_outlined,
          tooltip: context.s.edit,
          onPressed: () => editPracticeWord(context, card: _card, main: _main),
        ),
      ],
    );
  }
}

class const _CircleButton({
  required final IconData _icon,
  required final String _tooltip,
  required final VoidCallback _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _buttonSize,
      child: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: context.c.surface,
          foregroundColor: context.c.primary,
          shape: const CircleBorder(),
        ),
        onPressed: _onPressed,
        tooltip: _tooltip,
        icon: Icon(_icon),
      ),
    );
  }
}
