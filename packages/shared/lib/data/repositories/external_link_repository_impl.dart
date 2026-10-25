import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/external_link_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/domain/repositories/external_link_repository.dart';

@Injectable(as: ExternalLinkRepository)
class const ExternalLinkRepositoryImpl(
  final ExternalLinkDataSource _dataSource,
) implements ExternalLinkRepository {
  @override
  Future<AppResult<()>> open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return const Failure(ValidationError());
    try {
      return await _dataSource.open(uri) ? const Success(()) : const Failure(UnexpectedError());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }
}
