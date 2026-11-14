import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:feature_home/presentation/widgets/language_menu_button.dart';
import 'package:feature_home/presentation/widgets/streak_chip.dart';
import 'package:feature_home/presentation/widgets/streak_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/presentation/account/account_cubit.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/account_status_avatar.dart';

const _avatarRadius = Spacing.m;

class const HomeAppBar({
  super.key,
}) extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: const _LanguageButton(),
      actionsPadding: const EdgeInsets.only(right: Spacing.m),
      actions: const [
        _StreakButton(),
        SizedBox(width: Spacing.xs),
        _AccountButton(),
      ],
    );
  }
}

class const _LanguageButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      HomeBloc,
      HomeState,
      ({LanguageSetup setup, Map<Language, VocabularyOverview> overviews})?
    >(
      selector: (state) => switch (state) {
        HomeLoaded(:final setup, :final overviews) => (setup: setup, overviews: overviews),
        HomeLoading(setup: final setup?, :final overviews) => (setup: setup, overviews: overviews),
        HomeLoading() || HomeFailure() => null,
      },
      builder: (context, menu) => switch (menu) {
        final menu? => LanguageMenuButton(setup: menu.setup, overviews: menu.overviews),
        null => const SizedBox.shrink(),
      },
    );
  }
}

class const _AccountButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, Account?>(
      builder: (context, account) => switch (account) {
        GoogleAccount(:final picturePath) => IconButton(
          onPressed: context.pushSettings,
          tooltip: context.s.settingsTitle,
          padding: const EdgeInsets.all(Spacing.xxxs),
          icon: AccountStatusAvatar(picturePath: picturePath, radius: _avatarRadius),
        ),
        LocalAccount() || null => IconButton(
          onPressed: context.pushSettings,
          tooltip: context.s.settingsTitle,
          icon: const Icon(Icons.settings_rounded),
        ),
      },
    );
  }
}

class const _StreakButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, Streak?>(
      selector: (state) => switch (state) {
        HomeLoading(:final streak) || HomeLoaded(:final streak) => streak,
        HomeFailure() => null,
      },
      builder: (context, streak) => switch (streak) {
        final streak? => StreakChip(streak: streak, onPressed: () => showStreakSheet(context)),
        null => const SizedBox.shrink(),
      },
    );
  }
}
