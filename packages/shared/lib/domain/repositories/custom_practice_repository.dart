import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/practice_session.dart';

abstract class CustomPracticeRepository {
  Stream<AppResult<CustomPracticeSession?>> watchSession();

  Future<AppResult<CustomPracticeSession?>> readSession();

  Future<AppResult<()>> saveSession(CustomPracticeSession session);

  Future<AppResult<()>> endSession();
}
