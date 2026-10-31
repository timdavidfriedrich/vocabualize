import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/custom_practice_local_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/custom_practice_mappers.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/domain/repositories/custom_practice_repository.dart';

@Injectable(as: CustomPracticeRepository)
class const CustomPracticeRepositoryImpl(
  final CustomPracticeLocalDataSource _dataSource,
) implements CustomPracticeRepository {
  @override
  Stream<AppResult<CustomPracticeSession?>> watchSession() {
    return _dataSource
        .watchCustomPractice()
        .map((practice) => practice?.toCustomPracticeSession())
        .toAppResult();
  }

  @override
  Future<AppResult<CustomPracticeSession?>> readSession() async {
    try {
      return Success((await _dataSource.readCustomPractice())?.toCustomPracticeSession());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> saveSession(CustomPracticeSession session) async {
    try {
      await _dataSource.saveCustomPractice(session.toLocalCustomPractice());
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> endSession() async {
    try {
      await _dataSource.deleteCustomPractice();
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }
}
