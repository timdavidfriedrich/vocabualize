import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/app_info_data_source.dart';
import 'package:shared/domain/repositories/app_info_repository.dart';

@Injectable(as: AppInfoRepository)
class const AppInfoRepositoryImpl(
  final AppInfoDataSource _dataSource,
) implements AppInfoRepository {
  @override
  Future<AppResult<int>> getBuildNumber() async {
    try {
      return Success(await _dataSource.buildNumber());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<()>> openStoreListing() async {
    try {
      return await _dataSource.openStoreListing()
          ? const Success(())
          : const Failure(UnexpectedError());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<()>> openDateSettings() async {
    try {
      await _dataSource.openDateSettings();
      return const Success(());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<()>> openAppSettings() async {
    try {
      await _dataSource.openAppSettings();
      return const Success(());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }
}
