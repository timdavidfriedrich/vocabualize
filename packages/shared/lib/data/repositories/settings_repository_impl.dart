import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/app_info_data_source.dart';
import 'package:shared/data/data_sources/setting_local_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/repositories/settings_repository.dart';

@Injectable(as: SettingsRepository)
class const SettingsRepositoryImpl(
  final SettingLocalDataSource _dataSource,
  final AppInfoDataSource _appInfoDataSource,
) implements SettingsRepository {
  @override
  Stream<AppResult<LanguagePair?>> watchLanguagePair() {
    return _dataSource
        .watchLanguagePair()
        .map((setting) => setting?.toLanguagePair())
        .toAppResult();
  }

  @override
  Future<AppResult<LanguagePair?>> readLanguagePair() async {
    try {
      return Success((await _dataSource.readLanguagePair())?.toLanguagePair());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<()>> setLanguagePair(LanguagePair pair) async {
    try {
      await _dataSource.insertSetting(
        _dataSource.createLanguagePair(
          value: pair.toLocalLanguagePairSetting().toJson(),
          changedAt: DateTime.now(),
        ),
      );
      return const Success(());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  AppResult<Language> readDeviceLanguage() {
    try {
      return Success(_appInfoDataSource.deviceLanguageCode().toLanguage());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }
}
