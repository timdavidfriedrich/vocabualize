import 'package:core/error/app_result.dart';

abstract class ExternalLinkRepository {
  Future<AppResult<()>> open(String url);
}
