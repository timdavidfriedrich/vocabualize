import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/app_info_repository.dart';

@injectable
class SystemActionCubit extends Cubit<AppError?> {
  SystemActionCubit(this._appInfoRepository) : super(null);

  final AppInfoRepository _appInfoRepository;

  Future<void> openInternetSettings() => _run(_appInfoRepository.openInternetSettings);

  Future<void> openDateSettings() => _run(_appInfoRepository.openDateSettings);

  Future<void> openStoreListing() => _run(_appInfoRepository.openStoreListing);

  Future<void> _run(Future<AppResult<()>> Function() action) async {
    emit(null);
    emit(switch (await action()) {
      Success() => null,
      Failure(:final error) => error,
    });
  }
}
