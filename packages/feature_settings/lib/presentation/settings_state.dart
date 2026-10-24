import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/account.dart';

part 'settings_state.mapper.dart';

@MappableClass()
sealed class SettingsState with SettingsStateMappable {
  const SettingsState();
}

@MappableClass()
class const SettingsLoading() extends SettingsState with SettingsLoadingMappable;

@MappableClass()
class const SettingsLoaded({
  required final Account account,
  required final bool isSigningIn,
  required final AppError? signInError,
}) extends SettingsState with SettingsLoadedMappable;
