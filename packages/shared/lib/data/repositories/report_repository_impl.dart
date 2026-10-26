import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/app_info_data_source.dart';
import 'package:shared/data/data_sources/report_remote_data_source.dart';
import 'package:shared/data/data_sources/setting_local_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/repositories/report_repository.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _unknownLanguagePair = "-";

@Injectable(as: ReportRepository)
class const ReportRepositoryImpl(
  final ReportRemoteDataSource _remoteDataSource,
  final AppInfoDataSource _appInfoDataSource,
  final SettingLocalDataSource _settingDataSource,
) implements ReportRepository {
  @override
  Future<AppResult<()>> sendFeedback(String message) async {
    try {
      await _remoteDataSource.sendFeedback(message: message, context: await _context());
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> sendTranslationReport({
    required String source,
    required String target,
    required LanguagePair languages,
    required String note,
  }) async {
    try {
      await _remoteDataSource.sendTranslationReport(
        source: source,
        target: target,
        sourceLanguage: languages.source.toLanguageCode(),
        targetLanguage: languages.target.toLanguageCode(),
        note: note,
        context: await _context(),
      );
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  Future<RemoteReportContext> _context() async {
    final languagePair = await _readLanguagePair();
    return RemoteReportContext(
      appVersion: await _appInfoDataSource.appVersion(),
      platform: await _appInfoDataSource.platformVersion(),
      appLanguage: _appInfoDataSource.deviceLanguageCode(),
      languagePair: switch (languagePair) {
        LanguagePair(:final source, :final target) =>
          "${source.toLanguageCode()}-${target.toLanguageCode()}",
        null => _unknownLanguagePair,
      },
    );
  }

  Future<LanguagePair?> _readLanguagePair() async {
    try {
      return (await _settingDataSource.readLanguagePair())?.toLanguagePair();
    } on Object {
      return null;
    }
  }
}
