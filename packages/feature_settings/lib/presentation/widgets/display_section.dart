import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/widgets/settings_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/appearance_mode.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/presentation/extensions/appearance_mode_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/widgets/app_dropdown.dart';

class const DisplaySection({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    return BlocBuilder<PreferencesCubit, Preferences>(
      builder: (context, preferences) => SettingsGroup(
        title: context.s.settingsDisplaySectionTitle,
        children: [
          ListTile(
            title: Text(context.s.settingsAppearanceTitle),
            subtitle: Text(context.s.settingsAppearanceHint),
            trailing: AppDropdown(
              title: context.s.settingsAppearanceTitle,
              value: preferences.appearanceMode,
              options: AppearanceMode.values,
              labelOf: (mode) => mode.toLabel(context),
              onSelected: (mode) => bloc.add(SettingsAppearanceModeChanged(mode: mode)),
            ),
          ),
          SwitchListTile(
            title: Text(context.s.settingsImagesHiddenTitle),
            subtitle: Text(context.s.settingsImagesHiddenHint),
            value: preferences.areImagesHidden,
            onChanged: (areHidden) => bloc.add(SettingsImagesHiddenChanged(areHidden: areHidden)),
          ),
        ],
      ),
    );
  }
}
