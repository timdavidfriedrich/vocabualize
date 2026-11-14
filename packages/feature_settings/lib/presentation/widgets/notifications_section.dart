import 'package:core/theme/spacing.dart';
import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/widgets/settings_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_kind.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/reminders/reminder_cubit.dart';

class const NotificationsSection({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<PreferencesCubit, Preferences, (DailyReminder, DailyReminder)>(
      selector: (preferences) => (preferences.practiceReminder, preferences.streakReminder),
      builder: (context, reminders) => BlocBuilder<ReminderCubit, bool>(
        builder: (context, isPermitted) {
          final (practiceReminder, streakReminder) = reminders;
          final isAnyEnabled = practiceReminder.isEnabled || streakReminder.isEnabled;
          return SettingsGroup(
            title: context.s.settingsNotificationsSectionTitle,
            children: [
              _ReminderSettings(
                kind: ReminderKind.practice,
                reminder: practiceReminder,
                title: context.s.settingsPracticeReminderTitle,
                hint: context.s.settingsPracticeReminderHint,
              ),
              _ReminderSettings(
                kind: ReminderKind.streak,
                reminder: streakReminder,
                title: context.s.settingsStreakReminderTitle,
                hint: context.s.settingsStreakReminderHint,
              ),
              if (isAnyEnabled && !isPermitted)
                ListTile(
                  title: Text(context.s.settingsOpenNotificationSettingsButton),
                  subtitle: Text(
                    context.s.settingsNotificationsBlockedMessage,
                    style: context.t.bodyMedium?.copyWith(color: context.c.error),
                  ),
                  trailing: const Icon(Icons.open_in_new_rounded),
                  onTap: () => context.read<SettingsBloc>().add(
                    const SettingsNotificationSettingsOpened(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class const _ReminderSettings({
  required final ReminderKind _kind,
  required final DailyReminder _reminder,
  required final String _title,
  required final String _hint,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: Spacing.tileGap,
      children: [
        SwitchListTile(
          title: Text(_title),
          subtitle: Text(_hint),
          value: _reminder.isEnabled,
          onChanged: (isEnabled) => context.read<SettingsBloc>().add(
            SettingsReminderToggled(kind: _kind, isEnabled: isEnabled),
          ),
        ),
        if (_reminder.isEnabled)
          ListTile(
            title: Text(context.s.settingsReminderTimeTitle),
            trailing: Text(
              TimeOfDay(hour: _reminder.hour, minute: _reminder.minute).format(context),
              style: context.t.bodyLarge,
            ),
            onTap: () => _pickTime(context),
          ),
      ],
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    final bloc = context.read<SettingsBloc>();
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _reminder.hour, minute: _reminder.minute),
    );
    if (time != null) {
      bloc.add(SettingsReminderTimeChanged(kind: _kind, hour: time.hour, minute: time.minute));
    }
  }
}
