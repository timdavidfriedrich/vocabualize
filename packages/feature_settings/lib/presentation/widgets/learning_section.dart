import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/widgets/settings_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/default_gather_option.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/default_gather_option_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/widgets/app_dropdown.dart';

class const LearningSection({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    return BlocBuilder<PreferencesCubit, Preferences>(
      builder: (context, preferences) => SettingsGroup(
        title: context.s.settingsLearningSectionTitle,
        children: [
          ListTile(
            title: Text(context.s.settingsDefaultGatherTitle),
            subtitle: Text(context.s.settingsDefaultGatherHint),
            trailing: AppDropdown(
              title: context.s.settingsDefaultGatherTitle,
              value: preferences.defaultGatherOption.withImagesHidden(preferences.areImagesHidden),
              options: [
                for (final option in DefaultGatherOption.values)
                  if (option.withImagesHidden(preferences.areImagesHidden) == option) option,
              ],
              labelOf: (option) => option.toLabel(context),
              iconOf: (option) => option.toIcon(),
              onSelected: (option) => bloc.add(SettingsDefaultGatherOptionChanged(option: option)),
            ),
          ),
          SwitchListTile(
            title: Text(context.s.settingsTypeAnswerDisabledTitle),
            subtitle: Text(context.s.settingsTypeAnswerDisabledHint),
            value: preferences.isTypeAnswerDisabled,
            onChanged: (isDisabled) =>
                bloc.add(SettingsTypeAnswerDisabledChanged(isDisabled: isDisabled)),
          ),
          SwitchListTile(
            title: Text(context.s.settingsStrictCorrectionTitle),
            subtitle: Text(context.s.settingsStrictCorrectionHint),
            value: preferences.isStrictCorrectionEnabled,
            onChanged: preferences.isTypeAnswerDisabled
                ? null
                : (isEnabled) => bloc.add(SettingsStrictCorrectionChanged(isEnabled: isEnabled)),
          ),
        ],
      ),
    );
  }
}
