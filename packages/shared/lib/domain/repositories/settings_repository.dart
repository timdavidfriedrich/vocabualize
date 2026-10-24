import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';

abstract class SettingsRepository {
  Stream<AppResult<LanguagePair?>> watchLanguagePair();

  Future<AppResult<LanguagePair?>> readLanguagePair();

  Future<AppResult<()>> setLanguagePair(LanguagePair pair);

  AppResult<Language> readDeviceLanguage();
}
