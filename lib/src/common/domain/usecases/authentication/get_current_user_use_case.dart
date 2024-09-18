import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/app_user.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

class GetCurrentUserUseCase {
  final _authenticationRepository = sl.get<AuthenticationRepository>();

  Stream<AppUser?> call() {
    return _authenticationRepository.getCurrentUser();
  }
}
