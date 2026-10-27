import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/backup_import_status.dart';
import 'package:shared/domain/entities/sign_in_result.dart';

part 'settings_state.mapper.dart';

@MappableEnum()
enum SettingsAction { signIn, signOut, deletion, backupExport, backupImport }

@MappableClass()
sealed class SettingsState with SettingsStateMappable {
  const SettingsState();
}

@MappableClass()
class const SettingsLoading() extends SettingsState with SettingsLoadingMappable;

@MappableClass()
class const SettingsLoaded({
  required final Account account,
  required final SettingsAction? runningAction,
  required final bool isSignOutBlocked,
  required final int? importedCount,
  required final BackupImportRunning? importProgress,
  required final AccountConflict? accountConflict,
  required final AppError? error,
}) extends SettingsState with SettingsLoadedMappable;
